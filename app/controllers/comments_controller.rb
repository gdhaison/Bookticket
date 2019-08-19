class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new comment_params
    if @comment.save
      respond_to do |format|
        format.js
      end
      @support = Supports::Movie.new
      @movie = @comment.movie
    else
      render :new
    end
  end

  def reply_new
    @reply = Comment.new
  end

  private

  def comment_params
    params.require(:comment).permit(:user_id, :movie_id, :parent_id, :content)
  end
end
