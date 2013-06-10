class RegimesController < ApplicationController
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
      format.json { render json: @regime }
    end
  end

  # GET /regimes/new
  # GET /regimes/new.json
  def new
    @regime = Regime.new    
    @regime.regime_plates.new  

    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @regime }
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
        format.json { render json: @regime, status: :created, location: @regime }
      else
        format.html { render action: "new" }
        format.json { render json: @regime.errors, status: :unprocessable_entity }
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
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @regime.errors, status: :unprocessable_entity }
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
      format.json { head :no_content }
    end
  end

  def get_plates
    @plates = Regime.find(params[:regime_id]).get_plates_by_horario_and_dia(params[:horario], params[:dia])
    @horario = params[:horario]
    respond_with @plates, :layout => nil
  end

  def get_form_select
    render "select_plate", :layout => false
  end
end
