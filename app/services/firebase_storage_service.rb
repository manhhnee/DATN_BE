# app/services/firebase_storage_service.rb

class FirebaseStorageService
  def initialize
    FirebaseAdmin::App.initialize!(
      project_id: "facerecognition-9e340",
      credentials: Rails.root.join("config/facerecognition-9e340-firebase-adminsdk-ixku1-2d34fa60f2.json").to_s
    )
    @bucket = FirebaseAdmin::Storage.bucket
  end

  def upload(file_path, _file)
    file_name = File.basename(file_path)
    file_object = @bucket.create_file(file_path, file_name)
    file_object.public_url
  end

  def download(file_name, destination)
    file = @bucket.file(file_name)
    file.download(destination)
  end
end
