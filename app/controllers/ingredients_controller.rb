class IngredientsController < ApplicationController  
  # GET /ingredients
  # GET /ingredients.json
  def index
    @ingredients = Ingredient.all

    respond_to do |format|
      format.html # index.html.erb
    end
  end

  # GET /ingredients/1
  # GET /ingredients/1.json
  def show
    @ingredient = Ingredient.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
    end
  end

  # GET /ingredients/new
  # GET /ingredients/new.json
  def new
    @ingredient = Ingredient.new

    respond_to do |format|
      format.html # new.html.erb
    end
  end

  # GET /ingredients/1/edit
  def edit
    @ingredient = Ingredient.find(params[:id])
  end

  # POST /ingredients
  # POST /ingredients.json
  def create
    @ingredient = Ingredient.new(params[:ingredient])

    respond_to do |format|
      if @ingredient.save
        format.html { redirect_to cuapanel_path, notice: 'Ingredient was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  # PUT /ingredients/1
  # PUT /ingredients/1.json
  def update
    @ingredient = Ingredient.find(params[:id])
    authorize! :manage, [@ingredient]

    respond_to do |format|
      if @ingredient.update_attributes(params[:ingredient])
        format.html { redirect_to cuapanel_path, notice: 'Ingredient was successfully updated.' }
      else
        format.html { render action: "edit" }
      end
    end
  end

  # DELETE /ingredients/1
  # DELETE /ingredients/1.json
  def destroy
    @ingredient = Ingredient.find(params[:id])
    authorize! :manage, [@ingredient]
    @ingredient.destroy

    respond_to do |format|
      format.html { redirect_to cuapanel_path }
    end
  end
end
