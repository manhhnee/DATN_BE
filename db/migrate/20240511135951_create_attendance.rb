class CreateAttendance < ActiveRecord::Migration[7.1]
  def change
    create_table :attendances do |t|
      t.date :date
      t.time :time_in
      t.time :time_out
      t.bigint :user_id
      t.bigint :attendance_type_id
      t.timestamp :created_at
    end
  end
end
