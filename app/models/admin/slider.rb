class Admin::Slider < ActiveRecord::Base
  has_attached_file :attachment,
                    :styles => { :mini => '48x48>', :slider => '1300x550>'},
                    :url => "slider/:id/:style/:basename.:extension",
                    :path => ":rails_root/app/assets/images/slider/:id/:style/:basename.:extension",
                     :default_style => :large
  validates_attachment :attachment, content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] }
end