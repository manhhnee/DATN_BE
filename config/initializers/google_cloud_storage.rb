# app/services/google_cloud_storage_service.rb

require "google/cloud/storage"

class GoogleCloudStorageService
  def initialize
    credentials_path = Rails.root.join("config", "face-recognition-426413-1260baff6373.json")
    @storage = Google::Cloud::Storage.new(project_id: "face-recognition-426413", credentials: credentials_path)
    @bucket = @storage.bucket("face-recognition-258")
  end

  def upload(file_path, file)
    file_name = File.basename(file_path)
    file = @bucket.create_file(file.path, file_name)
    file_url(file_name)
  end

  def download(file_name, destination)
    file = @bucket.file(file_name)
    file.download(destination)
  end

  private

  def file_url(file_name)
    "https://storage.googleapis.com/face-recognition-258/#{file_name}"
  end
end
