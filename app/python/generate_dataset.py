import cv2
import mysql.connector
import sys
import os


def generate_dataset(user_id, frame):
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

    # Read the temporary saved image
    img_path = f"tmp/{user_id}_{frame}.jpg"
    img = cv2.imread(img_path)
    if img is None:
        print("Error: Could not read the image.")
        return

    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        passwd="Manhcute@258",
        database="timekeeping_dev"
    )
    mycursor = mydb.cursor()
    mycursor.execute("select ifnull(max(id), 0) from face_data")
    row = mycursor.fetchone()
    lastid = row[0]

    img_id = lastid + 1

    if face_cropped(img) is not None:
        face = cv2.resize(face_cropped(img), (200, 200))
        face = cv2.cvtColor(face, cv2.COLOR_BGR2GRAY)

        file_name_path = f"dataset/{user_id}.{img_id}.jpg"
        cv2.imwrite(file_name_path, face)

        mycursor.execute("""INSERT INTO `face_data` (`id`, `user_id`) VALUES
                            ('{}', '{}')""".format(img_id, user_id))
        mydb.commit()

    mycursor.close()
    mydb.close()
    os.remove(img_path)
    print(f"Frame {frame}: Dataset generated successfully.")


if __name__ == "__main__":
    if len(sys.argv) > 2:
        user_id = sys.argv[1]
        frame = sys.argv[2]
    else:
        print("No user_id or frame provided as command-line argument")
        sys.exit(1)

    generate_dataset(user_id, frame)
