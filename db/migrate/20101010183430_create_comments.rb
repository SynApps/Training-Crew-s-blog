class CreateComments < ActiveRecord::Migration
  def self.up
    create_table :comments do |t|
      t.string :user
      t.string :website
      t.text :text

      t.timestamps
    end
  end

  def self.down
    drop_table :comments
  endrake 
end