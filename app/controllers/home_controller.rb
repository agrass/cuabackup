class HomeController < ApplicationController
  before_filter :authenticate_user!, :except => [:index]
  def index
    @users = User.all
  end

  def cuaPanel
    @users = User.all
    @regimes = Regime.all    
    @areas = Area.all
    authorize! :manage, [@users, @ingredients, @areas]    

    render "panel"
  end

  def plates
    @plates = Plate.find(:all, :order => "nombre ASC")
    render "platos"
  end
  def ingredients
    @ingredients = Ingredient.find(:all, :order => "nombre ASC")
    render "ingredientes"
  end

  def admin
  end

  def ingredientsPanel
    if params[:date]
      date = params[:date].split('/')
      #@ingredients = Ingredient.joins(plates: [orders: :order_list]).where(order_lists: {fecha: date[2]+'-'+date[1]+'-'+date[0]}).select('ingredients.nombre, sum(plate_ingredients.cantidad) as cantidad_total, ingredients.unidad').group('ingredients.nombre')
      @ingredients = Ingredient.joins(plates: [:areas, orders: :order_list]).where(order_lists: {fecha: date[2]+'-'+date[1]+'-'+date[0]}).select('ingredients.nombre, sum(plate_ingredients.cantidad) as cantidad_total, ingredients.unidad, orders.horario as horario, areas.id as area_id').group('ingredients.nombre, areas.id, ingredients.unidad, orders.horario').order('areas.id, orders.horario')

      respond_to do |format|
        format.html { render :layout => false}
        format.xls
        format.json { render json: @ingredients}
      end
      return
    else
      render nothing: true
      return
    end
  end

  def area
     if params[:date]
      date0 = params[:date]
      date0 = date0.split('/')
      @date = date0[2]+'-'+date0[1]+'-'+date0[0]
    else
      @date = Date.today.strftime("%Y-%m-%d")
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
