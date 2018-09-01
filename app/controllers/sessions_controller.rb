class SessionsController < ApplicationController
  def new
    @form = LoginForm.new
    @errors = []
  end

  def create
    @errors = []
    @form = LoginForm.new(login_params)
    user = User.find_by(user_id: params[:login_form][:user_id])
    if user && user.password == params[:login_form][:password]
      session[:user_id] = user.id
      redirect_to root_path
    else
      @errors << "ユーザーID、パスワードが一致するアカウントが見つかりません"
      if params[:login_form][:user_id].blank?
        @errors << "ユーザーIDを入力してください"
      end
      if params[:login_form][:password].blank?
        @errors << "パスワードを入力してください"
      end
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to login_path
  end

  private
  def login_params
    params.require(:login_form).permit(:user_id)
  end
end
