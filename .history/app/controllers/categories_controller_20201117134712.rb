class CategoriesController < ApplicationController 
   
  before_action :require_admin , except: [:index, :show]

  def new
    @category=Category.new
  end

  def edit 
    @category=Category.find(params[:id])
  end

  def update 
    @category=Category.find(params[:id])
      if @category.update(category_params)
        flash[:notice]="Category name updated succesfully"
        redirect_to @category
      else
        render 'edit'
      end
  end

  def destroy 

  end

   def index 
    @category = Category.all
   end

   def show
    @category=Category.find(params[:id])
    @article=@category.articles
   end

   def create 
    @category=Category.new(category_params)
    
    if @category.save 
      flash[:notice] =  "Category created"
      redirect_to @category
    else
      render 'new'
    end 
   end

   private
   def category_params 
    params.require(:category).permit(:name)
   end

   def require_admin 
    if !(logged_in? && current_user.admin?)
      flash[:alert]="You have no permit for this action"
      redirect_to  categories_path
    end
  end

   public

end