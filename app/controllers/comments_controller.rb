class CommentsController < ApplicationController
  def create
    redirect_to root_url unless logged_in?
    @article = Article.find(params[:article_id])
    @comment = @article.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Comment created!"
      redirect_to article_url(params[:article_id])
    else
      redirect_to article_url(params[:article_id])
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    redirect_to root_url unless (current_user?(@comment.user) || @comment.user.admin == 1 )
    Comment.find(params[:id]).delete
    flash[:success] = "Comment deleted"
    redirect_to article_url(params[:article_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content)
  end

end
