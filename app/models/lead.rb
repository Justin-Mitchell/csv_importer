class Lead < ActiveRecord::Base
  # Requirements
  require 'smarter_csv'
  
  # Relations
  belongs_to :user
    
  # Validations
  validates_uniqueness_of :email, :scope => :user_id, :allow_blank => true
  validate :contactable
    
  # Pagination
  paginates_per 50
    
  # Scopes
  scope :birthdays, lambda {
    where("MONTH(birthday) = ?", Time.now.month )
    .order("updated_at DESC")
  }
  
  # Class Methods
  class << self
      
    def search_and_order(search, page_number)
      if search
        where("email LIKE ?", "%#{search.downcase}%").order(
        last_name: :desc, email: :asc
        ).page page_number
      else
        order(last_name: :desc, email: :asc).page page_number
      end
    end
      
    def import(file)
      SmarterCSV.process(file.path, key_mapping: true) do |row|
        lead_hash = TopProducer.build_hash(row[0])
        lead = Lead.where(:email => lead_hash[:email])
        if lead.size == 1
          lead.first.update_attributes(lead_hash)
        else
          Lead.create!(lead_hash)
        end
      end
    end
    
    # Options For Select Fields
    def field_options
      [
        ['Do Not Import Field', :none],
        ['Full Name', :full_name],
        ['First Name', :first_name],
        ['Last Name', :last_name],
        ['Email', :email],
        ['Type', :type],
        ['Company', :company],
        ['Street Address', :address1],
        ['City/State/Zipcode', :address2],
        ['City', :city],
        ['State', :state],
        ['ZipCode', :zip],
        ['Source', :source],
        ['Group', :category],
        ['Mobile Phone', :phone_mobile],
        ['Business Phone', :phone_business],
        ['Home Phone', :phone_home],
        ['Fax Number', :fax_number],
        ['Temperature', :temperature],
        ['Birthday', :birthday],
        ['Anniversary', :anniversary],
        ['Spouse', :spouse],
        ['Home Purchase Date', :home_anniversary],
        ['Home Budget Price', :budget],
        ['Notes/Comments', :description]
      ]
    end
    
    def kind_options
      [
        ['Buyer', 'buyer'],
        ['Seller', 'seller'],
        ['Investor', 'investor'],
        ['Prospect', 'prospect'],
        ['Converted', 'converted'],
        ['Client', 'client'],
        ['Past Client', 'past_client'],
        ['Renter', 'renter'],
        ['Vendor', 'vendor'],
        ['Lender', 'lender'],
        ['Broker', 'broker'],
        ['Agent', 'agent'],
        ['Appraiser', 'appraiser'],
        ['Builder/Contractor', 'builder_contractor'],
        ['Sphere of Influence', 'sphere_of_influence'],
        ['Family/Relative', 'family_relative'],
        ['First Time Buyer', 'first_time_buyer'],
        ['Friend', 'friend'],
        ['Landlord', 'landlord'],
        ['Tenant', 'tenant'],
        ['Company', 'company'],
        
      ]
    end
    
    def source_options
      [
        ['Advertisement', 'advertisement'],
        ['Broker', 'broker'],
        ['Cold Call', 'cold_call'],
        ['Expired Listing', 'expired_listing'],
        ['Foreclosure', 'foreclosure'],
        ['Open House', 'open_house'],
        ['Past Customer', 'past_customer'],
        ['Personal Marketing', 'personal_marketing'],
        ['Referral', 'referral'],
        ['Sign Call', 'sign_call'],
        ['Walk-in', 'walk_in'],
        ['Webpage', 'webpage'],
        ['Conference', 'conference'],
        ['Other', 'other']
      ]
    end
  end
  
  # Instance Methods
  def name
    "#{first_name} #{last_name}"
  end
  
  def name_or_email
    if self.first_name
      "#{self.first_name} #{self.last_name}"
    else
      self.email || self.alt_email
    end
  end
  
  def position
    if company && title
      "#{title} at #{company}"
    elsif company && !title
      "#{company}"
    elsif !company && title
      "#{title}"
    else
      ''
    end
  end
  
  def street_address
    if address1 && address2
      "#{address1}<br/>#{address2}".html_safe
    elsif address1 && !address2
      "#{address1}"
    else
      nil
    end
  end
  
  def city_state_zip
    if city && state && zipcode
      "#{city}, #{state}<br/>#{zipcode}".html_safe
    else
      nil
    end
  end
    
  private
  
  # Custom Validation
  def contactable
    if email.blank? && phone_mobile.blank? && phone_home.blank? && phone_work.blank? && address1.blank?
      errors.add(:lead, "missing contact information. Add one or all of the following: Email, Phone Number, Address")
    end
  end
end