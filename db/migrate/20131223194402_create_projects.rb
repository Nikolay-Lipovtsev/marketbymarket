class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.integer :created_user
      t.integer :updated_user

      t.timestamps
    end
    add_index :projects, :name, unique: true
  end
end
