json.array!(@admin_sliders) do |admin_slider|
  json.extract! admin_slider, :id
  json.url admin_slider_url(admin_slider, format: :json)
end
