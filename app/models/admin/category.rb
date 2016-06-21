class Admin::Category < ActiveRecord::Base
  has_attached_file :attachment,
                    :styles => { :mini => '48x48>', :category => '450x360>'},
                    :url => "category/:id/:style/:basename.:extension",
                    :path => ":rails_root/app/assets/images/category/:id/:style/:basename.:extension",
                     :default_style => :large
  validates_attachment :attachment, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end
