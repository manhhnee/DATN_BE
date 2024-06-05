class RemoveFaceImageFromFaceData < ActiveRecord::Migration[7.1]
  def change
    remove_column :face_data, :face_image, :integer
  end
end
