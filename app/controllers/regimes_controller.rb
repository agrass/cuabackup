class RegimesController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
  skip_authorize_resource :only => :get_plates

  respond_to :html
  require "prawn"
  # GET /regimes
  # GET /regimes.json
  def index
    @regimes = Regime.all
    # respond_to do |format|
    #   format.html # index.html.erb
    #   format.json { render json: @regimes }
    # end
  end

  # GET /regimes/1
  # GET /regimes/1.json
  def show
    @regime = Regime.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /regimes/new
  # GET /regimes/new.json
  def new
    @regime = Regime.new
    @regime.regime_plates.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /regimes/1/edit
  def edit
    @regime = Regime.find(params[:id])

    if params[:dia] != nil
      @dia = params[:dia]
      session[:dia] = params[:dia]
    else
      if session[:dia] != nil
        @dia = session[:dia]
      else
        @dia = 1
      end
    end

  end

  # POST /regimes
  # POST /regimes.json
  def create
    @regime = Regime.new(params[:regime])

    respond_to do |format|
      if @regime.save
        format.html { redirect_to edit_regime_path(@regime), notice: 'Regime was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /regimes/1
  # PUT /regimes/1.json
  def update
    @regime = Regime.find(params[:id])

    respond_to do |format|
      if @regime.update_attributes(params[:regime])
        format.html { redirect_to edit_regime_path(@regime), notice: 'Regime was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /regimes/1
  # DELETE /regimes/1.json
  def destroy
    @regime = Regime.find(params[:id])
    @regime.destroy

    respond_to do |format|
      format.html { redirect_to regimes_url }
    end
  end

  def get_plates
    authorize! :manage, Order
    if params[:regime_id] != "undefined"
      @plates = Regime.find(params[:regime_id]).get_plates_by_horario_and_dia(params[:horario], params[:dia])
      @horario = params[:horario]
      respond_with @plates, :layout => nil
    else
      render :text => " "
    end
    
  end

  def get_form_select
    render "select_plate", :layout => false
  end

  def stats
    if params[:date]
      date = params[:date]
    else
      date = Date.today.strftime("%d/%m/%Y")
    end
    @bar = LazyHighCharts::HighChart.new('column') do |f|
      f.xAxis(:categories => ['Desayuno', 'Almuerzo', 'Once', 'Cena'])
      Regime.data_for_stats(date).each do |data|
        f.series(data)
      end
      # f.series(:name=>'John',:data=> [3, 20, 3, 5, 4])
      # f.series(:name=>'Jane',:data=>[1, 3, 4, 3, 3] )
      f.title({ :text=>"Ordenes por Regimen"})

      ###  Options for Bar
      ### f.options[:chart][:defaultSeriesType] = "bar"
      ### f.plot_options({:series=>{:stacking=>"normal"}})

      ## or options for column
      f.options[:chart][:defaultSeriesType] = "column"
      f.plot_options({:column=>{:stacking=>"normal"}})
    end
    render layout: false
  end
end
