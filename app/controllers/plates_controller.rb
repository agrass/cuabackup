class PlatesController < ApplicationController
  # GET /plates
  # GET /plates.json
  def index
    @plates = Plate.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /plates/1
  # GET /plates/1.json
  def show
    @plate = Plate.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /plates/new
  # GET /plates/new.json
  def new
    @plate = Plate.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /plates/1/edit
  def edit
    @plate = Plate.find(params[:id])
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
      else
        format.html { render action: "new" }
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
      else
        format.html { render action: "edit" }
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
    end
  end
end
