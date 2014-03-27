class OrderListsController < ApplicationController
  # GET /order_lists
  # GET /order_lists.json
  def index
    if params[:date]
      @date = params[:date]
      #crear cookie para guardar el valor de fecha cuando cambia de pagina
      cookies[:date] = { :value => @date, :expires => 1.hour.from_now }
    elsif cookies[:date] != nil
      @date = cookies[:date]
    else
      @date = Date.today.strftime("%d/%m/%Y")
    end
    date2 = @date.split('/')
    @format_date = date2[2]+'-'+date2[1]+'-'+date2[0]
    @order_lists = OrderList.where(:fecha => @format_date)

    @regimes = Regime.get_names_hash

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /order_lists/1
  # GET /order_lists/1.json
  def show
    @order_list = OrderList.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
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
    #@order_list.save

    respond_to do |format|
      format.html # new.html.erb
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
        if params[:is_colacion]
          @order_list.orders.create(params[:order])
          format.html { redirect_to order_lists_path, notice: 'La colacion fue ingresada exitosamente!' }
        else
          format.html { redirect_to :controller => 'order_lists', :action => 'edit', :id => @order_list.id, :horario => '1'}
        end
      else
        format.html { render action: "new" }
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
            if params[:regime_order][:id] and params[:regime_order][:id] != ""
              order = @order_list.orders.where(:horario => params[:order_list][:orders_attributes]['0'][:horario].to_i).first
              order.plates.destroy_all
              order.regime_id = params[:regime_order][:id]
              if params[:regPlates]
                params[:regPlates].each do |plate|
                  if(!plate[1].empty?)                  
                    if order.check_is_today
                      EstadoArea.create_alert(order.horario, plate[1].to_i)      
                    end
                    order.plates << Plate.find(plate[1].to_i)
                  end
                end
              end
              order.save
            else
              order = @order_list.orders.where(:horario => params[:order_list][:orders_attributes]['0'][:horario].to_i).first

              order.destroy

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
    end
  end

  def new_colacion
    @order_list = OrderList.new
    @patients_info = Patient.patients_group_by_num_pieza.to_json

    respond_to do |format|
      format.html # new.html.erb
    end
  end

end
