class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :login
      t.string :avatar_url
      t.string :location
      t.string :name
      t.string :email
      t.boolean :published, :default => false
      t.datetime :created_at, :required => false
      t.integer :followers, :default => 0
    end
  end
end
