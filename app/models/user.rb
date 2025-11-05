class User < ApplicationRecord
  has_secure_password
  
  has_many :doc_as
  has_many :doc_bs

  validates :user_name, presence: true, uniqueness: true
  validates :password, presence: true, on: :create
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }

  def buyer?
    user_name == 'U'
  end

  def approver?
    %w[P Q R S].include?(user_name)
  end
  
  def admin?
    is_admin? || user_name == 'admin' || email == 'admin@gmail.com'
  end
  
  def display_name_or_username
    display_name.presence || user_name
  end
end

