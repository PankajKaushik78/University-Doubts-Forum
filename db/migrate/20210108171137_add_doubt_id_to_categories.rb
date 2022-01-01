class AddDoubtIdToCategories < ActiveRecord::Migration[6.1]
  def change
    add_column :categories, :doubt_id, :integer
  end
end
