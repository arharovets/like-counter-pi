class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update]
  before_action :authenticate_user!, only: %i[show edit update]

  # GET /users/1
  def show; end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  def create
    @user = User.new(user_params)

    respond_to do |format|
      format.html do
        if @user.save
          redirect_to @user, notice: 'User was successfully created.'
        else
          render :new
        end
      end
    end
  end

  # PATCH/PUT /users/1
  def update
    respond_to do |format|
      format.html do
        if @user.update(user.params)
          redirect_to @user, notice: 'User was successfully updated.'
        else
          render :edit
        end
      end
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
    @user if @user == current_user
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:email, :password)
  end
end
