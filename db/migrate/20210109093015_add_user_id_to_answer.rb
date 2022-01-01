class AddUserIdToAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :user_id, :integer
  end
end
