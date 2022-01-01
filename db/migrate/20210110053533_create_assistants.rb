class CreateAssistants < ActiveRecord::Migration[6.1]
  def change
    create_table :assistants do |t|
      t.integer :doubts, default: 0
      t.integer :escalated, default: 0

      t.timestamps
    end
  end
end
