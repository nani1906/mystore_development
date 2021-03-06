class Admin::CategoriesController < ApplicationController
  before_filter :authenticate_spree_user!
  before_action :set_admin_category, only: [:show, :edit, :update, :destroy]

  # GET /admin/categories
  # GET /admin/categories.json
  def index
    if current_spree_user.admin?
      @admin_categories = Admin::Category.all
    else
      redirect_to spree.admin_unauthorized_path
    end
  end

  # GET /admin/categories/1
  # GET /admin/categories/1.json
  def show
    if current_spree_user.admin?
      @admin_categories = Admin::Category
    else
      redirect_to spree.admin_unauthorized_path
    end
  end

  # GET /admin/categories/new
  def new
    if current_spree_user.admin?
      @admin_category = Admin::Category.new
      @taxonomies = Spree::Taxonomy.includes(root: :children)
        @target_paths = {}
        max_level = Spree::Config[:max_level_in_taxons_menu] || 1
        @taxonomies.each do |taxonomy|
          cache [I18n.locale, taxonomy, max_level, @taxon] do
            return '' if max_level < 1 || taxonomy.root.leaf?
              taxons = taxonomy.root.children.map do |taxon|
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

  # GET /admin/categories/:id/edit
  def edit
    if current_spree_user.admin?
      @taxonomies = Spree::Taxonomy.includes(root: :children)
        @target_paths = {}
        max_level = Spree::Config[:max_level_in_taxons_menu] || 1
        @taxonomies.each do |taxonomy|
          cache [I18n.locale, taxonomy, max_level, @taxon] do
            return '' if max_level < 1 || taxonomy.root.leaf?
              taxons = taxonomy.root.children.map do |taxon|
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

  # POST /admin/categories
  # POST /admin/categories.json
  def create
    if current_spree_user.admin?
      @admin_category = Admin::Category.new(admin_category_params)
      respond_to do |format|
        if @admin_category.save
          format.html { redirect_to @admin_category, notice: 'Category was successfully created.' }
          format.json { render :show, status: :created, location: @admin_category }
        else
          format.html { render :new }
          format.json { render json: @admin_category.errors, status: :unprocessable_entity }
        end
      end    
    else
      redirect_to spree.admin_unauthorized_path
    end

  end

  # PATCH/PUT /admin/categories/1
  # PATCH/PUT /admin/categories/1.json
  def update
    if current_spree_user.admin?
      respond_to do |format|
        if @admin_category.update(admin_category_params)
          format.html { redirect_to @admin_category, notice: 'Category was successfully updated.' }
          format.json { render :show, status: :ok, location: @admin_category }
        else
          format.html { render :edit }
          format.json { render json: @admin_category.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to spree.admin_unauthorized_path
    end
  end

  # DELETE /admin/categories/1
  # DELETE /admin/categories/1.json
  def destroy
    if current_spree_user.admin?
      @admin_category.destroy
      respond_to do |format|
        format.html { redirect_to admin_categories_url, notice: 'Category was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to spree.admin_unauthorized_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_category
      @admin_category = Admin::Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_category_params
      params.require(:admin_category).permit(:title, :attachment, :target_url)
    end
end