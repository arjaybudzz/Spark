class User < ApplicationRecord
  include CommonUserDataValidation
  has_many :answer_sheets, dependent: :destroy
  has_many :quizzes, through: :answer_sheets
  has_many :posts, dependent: :destroy
  has_many :comments, through: :posts
  has_many :post_up_votes, through: :posts
  has_many :post_down_votes, through: :posts

  validates :credibility, presence: true

  scope :filter_by_first_name, lambda { |keyword| where("lower(first_name) LIKE ?", "%#{keyword.downcase}%") }

  scope :filter_by_middle_name, lambda { |keyword| where("lower(middle_name) LIKE ?", "%#{keyword.downcase}%") }

  scope :filter_by_last_name, lambda { |keyword| where("lower(last_name) LIKE ?", "%#{keyword.downcase}%") }

  def self.search(params = {})
    users = params[:user_ids].present? ? User.where(id: params[:user_ids]) : User.all

    users = users.filter_by_first_name(params[:first_name]) if params[:first_name]
    users = users.filter_by_middle_name(params[:middle_name]) if params[:middle_name]
    users = users.filter_by_last_name(params[:last_name]) if params[:last_name]
    users = users.recent if params[:recent]

    users
  end
end
