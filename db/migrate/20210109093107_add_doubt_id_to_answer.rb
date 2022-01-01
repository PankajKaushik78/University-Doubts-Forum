class AddDoubtIdToAnswer < ActiveRecord::Migration[6.1]
  def change
    add_column :answers, :doubt_id, :integer
  end
end
