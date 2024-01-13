# frozen_string_literal: true

class CreateBoards < ActiveRecord::Migration[7.1]
  def change
    create_table :boards do |t|
      t.string :name, null: false
      t.string :email, null: false
      t.integer :number_of_mines, null: false
      t.integer :data, array: true, null: false

      t.timestamps
    end
  end
end
