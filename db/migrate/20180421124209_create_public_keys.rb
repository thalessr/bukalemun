# frozen_string_literal: true

class CreatePublicKeys < ActiveRecord::Migration[5.1]

  def change
    create_table :public_keys do |t|
      t.belongs_to :user, index: true, foreign_key: { to_table: :users }, null: false
      t.text :key
      t.json :data

      t.timestamps
    end
  end

end
