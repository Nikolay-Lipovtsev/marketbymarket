class CreateProjectUsers < ActiveRecord::Migration
  def change
    create_table :project_users do |t|
      t.integer :user_id
      t.integer :project_id
      t.integer :created_user
      t.integer :updated_user

      t.timestamps
    end
  end
end
