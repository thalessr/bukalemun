# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[5.1]

  def change
    create_table :users do |t|
      t.string :username, null: false, index: true
      t.string :password_digest, null: false, index: true
      t.json :data

      t.timestamps
    end
  end

end
