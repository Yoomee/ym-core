class CreateResources < ActiveRecord::Migration
  
  def change
    create_table :resources do |t|
      t.string :name
      t.text :text
    end
  end
  
end
