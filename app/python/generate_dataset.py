import cv2
import mysql.connector
import sys
import base64
import numpy as np


def generate_dataset(user_id, frame, image_data):
    face_classifier = cv2.CascadeClassifier(
        "/home/manh/Documents/Workspace/DATN/DATN/resources/haarcascade_frontalface_alt.xml")

    def face_cropped(img):
        gray = cv2.cvtColor(img, cv2.COLOR_BGR2GRAY)
        faces = face_classifier.detectMultiScale(gray, 1.1, 5)
        if len(faces) == 0:
            return None
        for (x, y, w, h) in faces:
            cropped_face = img[y:y + h, x:x + w]
        return cropped_face

    # Decode image from base64
    img_data = base64.b64decode(image_data)
    np_arr = np.frombuffer(img_data, np.uint8)
    img = cv2.imdecode(np_arr, cv2.IMREAD_COLOR)
    if img is None:
        print("Error: Could not decode the image.")
        return

    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="Manhcute@258",
        database="timekeeping_dev"
    )
    mycursor = mydb.cursor()
    mycursor.execute("SELECT IFNULL(MAX(id), 0) FROM face_data")
    row = mycursor.fetchone()
    lastid = row[0]

    img_id = lastid + 1

    if face_cropped(img) is not None:
        face = cv2.resize(face_cropped(img), (200, 200))
        face = cv2.cvtColor(face, cv2.COLOR_BGR2GRAY)

        file_name_path = f"dataset/{user_id}.{img_id}.jpg"
        cv2.imwrite(file_name_path, face)

        mycursor.execute(
            "INSERT INTO `face_data` (`id`, `user_id`) VALUES (%s, %s)", (img_id, user_id))
        mydb.commit()

    mycursor.close()
    mydb.close()
    print(f"{img_id}")


if __name__ == "__main__":
    if len(sys.argv) > 3:
        user_id = sys.argv[1]
        frame = sys.argv[2]
        image_data = sys.argv[3]
    else:
        print("No user_id, frame or image_data provided as command-line argument")
        sys.exit(1)

    generate_dataset(user_id, frame, image_data)
