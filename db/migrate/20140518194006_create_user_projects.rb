class CreateUserProjects < ActiveRecord::Migration
  def change
    create_table :user_projects do |t|
      t.belongs_to :user
      t.belongs_to :project
      t.integer :created_user
      t.integer :updated_user

      t.timestamps
    end
  end
end
