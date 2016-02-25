class DishesController < ApplicationController
  def new
    @dish = Dish.new 
    @ingredients = Ingredient.all
    @cooking_methods = CookingMethod.all
    @user = User.new 
  end

  def create
    @dish = current_user.dishes.build dish_params
    if @dish.save
      flash[:success] = "Success! Dish was saved."
      redirect_to dishes_path
    else
      flash[:danger] = "Dish was not saved"
      @user = current_user 
      @ingredients = Ingredient.all
      @cooking_methods = CookingMethod.all 
      render "new"
    end
  end

  def index
    @dishes = current_user.dishes
    dish = @dishes.last
    @my_dish = "#{dish.cooking_method.name} #{dish.ingredient.name}"


  end

  def destroy
    @dishes = Dish.all
    @dish = @dishes.find params[:id]
    @dish.destroy
    flash[:alert] = "Dish has been deleted"
    redirect_to dishes_path
  end

  private

  def dish_params
    params.require(:dish).permit(:ingredient_id, :cooking_method_id)
  end
end
