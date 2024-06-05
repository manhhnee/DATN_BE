import os
import numpy as np
import tensorflow as tf
from tensorflow.keras.models import Sequential
from tensorflow.keras.layers import Conv2D, MaxPooling2D, Flatten, Dense, Dropout, BatchNormalization
from tensorflow.keras.callbacks import ModelCheckpoint, EarlyStopping, ReduceLROnPlateau
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from PIL import Image
import random

os.environ['PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION'] = 'python'


def train_classifier():
    dataset_dir = "dataset"

    img_height, img_width = 160, 160
    batch_size = 32
    faces = []
    ids = []

    # Prepare the dataset
    for file in os.listdir(dataset_dir):
        if file.endswith(".jpg"):
            id_str = file.split(".")[0]
            if id_str.isdigit():
                id = int(id_str)
                img_path = os.path.join(dataset_dir, file)
                img = Image.open(img_path).convert('L')
                img = img.resize((img_height, img_width))
                img_np = np.array(img)
                img_np = np.expand_dims(img_np, axis=-1)
                faces.append(img_np)
                ids.append(id)

    # Ensure data is not empty
    if not faces or not ids:
        print("No data found.")
        return

    # Shuffle the data
    combined = list(zip(faces, ids))
    random.shuffle(combined)
    faces[:], ids[:] = zip(*combined)

    faces = np.array(faces)
    ids = np.array(ids)

    # Normalize the dataset
    faces = faces / 255.0

    # Convert labels to one-hot encoding
    num_classes = np.max(ids) + 1
    ids = tf.keras.utils.to_categorical(ids, num_classes=num_classes)

    # Data augmentation
    datagen = ImageDataGenerator(
        rotation_range=20,
        width_shift_range=0.2,  # Reduced value for less shifting
        height_shift_range=0.2,  # Reduced value for less shifting
        shear_range=0.2,
        zoom_range=0.2,
        horizontal_flip=True,
        vertical_flip=True,  # Added vertical flip
        fill_mode='nearest',  # Added filling mode
        validation_split=0.2
    )

    # Define CNN model with more complexity
    def create_cnn_model(input_shape, num_classes):
        model = Sequential()
        model.add(Conv2D(32, (3, 3), activation='relu', input_shape=input_shape,
                         kernel_regularizer=tf.keras.regularizers.l2(0.001)))
        model.add(MaxPooling2D((2, 2)))
        model.add(Dropout(0.25))
        model.add(Conv2D(64, (3, 3), activation='relu',
                         kernel_regularizer=tf.keras.regularizers.l2(0.001)))
        model.add(MaxPooling2D((2, 2)))
        model.add(Dropout(0.25))
        # You can add more convolutional layers here with different hyperparameters

        model.add(Flatten())
        model.add(Dense(256, activation='relu',
                        kernel_regularizer=tf.keras.regularizers.l2(0.001)))
        model.add(Dropout(0.5))
        model.add(Dense(num_classes, activation='softmax'))
        return model

    input_shape = (img_height, img_width, 1)
    model = create_cnn_model(input_shape, num_classes)

    model.compile(optimizer='adam',
                  loss='categorical_crossentropy', metrics=['accuracy'])

    # Callbacks
    reduce_lr = ReduceLROnPlateau(
        monitor='val_loss', factor=0.2, patience=3, min_lr=0.0001)

    # Train the model
    train_generator = datagen.flow(
        faces, ids, batch_size=batch_size, subset='training')
    validation_generator = datagen.flow(
        faces, ids, batch_size=batch_size, subset='validation')

    history = model.fit(train_generator, epochs=100, validation_data=validation_generator,
                        callbacks=[reduce_lr])

    np.save('app/python/history.npy', history.history)

    model.save('app/python/face_recognition_cnn.keras')


if __name__ == "__main__":
    train_classifier()
