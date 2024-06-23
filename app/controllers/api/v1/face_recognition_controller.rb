# frozen_string_literal: true
module Api
  module V1
    class FaceRecognitionController < ApplicationController
      require "open3"
      require "base64"

      def generate_dataset
        user_id = params[:user_id]
        frame = params[:frame]
        image_data = params[:image]

        begin
          command = "myenv/bin/python3 app/python/generate_dataset.py #{user_id} #{frame} #{image_data}"
          output, status = Open3.capture2(command)

          output = output.strip

          if status.success?
            processed_file_path = Rails.root.join("dataset", "#{user_id}.#{output}.jpg")
            render json: { status: "success", message: "Dataset generated successfully", file_path: processed_file_path.to_s, output: }
          else
            render json: { status: "error", message: "Failed to process dataset", output: }
          end
        rescue StandardError => e
          render json: { status: "error", message: "Failed to generate dataset: #{e.message}" }
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
        image_data = params[:image]
        image_path = "tmp/recognize.jpg"

        # Decode the base64 image data and save it to a file
        File.open(image_path, "wb") do |file|
          file.write(Base64.decode64(image_data.split(",")[1]))
        end

        # Construct the command with the correct image_path
        command = "myenv/bin/python3 app/python/recognize.py #{image_path}"
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
