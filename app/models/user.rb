class User < ApplicationRecord
  has_secure_password
    has_one_attached :avatar

  has_many :posts, -> { ordering }, dependent: :destroy
  has_many :comments, -> { ordering }, dependent: :destroy

  scope :ordering, -> { order(:name) }


  validates :name, presence: true, length: {in: 2...100}
  validates :login, presence: true, length: {in: 2..100}, uniqueness: {case_sensetive: false}
    validate :check_avatar

  def edit_by?(current_user)
    current_user && (current_user == self || current_user.admin?)
  end


  private


  def check_avatar
    if avatar.attached? && !avatar.content_type.start_with?('image/')
      errors.add(:avatar, 'должно быть изображением')
    end
  end

end
