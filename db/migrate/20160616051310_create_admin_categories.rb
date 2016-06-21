class CreateAdminCategories < ActiveRecord::Migration
  def change
    create_table :admin_categories do |t|
      t.string :title
      t.attachment :attachment
      t.string :target_url
      t.timestamps null: false
    end
  end
end
