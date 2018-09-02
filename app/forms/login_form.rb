class LoginForm
  include ActiveModel::Model
  attr_accessor :user_id, :password

  validate :user_id_validation, :password_validation

  def user_id_validation
    if user_id.empty?
      errors.add('ユーザー', "IDを入力してください")
    end
  end

  def password_validation
    if password.empty?
      errors.add('パスワード', "を入力してください")
    end
  end
end