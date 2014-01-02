class ReportsController < ApplicationController
  # GET /reports
  # GET /reports.json
  def index

  end

  # GET /reports/1
  # GET /reports/1.json
  def pdf_show
   
  end

  def pdf_list
    @reports = Report.order('created_at DESC').find_all_by_tipo(params[:tipo])
  end

  # GET /reports/new
  # GET /reports/new.json
  def new    
    @fecha = Date.today.strftime("%d-%m-%Y")
    if params[:fecha] != nil
      @fecha = params[:fecha]
    end
    nombre = ""
    tipo = ""
    if params[:tipo] == "vaucher"
      nombre = Report.plates(params[:horario], @fecha) 
      tipo = "vaucher"
    elsif params[:tipo] == "areas"
      nombre = Report.areas(params[:horario], @fecha)
      tipo = "areas"
    end
    if nombre != "0"
      @report = Report.create(:name => nombre, :tipo => tipo)
      Report.where("created_at <= ?", Time.now - 7.days).each do |report|
        begin
          File.delete("public/pdf/" + report.name)
          report.destroy
        rescue
          report.destroy
        end
      end
      redirect_to pdf_show_path(:source => nombre)
    else
      redirect_to order_lists_path, notice: 'No existen ordenes por imprimir.'
    end


  end

  # GET /reports/1/edit
  def edit
    @report = Report.find(params[:id])
  end

  # POST /reports
  # POST /reports.json
  def create
    @report = Report.new(params[:report])

    respond_to do |format|
      if @report.save
        format.html { redirect_to @report, notice: 'Report was successfully created.' }
        format.json { render json: @report, status: :created, location: @report }
      else
        format.html { render action: "new" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /reports/1
  # PUT /reports/1.json
  def update
    @report = Report.find(params[:id])

    respond_to do |format|
      if @report.update_attributes(params[:report])
        format.html { redirect_to @report, notice: 'Report was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @report.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reports/1
  # DELETE /reports/1.json
  def destroy
    @report = Report.find(params[:id])
    @report.destroy

    respond_to do |format|
      format.html { redirect_to reports_url }
      format.json { head :no_content }
    end
  end
end
