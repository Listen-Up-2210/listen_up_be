# frozen_string_literal: true

class CreateLeaderboard < ActiveRecord::Migration[5.2]
  def change
    create_table :leaderboards do |t|
      t.string :name
      t.integer :score
      t.string :category
      t.string :difficulty
      t.timestamps
    end
  end
end
