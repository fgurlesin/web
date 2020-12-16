class LikesController < ApplicationController
  before_action :find_post  def create
    @article.likes.create(user_id: current_user.id)
    redirect_to article_path(@article)
  end  private  def find_post
    @article = Article.find(params[:post_id])
  end
  def create
    if already_liked?
      flash[:notice] = "You can't like more than once"
    else
      @article.likes.create(user_id: current_user.id)
    end
    redirect_to post_path(@article)
  end

  def destroy
    if !(already_liked?)
      flash[:notice] = "Cannot unlike"
    else
      @like.destroy
    end
    redirect_to post_path(@post)
  end
  
  private
  def already_liked?
    Like.where(user_id: current_user.id, post_id:
    params[:post_id]).exists?
  end
  public 

end
