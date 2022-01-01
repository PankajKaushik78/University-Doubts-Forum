class AddDesignationToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :designation, :integer, default: 0
  end
end
