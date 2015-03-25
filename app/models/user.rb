class User < ActiveRecord::Base
  # Attachements
  mount_uploader :avatar, AvatarUploader
  
  # Relations
  has_many :csv_imports
  has_many :posts
  has_many :leads

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, 
  :recoverable, :rememberable, :trackable, :validatable, :confirmable
  
  # Pagination
  paginates_per 100

  # Validations
  # :email
  validates_format_of :email, with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i
  class << self
    def paged(page_number)
      order(admin: :desc, email: :asc).page page_number
    end

    def search_and_order(search, page_number)
      if search
        where("email LIKE ?", "%#{search.downcase}%").order(
        admin: :desc, email: :asc
        ).page page_number
      else
        order(admin: :desc, email: :asc).page page_number
      end
    end

    def last_signups(count)
      order(created_at: :desc).limit(count).select("id","email","created_at")
    end

    def last_signins(count)
      order(last_sign_in_at:
      :desc).limit(count).select("id","email","last_sign_in_at")
    end

    def users_count
      where("admin = ? AND locked = ?",false,false).count
    end
  end
  
  def name
    "#{self.first_name} #{self.last_name}"
  end
end
