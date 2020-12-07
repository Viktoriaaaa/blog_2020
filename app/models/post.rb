class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, -> { ordering }, dependent: :destroy

  scope :ordering, -> { order(created_at: :desc) }
  scope :full, -> { includes(:user).merge(User.with_attached_avatar) }
  validates :title, presence: true, length: {in: 2..255}
  validates :body, presence: true

  def edit_by?(current_user)
    current_user == user || current_user&.admin?
  end

end
