import cv2
import numpy as np
import tensorflow as tf
from tensorflow.keras.applications.resnet import preprocess_input
from flask import Flask, request, jsonify
from flask_cors import CORS
import base64
import os

app = Flask(__name__)
CORS(app)

# Load the CNN model for face recognition
model = tf.keras.models.load_model("app/python/face_recognition_resnet.keras")


def predict_face(img, model):
    img_height, img_width = 160, 160
    img_rgb = cv2.cvtColor(img, cv2.COLOR_GRAY2RGB)  # Convert to RGB
    img_resized = cv2.resize(img_rgb, (img_width, img_height))  # Resize image
    img_np = np.expand_dims(img_resized, axis=0)
    img_np = preprocess_input(img_np)

    predictions = model.predict(img_np, verbose=0)
    highest_probability = np.max(predictions)
    predicted_class = np.argmax(predictions)
    return highest_probability, int(predicted_class)


def draw_boundary(img, classifier, scaleFactor, minNeighbors, color, model):
    gray_image = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
    faces = classifier.detectMultiScale(gray_image, scaleFactor, minNeighbors)
    results = []
    for (x, y, w, h) in faces:
        cv2.rectangle(img, (x, y), (x + w, y + h), color, 2)
        face_roi = gray_image[y:y + h, x:x + w]
        confidence, predicted_class = predict_face(face_roi, model)
        if confidence > 0.9:
            results.append({
                "class": predicted_class,
                "confidence": float(confidence)
            })
    return img, results


def recognize(image_path):
    faceCascade = cv2.CascadeClassifier(
        cv2.data.haarcascades + 'haarcascade_frontalface_alt.xml')
    img = cv2.imread(image_path)
    if img is None:
        raise ValueError(f"Error: Unable to read image '{image_path}'")

    recognized_img, results = draw_boundary(
        img, faceCascade, scaleFactor=1.1, minNeighbors=5, color=(255, 255, 0), model=model)
    output_path = "tmp/recognized.jpg"
    cv2.imwrite(output_path, recognized_img)
    return output_path, results


@app.route('/recognize', methods=['POST'])
def recognize_api():
    data = request.get_json()
    image_data = data['image']
    image_path = "tmp/recognize.jpg"

    # Decode the base64 image data and save it to a file
    with open(image_path, "wb") as file:
        file.write(base64.b64decode(image_data.split(",")[1]))

    try:
        output_path, results = recognize(image_path)
        # Read the output image in base64 format to send back
        with open(output_path, "rb") as file:
            recognized_image_data = base64.b64encode(
                file.read()).decode('utf-8')

        response = {
            "status": "success",
            "message": "Face recognition performed successfully",
            "recognized_image": "data:image/jpeg;base64," + recognized_image_data,
            "results": results  # Include the results in the response
        }
    except Exception as e:
        response = {
            "status": "error",
            "message": str(e)
        }

    return jsonify(response)


if __name__ == '__main__':
    os.makedirs("tmp", exist_ok=True)
    app.run(host='0.0.0.0', port=4000, debug=True)
