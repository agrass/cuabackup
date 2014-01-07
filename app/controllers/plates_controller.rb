class PlatesController < ApplicationController
  # GET /plates
  # GET /plates.json
  def index
    @plates = Plate.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @plates }
    end
  end

  # GET /plates/1
  # GET /plates/1.json
  def show
    @plate = Plate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @plate }
    end
  end

  # GET /plates/new
  # GET /plates/new.json
  def new
    @plate = Plate.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @plate }
    end
  end

  # GET /plates/1/edit
  def edit
    @plate = Plate.find(params[:id])
    # @plate.plate_ingredients.build
  end

  # POST /plates
  # POST /plates.json
  def create
    @plate = Plate.new(params[:plate])
    count = 0
    if params[:plate][:horario] != nil
      params[:plate][:horario].each do |x|
        count += x.to_i
      end
    end
    @plate.horario = count

    respond_to do |format|
      if @plate.save
        format.html { redirect_to cuapanel_path, notice: 'Plate was successfully created.' }
        format.json { render json: @plate, status: :created, location: @plate }
      else
        format.html { render action: "new" }
        format.json { render json: @plate.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /plates/1
  # PUT /plates/1.json
  def update
    @plate = Plate.find(params[:id])
    count = 0
    if params[:plate][:horario] != nil
      params[:plate][:horario].each do |x|
        count += x.to_i
      end
    end

    respond_to do |format|
      if @plate.update_attributes(params[:plate])
        @plate.horario = count
        @plate.save
        format.html { redirect_to cuapanel_path, notice: 'Plate was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @plate.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /plates/1
  # DELETE /plates/1.json
  def destroy
    @plate = Plate.find(params[:id])
    @plate.destroy

    respond_to do |format|
      format.html { redirect_to cuapanel_path }
      format.json { head :no_content }
    end
  end
end
