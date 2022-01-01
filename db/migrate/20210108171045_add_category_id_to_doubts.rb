class AddCategoryIdToDoubts < ActiveRecord::Migration[6.1]
  def change
    add_column :doubts, :category_id, :integer
  end
end

