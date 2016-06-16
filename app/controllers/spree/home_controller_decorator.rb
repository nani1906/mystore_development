require 'spree/base_controller'
Spree::HomeController.class_eval do
  helper 'spree/products'
  respond_to :html
  def index
    @searcher = build_searcher(params.merge(include_images: true))
    @products = @searcher.retrieve_products
    @taxonomies = Spree::Taxonomy.includes(root: :children)
    # @taxonomies = Spree::Taxonomy.accessible_by(current_ability, :read).order('name').includes(:root => :children)
    @admin_sliders =  Admin::Slider.all
    @admin_categories =  Admin::Category.all
  end
end