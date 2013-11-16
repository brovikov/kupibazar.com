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
  
  #def index
  #  @user =  current_user
  #end
  
end
