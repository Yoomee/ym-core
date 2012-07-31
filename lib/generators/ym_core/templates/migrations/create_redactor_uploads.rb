class CreateRedactorUploads < ActiveRecord::Migration
  
  def change
    create_table :redactor_uploads do |t|
      t.string :image_uid
      t.timestamps
    end
  end
  
end