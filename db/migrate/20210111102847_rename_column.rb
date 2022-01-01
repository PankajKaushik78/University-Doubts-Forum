class RenameColumn < ActiveRecord::Migration[6.1]
  def change
    rename_column :assistants, :average_time, :total_time
  end
end
