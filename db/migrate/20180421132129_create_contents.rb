class CreateContents < ActiveRecord::Migration[5.1]
  def change
    create_table :contents do |t|
      t.belongs_to :owner, index: true, foreign_key: { to_table: :users }, null: false
      t.belongs_to :recipient, index: true, foreign_key: { to_table: :users }, null: false
      t.text :message
      t.json :data

      t.timestamps
    end
  end
end
