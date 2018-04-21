# frozen_string_literal: true

class CreateEncryptedPrivateKeys < ActiveRecord::Migration[5.1]

  def change
    create_table :encrypted_private_keys do |t|
      t.belongs_to :user, index: true, foreign_key: { to_table: :users }, null: false
      t.text :key, null: false
      t.json :data

      t.timestamps
    end
  end

end
