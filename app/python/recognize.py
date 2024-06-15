import cv2
import numpy as np
import tensorflow as tf
from tensorflow.keras.applications.resnet import preprocess_input


def face_recognition(image_path):
    # Load the CNN model for face recognition
    model = tf.keras.models.load_model(
        "app/python/face_recognition_resnet.keras")

    def predict_face(img, model):
        img_height, img_width = 160, 160
        img_rgb = cv2.cvtColor(img, cv2.COLOR_GRAY2RGB)  # Convert to RGB
        img_resized = cv2.resize(
            img_rgb, (img_width, img_height))  # Resize image
        img_np = np.expand_dims(img_resized, axis=0)
        img_np = preprocess_input(img_np)

        predictions = model.predict(img_np, verbose=0)
        highest_probability = np.max(predictions)
        predicted_class = np.argmax(predictions)
        return highest_probability, int(predicted_class)

    def draw_boundary(img, classifier, scaleFactor, minNeighbors, color, model):
        gray_image = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        faces = classifier.detectMultiScale(
            gray_image, scaleFactor, minNeighbors)
        for (x, y, w, h) in faces:
            cv2.rectangle(img, (x, y), (x + w, y + h), color, 2)
            face_roi = gray_image[y:y + h, x:x + w]
            confidence, predicted_class = predict_face(face_roi, model)
            if (confidence) > 0.9:
                print(f"{predicted_class}")

    def recognize(img, model, faceCascade):
        draw_boundary(img, faceCascade, scaleFactor=1.1,
                      minNeighbors=5, color=(255, 255, 0), model=model)
        return img

    faceCascade = cv2.CascadeClassifier(
        cv2.data.haarcascades + 'haarcascade_frontalface_alt.xml')

    img = cv2.imread(image_path)
    if img is None:
        print(f"Error: Unable to read image '{image_path}'")
        return

    recognized_img = recognize(img, model, faceCascade)
    cv2.imwrite("tmp/recognized.jpg", recognized_img)


if __name__ == "__main__":
    import sys

    if len(sys.argv) < 2:
        print("Usage: python3 recognize.py <image_path>")
        sys.exit(1)

    image_path = sys.argv[1]
    face_recognition(image_path)
