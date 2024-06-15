import os
import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Flatten, Dense, Dropout
from tensorflow.keras.callbacks import ModelCheckpoint, EarlyStopping, ReduceLROnPlateau
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from tensorflow.keras.applications import ResNet50
from tensorflow.keras.applications.resnet import preprocess_input
from PIL import Image
import random

os.environ['CUDA_VISIBLE_DEVICES'] = '-1'
os.environ['PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION'] = 'python'


def train_classifier():
    dataset_dir = "dataset"
    img_height, img_width = 160, 160
    batch_size = 32
    faces = []
    ids = []

    for file in os.listdir(dataset_dir):
        if file.endswith(".jpg"):
            id_str = file.split(".")[0]
            if id_str.isdigit():
                id = int(id_str)
                img_path = os.path.join(dataset_dir, file)
                img = Image.open(img_path).convert('RGB')
                img = img.resize((img_height, img_width))
                img_np = np.array(img)
                faces.append(img_np)
                ids.append(id)

    if not faces or not ids:
        print("No data found.")
        return

    combined = list(zip(faces, ids))
    random.shuffle(combined)
    faces[:], ids[:] = zip(*combined)

    faces = np.array(faces)
    ids = np.array(ids)
    num_classes = np.max(ids) + 1
    ids = tf.keras.utils.to_categorical(ids, num_classes=num_classes)

    datagen = ImageDataGenerator(
        preprocessing_function=preprocess_input,
        rotation_range=20,
        width_shift_range=0.2,
        height_shift_range=0.2,
        shear_range=0.2,
        zoom_range=0.2,
        horizontal_flip=True,
        vertical_flip=True,
        validation_split=0.2
    )

    def create_resnet_model(input_shape, num_classes):
        base_model = ResNet50(
            include_top=False, weights='imagenet', input_shape=input_shape)
        base_model.trainable = False

        model = Sequential([
            base_model,
            Flatten(),
            Dense(256, activation='relu'),
            Dropout(0.5),
            Dense(num_classes, activation='softmax')
        ])
        return model

    input_shape = (img_height, img_width, 3)
    model = create_resnet_model(input_shape, num_classes)

    model.compile(optimizer='adam',
                  loss='categorical_crossentropy', metrics=['accuracy'])

    reduce_lr = ReduceLROnPlateau(
        monitor='val_loss', factor=0.2, patience=3, min_lr=0.0001)

    train_generator = datagen.flow(
        faces, ids, batch_size=batch_size, subset='training')
    validation_generator = datagen.flow(
        faces, ids, batch_size=batch_size, subset='validation')

    history = model.fit(train_generator, epochs=50, validation_data=validation_generator,
                        callbacks=[reduce_lr])

    np.save('app/python/history.npy', history.history)
    model.save('app/python/face_recognition_resnet.keras')


if __name__ == "__main__":
    train_classifier()
