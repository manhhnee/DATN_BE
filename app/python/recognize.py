import cv2
import numpy as np
import tensorflow as tf
import mysql.connector


def face_recognition():
    model = tf.keras.models.load_model("app/python/face_recognition_cnn.keras")

    def predict_face(img, model):
        img_height, img_width = 160, 160

        if len(img.shape) == 3:
            img = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)

        img = cv2.resize(img, (img_height, img_width))
        img_np = np.expand_dims(img, axis=-1)
        test_data = np.array([img_np]) / 255.0

        predictions = model.predict(test_data)
        highest_probability = np.max(predictions)
        predicted_class = np.argmax(predictions)
        predicted_class = int(predicted_class)

        return highest_probability, predicted_class

    def draw_boundary(img, classifier, scaleFactor, minNeighbors, color, text, model):
        gray_image = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        features = classifier.detectMultiScale(
            gray_image, scaleFactor, minNeighbors)

        coords = []

        for (x, y, w, h) in features:
            cv2.rectangle(img, (x, y), (x + w, y + h), color, 2)
            face_roi = gray_image[y:y + h, x:x + w]
            confidence, predicted_class = predict_face(face_roi, model)
            print(confidence, predicted_class)

            if confidence > 0.65:
                mydb = mysql.connector.connect(
                    host="localhost",
                    user="root",
                    passwd="Manhcute@258",
                    database="timekeeping_dev"
                )
                mycursor = mydb.cursor()
                mycursor.execute(
                    "SELECT first_name FROM users WHERE id = %s", (predicted_class,))
                row = mycursor.fetchone()
                if row is not None:
                    name = row[0]
                    cv2.putText(img, name + ' | ' + str(predicted_class), (x - 10, y - 10), cv2.FONT_HERSHEY_SIMPLEX,
                                0.8, (153, 255, 255), 2, cv2.LINE_AA)

            else:
                cv2.putText(img, 'UNKNOWN', (x, y - 5),
                            cv2.FONT_HERSHEY_SIMPLEX, 0.8, (0, 0, 255), 2, cv2.LINE_AA)

            coords = [x, y, w, h]
        return coords

    def recognize(img, model, faceCascade):
        coords = draw_boundary(img, faceCascade, 1.1, 10,
                               (255, 255, 0), "Face", model)
        return img

    faceCascade = cv2.CascadeClassifier(
        cv2.data.haarcascades + 'haarcascade_frontalface_default.xml')
    wCam, hCam = 400, 400

    cap = cv2.VideoCapture(0)
    cap.set(3, wCam)
    cap.set(4, hCam)

    while True:
        ret, img = cap.read()
        if not ret:
            break
        img = recognize(img, model, faceCascade)
        cv2.imshow('Face Cropper', img)
        if cv2.waitKey(1) == 13:
            break

    cap.release()
    cv2.destroyAllWindows()


if __name__ == "__main__":
    face_recognition()
