class CreateConversations < ActiveRecord::Migration[7.1]
  def change
    create_table :conversations do |t|
      t.references :participant1, null: false, foreign_key: { to_table: :users }
      t.references :participant2, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
