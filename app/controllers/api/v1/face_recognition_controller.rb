# frozen_string_literal: true
module Api
  module V1
    class FaceRecognitionController < ApplicationController
      require "open3"
      require "base64"

      def generate_dataset
        user_id = params[:user_id]
        image_data = params[:image]
        frame = params[:frame]

        image_data = image_data.split(",")[1]
        image = Base64.decode64(image_data)

        File.open("tmp/#{user_id}_#{frame}.jpg", "wb") do |file|
          file.write(image)
        end

        command = "python3 app/python/generate_dataset.py #{user_id} #{frame}"
        output, status = Open3.capture2(command)

        if status.success?
          render json: { status: "success", message: "Dataset generated successfully", output: }
        else
          render json: { status: "error", message: "Failed to generate dataset", output: }
        end
      end

      def train_classifier
        command = "python3 app/python/train_classifier.py"
        output, status = Open3.capture2(command)

        if status.success?
          render json: { status: "success", message: "Classifier trained successfully", output: }
        else
          render json: { status: "error", message: "Failed to train classifier", output: }
        end
      end

      def recognize
        command = "python3 app/python/recognize.py"
        output, status = Open3.capture2(command)

        if status.success?
          render json: { status: "success", message: "Face recognition performed successfully", output: }
        else
          render json: { status: "error", message: "Failed to perform face recognition", output: }
        end
      end
    end
  end
end
