class CreatePeople < ActiveRecord::Migration
  def change
    create_table :people do |t|
      t.string :last_name
      t.string :first_name
      t.string :middle_name
      t.date :birthday
      t.integer :created_user
      t.integer :updated_user
      t.references :personable, polymorphic: true, index: true

      t.timestamps
    end
  end
end
