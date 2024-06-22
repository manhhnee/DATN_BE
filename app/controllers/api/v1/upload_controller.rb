# app/controllers/api/v1/upload_controller.rb

class Api::V1::UploadController < ApplicationController
  def upload_file
    uploaded_file = params[:file]
    file_path = Rails.root.join("tmp", uploaded_file.original_filename).to_s

    # Lưu file vào đường dẫn tạm thời
    File.open(file_path, "wb") do |file|
      file.write(uploaded_file.read)
    end

    storage_service = GoogleCloudStorageService.new

    begin
      public_url = storage_service.upload(file_path, File.open(file_path, "rb"))
      File.delete(file_path) if File.exist?(file_path)

      render json: { status: "success", message: "File uploaded successfully", url: public_url }
    rescue StandardError => e
      render json: { status: "error", message: "Failed to upload file: #{e.message}" }
    end
  end
end
