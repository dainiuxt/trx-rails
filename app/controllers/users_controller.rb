class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]
  before_action :require_admin, only: %i[ index destroy update edit approve suspend ]
  before_action :get_user, only: %i[ destroy update edit approve suspend ]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def approve
    @user.update(status: "approved")
    redirect_to users_path, notice: "User was approved."
  end

  def suspend
    @user.update(status: "pending")
    redirect_to users_path, notice: "User was suspended."
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to root_path, notice: "Your account will be approved shortly. Thank you for the patience!"
    else
      flash.now[:alert] = @user.errors.full_messages.join(", ")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to users_path, notice: "User was successfully approved."
    else
      redirect_to users_path, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
    redirect_to users_path, notice: "User was successfully destroyed."
  end

  private
  def user_params
    params.expect(user: [ :email_address,
                          :password,
                          :password_confirmation,
                          :username ])
  end

  def get_user
    @user = User.find(params[:id])
  end

  # def require_admin
  #   unless Current.user.admin?
  #     redirect_to root_path, alert: "You are not allowed to access this page."
  #   end
  # end
end
