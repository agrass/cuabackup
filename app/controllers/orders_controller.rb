class OrdersController < ApplicationController
  # GET /orders
  # GET /orders.json
  def index
    if params[:date]
      @date = params[:date]
    else
      @date = Time.now.strftime("%d/%m/%Y")
    end
    # @orders = Order.where(:created_at => @date)
    @orders = Order.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = Order.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  def logs
    @logs = ChangeLog.order('created_at DESC').all
    render :layout => false
  end

  # GET /orders/new
  # GET /orders/new.json
  def new
    @order = Order.new
    # @patients_info = Patient.patients_group_by_num_pieza.to_json

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /orders/1/edit
  def edit
    @order = Order.find(params[:id])
    if @order.horario != 16
      @plates = Regime.find(@order.regime_id).get_plates_by_horario_and_dia(@order.horario, OrderList.find(@order.order_list_id).dia)
    end
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(params[:order])    
    params[:regPlates].each do |plate|
      if(!plate[1].empty?)        
        @order.plates << Plate.find(plate[1].to_i)
      end
    end
    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Ordern creada exitosamente.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /orders/1
  # PUT /orders/1.json
  def update
    @order = Order.find(params[:id])
    #authorize! :manage, [@order]
    #guardar los platos antiguos para hacer la comparacion
    old = Hash.new       
    @order.plates.select('plates.id').each do |plate|
      old[plate.id] = 1
    end       
    @order.plates.delete_all
    params[:regPlates].each do |plate|
      if(!plate[1].empty?)
        new_plate = Plate.find(plate[1].to_i)
        #revisar si lo tenia antes y marcarlo
        if old[plate[1].to_i] == 1
          old[plate[1].to_i] = 3
        #no lo tiene, por lo tanto hay que generar una alerta y log
        elsif old[plate[1].to_i] == nil
          #solo hay que crear la alerta si la modificacion es del mismo dia, sino no es necesario guardar los logs 
          if @order.check_is_today
            EstadoArea.create_alert(@order.horario, plate[1].to_i)
            ChangeLog.create(:horario => @order.horario, :plate_id => plate[1].to_i, :tipo => 1 )
          end
        end
        @order.plates << new_plate
      end
    end
    #hay que revisar si se borro alguno para generar el log y la alerta
    old.each do |key, value|
      #si ya no existe, es decir no esta marcado con 3 se crea una alerta     
      if value == 1
        if @order.check_is_today
          EstadoArea.create_alert(@order.horario, key.to_i)
          ChangeLog.create(:horario => @order.horario, :plate_id => key.to_i, :tipo => -1 )
        end
      end
    end    
    respond_to do |format|
      if @order.update_attributes(params[:order])
        format.html { redirect_to order_lists_path, notice: 'La Orden fue actualizada' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order = Order.find(params[:id])
    authorize! :manage, [@order]
    @order.destroy

    respond_to do |format|
      format.html { redirect_to order_lists_path, :notice => 'Orden Borrada!' }
    end
  end
end
