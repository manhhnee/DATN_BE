import matplotlib.pyplot as plt
import numpy as np
import os
import tensorflow as tf
from tensorflow.keras.models import load_model
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from PIL import Image


def load_dataset(dataset_dir, img_height=160, img_width=160):
    faces = []
    ids = []

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

    faces = np.array(faces)
    ids = np.array(ids)

    # Normalize the dataset
    faces = faces / 255.0

    # Convert labels to one-hot encoding
    num_classes = np.max(ids) + 1
    ids = tf.keras.utils.to_categorical(ids, num_classes=num_classes)

    return faces, ids, num_classes


def plot_training_history(history, output_path='app/python/training_history.png'):
    # Assuming the training history is saved in 'history.npy'
    history = np.load('app/python/history.npy', allow_pickle=True).item()
    # Plot training & validation accuracy values
    plt.figure(figsize=(12, 4))
    plt.subplot(1, 2, 1)
    plt.plot(history['accuracy'])
    plt.plot(history['val_accuracy'])
    plt.title('Model accuracy')
    plt.ylabel('Accuracy')
    plt.xlabel('Epoch')
    plt.legend(['Train', 'Validation'], loc='upper left')

    # Plot training & validation loss values
    plt.subplot(1, 2, 2)
    plt.plot(history['loss'])
    plt.plot(history['val_loss'])
    plt.title('Model loss')
    plt.ylabel('Loss')
    plt.xlabel('Epoch')
    plt.legend(['Train', 'Validation'], loc='upper left')

    plt.savefig(output_path)
    plt.close()


def evaluate_model(model_path, dataset_dir):
    img_height, img_width = 160, 160
    batch_size = 32

    # Load the dataset
    faces, ids, num_classes = load_dataset(dataset_dir, img_height, img_width)

    # Data augmentation
    datagen = ImageDataGenerator(
        rotation_range=20,
        width_shift_range=0.3,
        height_shift_range=0.3,
        zoom_range=0.3,
        horizontal_flip=True,
        validation_split=0.2
    )

    # Load the model
    model = load_model(model_path)

    # Evaluate the model
    validation_generator = datagen.flow(
        faces, ids, batch_size=batch_size, subset='validation')
    val_loss, val_accuracy = model.evaluate(validation_generator)
    print(f"Validation accuracy: {val_accuracy}")

    # Assuming the training history is saved in 'history.npy'
    history = np.load('app/python/history.npy', allow_pickle=True).item()

    # Plot and save the training history
    plot_training_history(history, 'app/python/training_history.png')


if __name__ == "__main__":
    model_path = "app/python/face_recognition_cnn.keras"
    dataset_dir = "/home/manh/Documents/Workspace/DATN/DATN/dataset"
    evaluate_model(model_path, dataset_dir)
