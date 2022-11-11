class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :recoverable, :validatable
  has_many :snippets

  def full_name
    return "#{first_name} #{last_name}" if first_name.present? && last_name.present?
    return "#{first_name}" if last_name.present?
    return "#{email}" if @first_name.blank? && last_name.blank?
    return ""
  end
end
