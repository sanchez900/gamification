class CreateAbouts < ActiveRecord::Migration
  def change
    create_table :abouts do |t|
      t.string :info

      t.timestamps
    end
  end
end
