class UserAppsController < ApplicationController
  before_action :set_user_app, only: [:show] #, :edit, :update, :destroy]

  ## GET /user_apps
  #def index
  #  @user_apps = UserApp.all
  #end

  ## GET /user_apps/1
  #def show
  #end

  # GET /user_apps/new
  def new
    @user_app = UserApp.new
  end

  ## GET /user_apps/1/edit
  #def edit
  #end

  # POST /user_apps
  def create
    @user_app = UserApp.new(user_app_params)
    @user_app.ip = request.ip
    if @user_app.save
      redirect_to new_user_app_path, notice: 'User app was successfully created.'
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /user_apps/1
  #def update
  #  if @user_app.update(user_app_params)
  #    redirect_to @user_app, notice: 'User app was successfully updated.'
  #  else
  #    render action: 'edit'
  #  end
  #end

  # DELETE /user_apps/1
  #def destroy
  #  @user_app.destroy
  #  redirect_to user_apps_url, notice: 'User app was successfully destroyed.'
  #end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_app
      @user_app = UserApp.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_app_params
      params.require(:data_processing_allowed)
      params.require(:user_app).permit([:region_id,
                                       :last_name, :first_name, :patronymic, :phone, :email, :current_status, :has_car, :legal_status,
                                       :experience_count,
                                       :extra] +
                                           UserApp.future_statuses_methods +
                                           UserApp.previous_statuses_methods +
                                           UserApp.social_methods)
    end
end