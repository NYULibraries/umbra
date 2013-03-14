class UsersController < ApplicationController
  include Umbra::Collections
  # Privileged controller
  before_filter :authenticate_admin
  # Edit the submitted admin collections based on existing collections in @user's db entry
  before_filter :update_admin_collections, :only => [:update]
  
  # GET /users
  def index
    @users = User.search(params[:q]).order(sort_column + " " + sort_direction).page(params[:page]).per(30)
    
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # PUT /users/1
  def update
    # Update user attributes
    user_attributes = {
      :umbra_admin_collections => user_collections,
      :umbra_admin => !user_collections.empty?
    }
    @user.user_attributes = user_attributes
    
    respond_to do |format|
      if @user.save 
        format.html { redirect_to(@user, notice: "User successfully updated.")  }
        format.js { render :layout => false }
      else
        format.html { render action: "show", error: "Could not save user." }
        format.js { render :layout => false }
      end
    end
  end
  
  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.json { head :no_content }
    end
  end
  
  # Implement sort column for User class
  def sort_column
    super "User", "lastname"
  end
  helper_method :sort_column

end
