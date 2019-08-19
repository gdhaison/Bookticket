module Manager
  class CategoriesController < Manager::BaseController
    skip_before_action :verify_authenticity_token
    before_action :find_category, except: %i[index new create]
    before_action :order, only: %i[create update]

    def index
      @categories = Category.all.order("created_at desc")

      respond_to do |format|
        format.html
        format.csv { send_data @categories.as_csv }
      end
    end

    def new
      @category = Category.new
    end

    def create
      @category = Category.new category_params
      @categories = Category.order(updated_at: :desc).page(params[:page]).per Settings.per_page_categories
      if @category.save
        respond_to do |format|
          format.html
          format.js
        end
      else
        render "form"
      end
    end

    def edit; end

    def update
      if @category.update category_params
        respond_to do |format|
          format.html
          format.js
        end
      else
        render "edit"
      end
    end

    def destroy
      @category.destroy
      flash[:success] = t ".success"
      redirect_to manager_categories_path
    end

    private

    def category_params
      params.require(:category).permit(:name)
    end

    def find_category
      @category = Category.find params[:id]
    end

    def order
      @categories = Category.order(created_at: :desc)
    end
  end
end
