class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

         has_many :books, dependent: :destroy
         attachment :profile_image

         validates :name, presence: true
         validates :name, length: { in: 2..20 }
         validates :introduction, length: { maximum: 50 }

         def self.find_first_by_auth_conditions(warden_conditions)
      conditions = warden_conditions.dup
      if login = conditions.delete(:login)
        
        where(conditions).where(["name = :value", { :value => name }]).first
      else
        where(conditions).first
      end
  end


  def email_required?
    false
  end
  def email_changed?
    false
  end

end
