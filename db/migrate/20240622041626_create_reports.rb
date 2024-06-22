class CreateReports < ActiveRecord::Migration[7.1]
  def change
    create_table :reports do |t|
      t.references :user, foreign_key: true, null: false
      t.date :date, null: false
      t.references :attendance_type, foreign_key: true, null: false
      t.time :time_check
      t.boolean :approved, default: false
      t.string :reason

      t.timestamps
    end
  end
end
