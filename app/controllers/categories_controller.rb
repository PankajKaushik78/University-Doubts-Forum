class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  def index
    if(current_user && (current_user.has_role? "admin"))
      @categories = Category.all
      @doubts = Doubt.all.order("created_at desc")
    else
      redirect_to root_path
    end
  end

  def show
    @doubts = Doubt.where('category_id=?', @category.id)
    @categories = Category.all
  end

  def new
    if(current_user && (current_user.has_role? "admin"))
      @category = Category.new
    else
      redirect_to root_path
    end
  end

  def edit
    if(current_user && (current_user.has_role? "admin"))
      @category = Category.find(params[:id])
    else
      redirect_to root_path
    end
  end


  def create
    if(current_user && (current_user.has_role? "admin"))
      @category = Category.new(category_params)

      respond_to do |format|
        if @category.save
          format.html { redirect_to categories_path, notice: 'Category was successfully created.' }
          format.json { render :show, status: :created, location: @category }
        else
          format.html { render :new }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end


  def update
    if(current_user && (current_user.has_role? "admin"))
      respond_to do |format|
        if @category.update(category_params)
          format.html { redirect_to categories_path, notice: 'Category was successfully updated.' }
          format.json { render :show, status: :ok, location: @category }
        else
          format.html { render :edit }
          format.json { render json: @category.errors, status: :unprocessable_entity }
        end
      end
    else
      redirect_to root_path
    end
  end


  def destroy
    if(current_user && (current_user.has_role? "admin"))
      @category.destroy
      respond_to do |format|
        format.html { redirect_to categories_url, notice: 'Category was successfully destroyed.' }
        format.json { head :no_content }
      end
    else
      redirect_to root_path
    end
  end

  private
    def set_category
      @category = Category.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:category)
    end
end
