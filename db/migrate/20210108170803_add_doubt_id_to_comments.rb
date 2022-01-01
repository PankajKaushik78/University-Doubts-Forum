class AddDoubtIdToComments < ActiveRecord::Migration[6.1]
  def change
    add_column :comments, :doubt_id, :integer
  end
end
