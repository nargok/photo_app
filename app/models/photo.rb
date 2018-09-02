class Photo < ApplicationRecord
  validate :title_validation, :filename_validation
  belongs_to :user

  private

  def title_validation
    if title.empty?
      errors.add('タイトル', "を入力してください")
    end

    if title.length > 30
      errors.add('タイトル', "は30文字以内で入力してください")
    end
  end

  def filename_validation
    if filename.nil?
      errors.add('画像ファイル', "を入力してください")
    end
  end
end