class CreateDepartments < ActiveRecord::Migration[7.1]
  def change
    create_table :departments do |t|
      t.string :department_name
      t.timestamp :created_at
    end
  end
end
