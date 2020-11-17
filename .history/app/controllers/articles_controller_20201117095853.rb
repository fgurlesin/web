class ArticlesController < ApplicationController

  before_action :set_article , only: [ :show , :edit , :update , :destroy]
  before_action :require_user , except: [:show , :index]
  before_action :require_same_user , only: [:edit , :update ,:destroy ]
  

  def show
    # byebug
  end

  def index 
    @article = Article.all.order("updated_at DESC").paginate(page: params[:page], per_page: 5)  
  end

  def new
    @article=Article.new
  end
  
  def create 
    @article = Article.new(article_params)
    @article.user = current_user
    if @article.save
      flash[:notice] = "Article was created succesfully"
      #redirect_to articles_path
      redirect_to @article
    else
      render 'new'
    end
    
  end

  def edit
    
  end

  def update 
    if @article.update(article_params)
      flash[:notice]="Article was updated succesfully"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    @article.destroy
    redirect_to articles_path 
  end

  private

  def set_article 
  @article= Article.find(params[:id])
  

  end

  def article_params
    params.require(:article).permit(:tittle, :description , category_ids: [] , :image)
  end

  def require_same_user
    if current_user != @article.user && !current_user.admin?
      flash[:alert] =  "You can only edit or delete your article"
    
    end 
  end

  public

end
