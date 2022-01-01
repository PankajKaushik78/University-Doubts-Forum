class DoubtsController < ApplicationController
  before_action :set_doubt, only: [:show, :edit, :update, :destroy, :escalate, :accept]
  before_action :get_all_categories, only: [:index, :show, :new, :edit, :create]
  before_action :authenticate_user!, except: [:index, :show]


  def index
    if(current_user && current_user.assistant?)
      @doubts = Doubt.where(is_resolved: false, is_accepted: false).order('created_at desc')
    else
      @doubts = Doubt.all.order('created_at desc')
    end
  end

  def show
    @doubts = Doubt.all.order('created_at desc')
  end

  def new
    if(current_user)
    @doubt = current_user.doubts.build
    else
      redirect_to 'index'
    end
  end

  def edit
  end

  def create
    @doubt = current_user.doubts.build(doubt_params)
    @doubt.is_resolved = false
    @doubt.escalate_count = 0
    respond_to do |format|
      if @doubt.save
        format.html { redirect_to @doubt, notice: 'Doubt was successfully created.' }
      else
        format.html { render :new, notice: 'Please fill all fields'}
      end
    end
  end

  def update
    respond_to do |format|
      if @doubt.update(doubt_params)
        format.html { redirect_to @doubt, notice: 'Doubt was successfully updated.' }
        format.json { render :show, status: :ok, location: @doubt }
      else
        format.html { render :edit }
        format.json { render json: @doubt.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @doubt.destroy
    respond_to do |format|
      format.html { redirect_to doubts_url, notice: 'Doubt was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  # Action for handling escalted doubt
  def escalate
    if(current_user && current_user.assistant?)
      @doubt.escalate_count += 1
      @doubt.is_resolved = false
      @doubt.is_accepted = false
      @doubt.accepted_at = nil
      current_user.assistant.escalated += 1
      if(@doubt.answer && @doubt.answer.user_id == current_user.id)
        current_user.assistant.resolved -= 1
        @doubt.answer.destroy
      end
      current_user.assistant.save
      @doubt.save
    elsif(current_user && ((current_user.teacher?) || (current_user.has_role?"admin") ))
      @doubt.is_resolved = false
      @doubt.is_accepted = false
      if(@doubt.answer)
        @doubt.answer.destroy
      end
      @doubt.save
    end
    redirect_to doubts_path, notice: "Escalated successfully"
  end

  # Action for handling accepted doubt
  def accept
    if(current_user && (current_user.assistant? || current_user.teacher?))
      @doubt.is_accepted = true
      if(current_user.assistant?)
        @doubt.accepted_at = Time.now         
        current_user.assistant.doubts += 1
        current_user.assistant.save
      end
      @doubt.save
      redirect_to doubt_path(@doubt)
    else
      redirect_to doubts_path
    end
  end

  private
    def set_doubt
      @doubt = Doubt.find(params[:id])
    end

    def doubt_params
      params.require(:doubt).permit(:title, :description, :is_resolved, :escalate_count, :category_id)
    end

    def get_all_categories
      @categories = Category.all.order('created_at desc')
    end
end
