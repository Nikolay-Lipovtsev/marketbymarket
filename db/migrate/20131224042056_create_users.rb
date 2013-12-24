class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.integer :project_id
      t.string :email
      t.string :password_digest
      t.integer :created_user
      t.integer :updated_user

      t.timestamps
    end
    add_index :users, :project_id
    add_index :users, :email, unique: true
  end
end
