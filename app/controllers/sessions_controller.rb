class SessionsController < ApplicationController
  def new
    @form = LoginForm.new
  end

  def create
    @form = LoginForm.new(login_params)
    user = User.find_by(user_id: params[:login_form][:user_id])
    if user && user.password == params[:login_form][:password]
      session[:user_id] = user.id
      redirect_to root_path
    else
      @errors = []
      if params[:login_form][:user_id].nil?
        error = "ユーザーIDを入力してください"
        @errors << error
      end
      if params[:login_form][:password].nil?
        error = "パスワードを入力してください"
        @errors << error
      end
      render :new
    end
  end

  def destroy
  end


  private
  def login_params
    params.require(:login_form).permit(:user_id, :password)
  end
end
