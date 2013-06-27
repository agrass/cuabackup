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

  def area
     if params[:date]
      date0 = params[:date]
      date0 = date0.split('/')
      @date = date0[2]+'-'+date0[1]+'-'+date0[0]
    else
      @date = Date.today.strftime("%Y-%m-%d")
    end

    @areas_id = Array.new
    Area.all.each do |area|
      @ids = Array.new
      AreasPlates.find_all_by_area_id(area.id).each do |ap|
        @ids << ap.plate_id
      end
      @areas_id[area.id] = @ids
    end

    
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
