class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def cuaPanel
    @users = User.all
    @plates = Plate.all
    @regimes = Regime.all
    @ingredients = Ingredient.all
    @areas = Area.all
    render "panel"
  end

  def admin

  end

  def upDay
    @day = DayRegime.setCurrentDay(DayRegime.getCurrentDay() + 1)
    render json: @day 
  end

  def downDay
    @day =  DayRegime.setCurrentDay(DayRegime.getCurrentDay() - 1)
    render json: @day 
  end
end
