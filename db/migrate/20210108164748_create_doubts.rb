class CreateDoubts < ActiveRecord::Migration[6.1]
  def change
    create_table :doubts do |t|
      t.string :title
      t.text :description
      t.boolean :is_resolved
      t.integer :escalate_count

      t.timestamps
    end
  end
end
