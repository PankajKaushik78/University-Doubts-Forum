class AnswersController < ApplicationController
    before_action :authenticate_user!
    before_action :set_answer, only: [:edit, :show, :update, :destroy]
    before_action :set_doubt, only: [:edit, :show, :update, :destroy, :create]

    def create
        if(current_user && (current_user.assistant? || current_user.teacher? ))
            @answer = @doubt.create_answer(answer_params)
            @answer.user_id = current_user.id
            respond_to do |format|
                if @answer.save
                    if(current_user.assistant?)
                        current_user.assistant.resolved += 1
                        if(@doubt.accepted_at)
                            current_user.assistant.total_time += ((Time.now - @doubt.accepted_at)/1.minutes).to_i
                        end
                        current_user.assistant.save
                    end
                    @doubt.is_resolved = true
                    @doubt.save
                    format.html {redirect_to doubt_path(@doubt)}
                    format.js
                else
                    format.html {redirect_to doubt_path(@doubt), alert: 'Answer did not save. Please try again'}
                    format.js
                end
            end
        else
            redirect_to doubt_path(@doubt)
        end
    end

    def new
    end

    def destroy
        @answer = @doubt.answer
        @answer.destroy
        redirect_to doubt_path(@doubt)
    end

    def edit
        @doubt = Doubt.find(params[:doubt_id])
        @answer = @doubt.answer
    end

    def update
        @answer = @doubt.answer
        respond_to do |format|
            if @answer.update(answer_params)
                format.html {redirect_to doubt_path(@doubt), notice: "Answer updated"}
            else
                format.html {render :edit}
                format.json {render json: @answer.errors, status: unprocessable_entity}
            end
        end
    end

    private

    def set_answer
        @answer = Answer.find(params[:id])
    end

    def set_doubt
        @doubt = Doubt.find(params[:doubt_id])
    end

    def answer_params
        params.require(:answer).permit(:content, :doubt_id) 
    end
end