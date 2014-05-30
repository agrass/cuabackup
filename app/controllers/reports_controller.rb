class ReportsController < ApplicationController
  before_filter :authenticate_user!
  load_and_authorize_resource
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
    render :layout => false
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
    #por defecto se imprimen todos 1 por imprimir, 2 modificado, 4 ingresado por alerta, 5 pendiente
      estados = [1,2,4,5] 
      if params[:estados] == "nuevos"
        estados = [1,4,5]
      #puse por separado los modificados, ya que puede ser necesario identificar especificamente aquellos vouchers a remplazar de los nuevos.
      elsif params[:estados] == "modificados"
        estados = [2]
      end
    #imprimir aquellos que son vaucher del paciente
    if params[:tipo] == "vaucher"
      if params[:horario] == "16"
        nombre = Report.colacion(params[:horario], @fecha, estados)
        tipo = "vaucher"
      else  
        nombre = Report.plates(params[:horario], @fecha, estados) 
        tipo = "vaucher"
      end
    elsif params[:tipo] == "areas"
      nombre = Report.areas(params[:horario], @fecha)
      tipo = "areas"
    elsif params[:tipo] == "colacion"
      nombre = Report.colacion(params[:horario], @fecha, estados)
      tipo = "colacion"
    end
    if nombre != "0"
      @report = Report.create(:name => nombre, :tipo => tipo)
      Report.where("created_at <= ?", Time.zone.now - 7.days).each do |report|
        begin
          File.delete("public/pdf/" + report.name)
          report.destroy
        rescue
          report.destroy
        end
      end      
      params[:source] = nombre
      render "pdf_show", :layout => false    
    else
      render :text => "No existen vouchers por imprimir!"
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
      else
        format.html { render action: "new" }
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
      else
        format.html { render action: "edit" }
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
    end
  end
end
