# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20131023151829) do

  create_table "areas", :force => true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "areas_plates", :id => false, :force => true do |t|
    t.integer "area_id"
    t.integer "plate_id"
  end

  create_table "day_regimes", :force => true do |t|
    t.date     "date"
    t.integer  "regime_day"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "estado_areas", :force => true do |t|
    t.integer  "idArea"
    t.date     "fecha"
    t.integer  "horario"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "ingredients", :force => true do |t|
    t.string   "nombre"
    t.integer  "precio"
    t.string   "unidad"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "order_lists", :force => true do |t|
    t.integer  "patient_id"
    t.boolean  "esPaciente"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.date     "fecha"
    t.integer  "dia"
  end

  create_table "orders", :force => true do |t|
    t.integer  "horario"
    t.string   "comentarios"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "order_list_id"
    t.integer  "regime_id"
    t.integer  "estado"
  end

  create_table "orders_plates", :force => true do |t|
    t.integer "order_id", :null => false
    t.integer "plate_id", :null => false
  end

  create_table "patients", :force => true do |t|
    t.string   "nombre"
    t.string   "num_pieza"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "rut"
    t.text     "detalles"
  end

  create_table "plate_ingredients", :force => true do |t|
    t.integer  "cantidad"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
    t.integer  "plate_id"
    t.integer  "ingredient_id"
  end

  create_table "plates", :force => true do |t|
    t.string   "nombre"
    t.integer  "calorias"
    t.integer  "tipo"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.integer  "horario"
    t.text     "description"
  end

  create_table "regime_plates", :force => true do |t|
    t.integer  "dia"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "plate_id"
    t.integer  "regime_id"
    t.integer  "horario"
  end

  create_table "regimes", :force => true do |t|
    t.string   "nombre"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "reports", :force => true do |t|
    t.string   "name"
    t.string   "tipo"
    t.string   "description"
    t.datetime "start"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "roles", :force => true do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  add_index "roles", ["name", "resource_type", "resource_id"], :name => "index_roles_on_name_and_resource_type_and_resource_id"
  add_index "roles", ["name"], :name => "index_roles_on_name"

  create_table "users", :force => true do |t|
    t.string   "email",                  :default => "", :null => false
    t.string   "encrypted_password",     :default => "", :null => false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "name"
    t.string   "rut"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

  create_table "users_roles", :id => false, :force => true do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], :name => "index_users_roles_on_user_id_and_role_id"

end
