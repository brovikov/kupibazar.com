# -*- encoding : utf-8 -*-
class UsersController < ApplicationController
    load_and_authorize_resource #cancan
  #before_filter :authenticate_user!
  def show
    @user =  User.find(params[:id])
  end
  
  def current
    @user =  current_user
  end
  
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:nik]) 
        format.html { redirect_to @user, notice: 'Информация о пользователе успешно обновлена.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  #def index
  #  @user =  current_user
  #end
  
end
