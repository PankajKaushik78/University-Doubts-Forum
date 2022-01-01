class ChangeColumnDefault < ActiveRecord::Migration[6.1]
  def change
    change_column_default :doubts, :category_id, 0
  end
end
