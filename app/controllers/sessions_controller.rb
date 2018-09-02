class SessionsController < ApplicationController
  def new
    @form = LoginForm.new
  end

  def create
    @form = LoginForm.new(login_params)
    user = User.find_by(user_id: params[:login_form][:user_id]) if @form.valid?
    if user && user.password == params[:login_form][:password]
      session[:user_id] = user.id
      redirect_to root_path
    else
      flash[:error] = "ユーザーID、パスワードが一致するアカウントが見つかりません"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private
  def login_params
    params.require(:login_form).permit(:user_id, :password)
  end
end
