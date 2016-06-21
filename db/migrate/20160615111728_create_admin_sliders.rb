class CreateAdminSliders < ActiveRecord::Migration
  def change
    create_table :admin_sliders do |t|
      t.string :title
      t.text :description
      t.attachment :attachment
      t.string :target_url
      t.timestamps null: false
    end
  end
end
