class OrderListsController < ApplicationController
  # GET /order_lists
  # GET /order_lists.json
  def index

    if params[:date]
      @date = params[:date]
    else
      @date = Date.tomorrow.strftime("%d/%m/%Y")
    end

    date2 = @date.split('/')
    @format_date = date2[2]+'-'+date2[1]+'-'+date2[0]
    @order_lists = OrderList.where(:fecha => @format_date)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @order_lists }
    end
  end

  # GET /order_lists/1
  # GET /order_lists/1.json
  def show
    @order_list = OrderList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @order_list }
    end
  end

  # GET /order_lists/new
  # GET /order_lists/new.json
  def new
    @order_list = OrderList.new
    @patients_info = Patient.patients_group_by_num_pieza.to_json
    @date
    if params[:date]
      @order_list.fecha = params[:date]
      @date = params[:date]
    else
      @order_list.fecha = Date.tomorrow
      @date= Date.tomorrow
    end
    @order_list.save

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @order_list }
    end
  end

  # GET /order_lists/1/edit
  def edit
    if params[:horario] 
      @horario = params[:horario]
    end
    if params[:regime] 
      @regime_id = params[:regime]
    end
    @order_list = OrderList.find(params[:id])
    @patients_info = Patient.patients_group_by_num_pieza.to_json
  end

  # POST /order_lists
  # POST /order_lists.json
  def create
    @order_list = OrderList.new(params[:order_list])

    respond_to do |format|
      if @order_list.save
        format.html { redirect_to :controller => 'order_lists', :action => 'edit', :id => @order_list.id, :horario => '1'}
        format.json { render json: @order_list, status: :created, location: @order_list }
      else
        format.html { render action: "new" }
        format.json { render json: @order_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /order_lists/1
  # PUT /order_lists/1.json
  def update
    @order_list = OrderList.find(params[:id])
    if params[:patient_detalles]
      patient = @order_list.patient
      patient.detalles = params[:patient_detalles]
      patient.save
    end
    respond_to do |format|
      if @order_list.update_attributes(params[:order_list])
        if params[:order_list][:orders_attributes].nil?
          format.html { redirect_to :controller => 'order_lists', :action => 'edit', :id => @order_list.id, :horario => '1'}
        else
          if !params[:order_list][:orders_attributes]['0'][:horario].empty?
            order = @order_list.orders.where(:horario => params[:order_list][:orders_attributes]['0'][:horario].to_i).first
            order.plates.destroy_all
            if params[:regPlates]
              params[:regPlates].each do |plate|
                if(!plate[1].empty?)
                  order.plates << Plate.find(plate[1].to_i)
                end
              end
              order.regime_id = params[:regime_order][:id]
              order.save
            end
          end

          if params[:order_list][:orders_attributes]['0'][:horario].empty? || params[:order_list][:orders_attributes]['0'][:horario] == '8'
            format.html { redirect_to order_lists_path, notice: 'Las ordenes fueron ingresadas exitosamente!' }
          else
            format.html { redirect_to :controller => 'order_lists', :action => 'edit', :id => @order_list.id, :horario => (params[:order_list][:orders_attributes]['0'][:horario].to_i * 2).to_s, :regime => order.regime_id}
          end
        end
      else
        format.html { render action: "edit" }
        format.json { render json: @order_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /order_lists/1
  # DELETE /order_lists/1.json
  def destroy
    @order_list = OrderList.find(params[:id])
    @order_list.orders.destroy_all
    @order_list.destroy

    respond_to do |format|
      format.html { redirect_to order_lists_url }
      format.json { head :no_content }
    end
  end
end
