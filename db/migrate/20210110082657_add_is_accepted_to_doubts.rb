class AddIsAcceptedToDoubts < ActiveRecord::Migration[6.1]
  def change
    add_column :doubts, :is_accepted, :boolean, default: false
  end
end
