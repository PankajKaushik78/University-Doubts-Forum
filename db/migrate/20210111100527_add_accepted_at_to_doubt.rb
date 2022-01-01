class AddAcceptedAtToDoubt < ActiveRecord::Migration[6.1]
  def change
    add_column :doubts, :accepted_at, :datetime, precision: 6
  end
end
