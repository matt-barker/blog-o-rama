class CommentsController < ApplicationController
    def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.new(comment_params)
    @comment.user = current_user
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @article, notice: 'Comment was created successfully.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { redirect_to @article, alert: 'Comment was not saved successfully.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
    end
    
    def destroy
      @comment = Comment.find(params[:id])
      article = @comment.article
      @comment.destroy
      redirect_to article
    end
    
    private

        def comment_params
            params.require(:comment).permit(:user_id, :body)
        end
end
