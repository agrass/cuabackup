class HomeController < ApplicationController
  def index
    @users = User.all
  end

  def cuaPanel
    @users = User.all
    @plates = Plate.all
    @regimes = Regime.all
    @ingredients = Ingredient.all
    render "panel"
  end
end
