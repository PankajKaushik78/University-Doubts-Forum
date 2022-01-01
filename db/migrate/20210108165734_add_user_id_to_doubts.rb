class AddUserIdToDoubts < ActiveRecord::Migration[6.1]
  def change
    add_column :doubts, :user_id, :integer
  end
end
