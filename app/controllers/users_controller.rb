class UsersController < ApplicationController
  respond_to :html, :json, :csv
  respond_to :js, :only => [:update]
  # Privileged controller
  before_action :authenticate_admin
  # Edit the submitted admin collections based on existing collections in @user's db entry
  before_action :update_admin_collections, :only => [:update]

  # GET /users
  def index
    @users = User.order(sort_column + " " + sort_direction).page(params[:page]).per(30)
    @users = @users.with_query(params[:q]) unless params[:q].blank?

    respond_with(@users)
  end

  # GET /users/1
  def show
    @user = User.find(params[:id])

    respond_with(@user)
  end

  # PUT /users/1
  def update
    # Update user attributes
    user_attributes = {
      :umbra_admin_collections => @user.user_collections,
      :umbra_admin => !@user.user_collections.empty?
    }
    @user.user_attributes = user_attributes

    flash[:notice] = t('users.update_success') if @user.save

    respond_with(@user)
  end

  # DELETE /users/1
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_with(@user)
  end

  # DELETE /users/clear_patron_data
  def clear_patron_data
    @users = User.all

    flash[:success] = t('users.clear_patron_data_success') if User.destroy_all("user_attributes not like '%:umbra_admin: true%'")

    respond_with(@users, :location => users_url) do |format|
      format.html { redirect_to users_url }
    end
  end

  # Implement sort column for User class
  def sort_column
    super "User", "lastname"
  end
  helper_method :sort_column

end
