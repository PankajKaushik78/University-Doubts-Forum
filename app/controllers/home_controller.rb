class HomeController < ApplicationController
  before_action :authenticate_user!, only: [:index, :dashboard]

  def index
  end

  
  def dashboard
    if( current_user && current_user.teacher? )
      @doubts_asked = Doubt.all.length
      @doubts_resolved = Doubt.where(is_resolved: true).length
      @doubts_escalated = Doubt.where("escalate_count > ?", 0).length
      total_time = 0
      Doubt.all.each do |doubt|
        if(doubt.answer)
          answered_at = doubt.answer.created_at
          asked_at = doubt.created_at
          total_time += ((answered_at-asked_at)/1.minutes)
        end
      end
      @average_doubt_solving_time = 0
      if(@doubts_resolved != 0)
        @average_doubt_solving_time = (total_time/@doubts_resolved).to_i
      end
      @assistants = Assistant.all 
    else
      redirect_to doubts_path
    end
  end
end
