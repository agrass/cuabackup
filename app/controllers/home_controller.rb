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
    @date = Date.today.strftime("%d/%m/%Y")
  end
end
