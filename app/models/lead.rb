class Lead < ActiveRecord::Base
    # Requirements
    require 'smarter_csv'
  
    # Associations  
    belongs_to :user
  
    # Class Methods
    class << self
        def import(file)
          binding.pry
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
  
        def import_options_for_select
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
    end
  
    # Instance Methods
    def name_or_email
        if self.first_name
            "#{self.first_name} #{self.last_name}"
        else
            self.email || self.alt_email
        end
    end
end