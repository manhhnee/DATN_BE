class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone_number
      t.date :date_of_birth
      t.string :email
      t.string :password_digest
      t.string :role
      t.bigint :department_id

      t.timestamps
    end
  end
end
