class ArticlesController < ApplicationController
  before_action :logged_in_user, only: [:new]
  before_action :correct_user,   only: [:edit, :update, :destroy]
  def show
    @article = Article.find(params[:id])
  end

  def new
    @article = Article.new
  end

  def index
    @articles = Article.paginate(page: params[:page])
  end

  def create
    @article = current_user.articles.build(article_params)
    if @article.save
      flash[:success] = "Article created!"
      redirect_to article_url(@article)
    else
      render 'new'
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update_attributes(article_params)
      flash[:success] = "Profile updated"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    Article.find(params[:id]).destroy
    flash[:success] = "Article deleted"
    redirect_to user_url(current_user)
  end

  private
    def article_params
      params.require(:article).permit(:title, :content)
    end

    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def correct_user
      @user = Article.find(params[:id]).user
      redirect_to(root_url) unless (current_user?(@user) || current_user.admin == 1)
    end

end
