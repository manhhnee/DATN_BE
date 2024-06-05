class CreateAttendanceTypes < ActiveRecord::Migration[7.1]
  def change
    create_table :attendance_types do |t|
      t.string :type_name
      t.timestamps
    end
  end
end
