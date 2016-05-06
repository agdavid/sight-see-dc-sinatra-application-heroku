class CreateSights < ActiveRecord::Migration
  def change
    create_table :sights do |t|
      t.string :name
      t.string :description
    end
  end
end
