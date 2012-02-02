class User::RegistrationsController < Devise::RegistrationsController
  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      redirect_to user_posts_path(@user)
    else 
      render 'new'
    end
  end
end
