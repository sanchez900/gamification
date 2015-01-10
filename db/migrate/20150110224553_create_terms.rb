class CreateTerms < ActiveRecord::Migration
  def change
    create_table :terms do |t|
      t.string :info

      t.timestamps
    end
  end
end
