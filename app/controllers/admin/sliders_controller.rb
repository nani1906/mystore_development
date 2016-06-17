class Admin::SlidersController < ApplicationController
  before_filter :authenticate_spree_user!
  before_action :set_admin_slider, only: [:show, :edit, :update, :destroy]

  # GET /admin/sliders
  # GET /admin/sliders.json
  def index
    if current_spree_user.admin?
      @admin_sliders = Admin::Slider.all
    else
      redirect_to spree.admin_unauthorized_path
    end
  end

  # GET /admin/sliders/1
  # GET /admin/sliders/1.json
  def show
    if current_spree_user.admin?
      @admin_sliders = Admin::Slider
    else
      redirect_to spree.admin_unauthorized_path
    end
  end

  # GET /admin/sliders/new
  def new
    if current_spree_user.admin?
      @admin_slider = Admin::Slider.new
      @taxonomies = Spree::Taxonomy.includes(root: :children)
        @target_paths = {}
        max_level = Spree::Config[:max_level_in_taxons_menu] || 1
          @taxonomies.each do |taxonomy|
            cache [I18n.locale, taxonomy, max_level, @taxon] do
              taxonomy.name
              return '' if max_level < 1 || taxonomy.root.leaf?
                taxons = taxonomy.root.children.map do |taxon|
                  # @target_paths.merge!("#{taxon.name}": "#{seo_url(taxon)}")
                  @target_paths[:"#{taxon.name}"] = spree.nested_taxons_path(taxon.permalink)
                  taxon.children.map do |child|
                    @target_paths[:"#{child.name}"] = spree.nested_taxons_path(child.permalink)
                  end
                end
              end
            end
    else
      redirect_to spree.admin_unauthorized_path
    end
  end


  # GET /admin/sliders/:id/edit
  def edit
    if current_spree_user.admin?
      @taxonomies = Spree::Taxonomy.includes(root: :children)
        @target_paths = {}
        max_level = Spree::Config[:max_level_in_taxons_menu] || 1
          @taxonomies.each do |taxonomy|
            cache [I18n.locale, taxonomy, max_level, @taxon] do
              taxonomy.name
              return '' if max_level < 1 || taxonomy.root.leaf?
                taxons = taxonomy.root.children.map do |taxon|
                  # @target_paths.merge!("#{taxon.name}": "#{seo_url(taxon)}")
                  @target_paths[:"#{taxon.name}"] = spree.nested_taxons_path(taxon.permalink)
                  taxon.children.map do |child|
                    @target_paths[:"#{child.name}"] = spree.nested_taxons_path(child.permalink)
                  end
                end
              end
            end
    else
      redirect_to spree.admin_unauthorized_path
    end
  end

  # POST /admin/sliders
  # POST /admin/sliders.json
  def create
    if current_spree_user.admin?
      @admin_slider = Admin::Slider.new(admin_slider_params)
      respond_to do |format|
        if @admin_slider.save
          format.html { redirect_to @admin_slider, notice: 'Slider was successfully created.' }
          format.json { render :show, status: :created, location: @admin_slider }
        else
          format.html { render :new }
          format.json { render json: @admin_slider.errors, status: :unprocessable_entity }
        end
      end    
    else
      redirect_to spree.admin_unauthorized_path
    end

  end

  # PATCH/PUT /admin/sliders/1
  # PATCH/PUT /admin/sliders/1.json
  def update
    if current_spree_user.admin?
      respond_to do |format|
        if @admin_slider.update(admin_slider_params)
          format.html { redirect_to @admin_slider, notice: 'Slider was successfully updated.' }
          format.json { render :show, status: :ok, location: @admin_slider }
        else
          format.html { render :edit }
          format.json { render json: @admin_slider.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to spree.admin_unauthorized_path
    end
  end

  # DELETE /admin/sliders/1
  # DELETE /admin/sliders/1.json
  def destroy
    if current_spree_user.admin?
      @admin_slider.destroy
      respond_to do |format|
        format.html { redirect_to admin_sliders_url, notice: 'Slider was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to spree.admin_unauthorized_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_slider
      @admin_slider = Admin::Slider.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_slider_params
      params.require(:admin_slider).permit(:title, :description, :attachment, :target_url)
    end
end