class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_comment, only: [:edit, :show, :update, :destroy]
    before_action :set_doubt, only: [:edit, :show, :update, :destroy, :create]

    def create
        @comment = @doubt.comments.create(comment_params)
        @comment.user_id = current_user.id

        respond_to do |format|
            if @comment.save
                format.html {redirect_to doubt_path(@doubt)}
                format.js
            else
                format.html {redirect_to doubt_path(@doubt), notice: 'Comment did not save. Please try again.'}
                format.js
            end
        end
    end

    def destroy
        @comment = @doubt.comments.find(params[:id])
        @comment.destroy
        redirect_to doubt_path(@doubt)
    end

    def edit
        @doubt = Doubt.find(params[:doubt_id])
        @comment = @doubt.comments.find(params[:id])
    end

    def update
        @comment = @doubt.comments.find(params[:id])
        respond_to do |format|
            if @comment.update(comment_params)
                format.html { redirect_to doubt_path(@doubt), notice: 'Comment was successfully updated.'}
            else
                format.html {render :edit}
                format.json {render json: @comment.errors, status: unprocessable_entity}
            end
        end
    end

    private

    def set_comment
        @comment = Comment.find(params[:id])
    end

    def set_doubt
        @doubt = Doubt.find(params[:doubt_id])
    end

    def comment_params
        params.require(:comment).permit(:comment, :doubt_id) 
    end
end