# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.1]

  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :password_digest, null: false, index: true
      t.string :auth_token, null: false
      t.json :data

      t.index :auth_token, unique: true
      t.index :username, unique: true
      t.timestamps
    end
  end

end
