class CreateSalaries < ActiveRecord::Migration[7.1]
  def change
    create_table :salaries do |t|
      t.references :user, null: false, foreign_key: true
      t.date :date, null: false
      t.decimal :total_salary, precision: 10, scale: 2, default: 0.0

      t.timestamps
    end
    add_index :salaries, [:user_id, :date]
  end
end
