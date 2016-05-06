class CreateUserSights < ActiveRecord::Migration
  def change
    create_table :user_sights do |t|
      t.integer :user_id
      t.integer :sight_id
    end
  end
end
