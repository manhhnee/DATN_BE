class CreateHolidays < ActiveRecord::Migration[7.1]
  def change
    create_table :holidays do |t|

      t.date :holiday_date
      t.string :description
      t.timestamp :created_at
    end
  end
end
