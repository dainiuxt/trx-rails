class UsersController < ApplicationController
  allow_unauthenticated_access only: %i[ new create ]

  def new
    @user = User.new
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

  def index
  end

  private
  def user_params
    params.expect(user: [ :email_address,
                          :password,
                          :password_confirmation,
                          :username ])
  end
end
