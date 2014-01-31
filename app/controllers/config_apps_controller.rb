# -*- encoding : utf-8 -*-
class ConfigAppsController < ApplicationController

    load_and_authorize_resource #cancan
  def show
    @config_app = ConfigApp.find(params[:id])
  end
  
  def index
    @config_app= ConfigApp.all
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def new
    @config_app= ConfigApp.new
#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @product }
  end
  
  def create
    @config_app= ConfigApp.new ( params[:config_app] )
    respond_to do |format|
       if @config_app.save
         format.html { redirect_to @config_app, notice: 'Конфигурация успешно добавлена.' }
         format.json { render json: @config_app, status: :created, location: @payment }
      else
         format.html { render action: "new" }
    
      end
    end  
  end
  
  def destroy
    @config_app = ConfigApp.find(params[:id])
    respond_to do |format|
      @config_app.destroy
        format.html { redirect_to config_apps_url, notice: 'Конфигурация удалена!' }
        format.json { head :no_content }
    end    
  end
    
    def edit
     @config_app = ConfigApp.find(params[:id])
    end
  
   def update
     @config_app = ConfigApp.find(params[:id])

    respond_to do |format|
      if @config_app.update_attributes(params[:config_app]) 
        format.html { redirect_to @config_app, notice: 'Конфигурация успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @payment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
end
