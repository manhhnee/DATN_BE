class AddBasicSalaryUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :basic_salary, :decimal, precision: 10, scale: 2
  end
end
