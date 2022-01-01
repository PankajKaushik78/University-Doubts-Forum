class AddUserIdToAssistant < ActiveRecord::Migration[6.1]
  def change
    add_column :assistants, :user_id, :integer
  end
end
