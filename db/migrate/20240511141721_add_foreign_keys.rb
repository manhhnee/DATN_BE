class AddForeignKeys < ActiveRecord::Migration[7.1]
  def change
    # Users table
    add_foreign_key :users, :departments, column: :department_id

    # Attendance table
    add_foreign_key :attendances, :users, column: :user_id
    add_foreign_key :attendances, :attendance_types, column: :attendance_type_id

    # FaceData table
    add_foreign_key :face_data, :users, column: :user_id
  end
end
