class ModifyAttendancesTable < ActiveRecord::Migration[7.1]
  def change
    remove_column :attendances, :time_in, :time
    remove_column :attendances, :time_out, :time
    add_column :attendances, :time_check, :time
  end
end
