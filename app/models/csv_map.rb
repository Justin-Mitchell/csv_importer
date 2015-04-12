class CsvMap
  class << self
  
    def field(record, possibles)
      colname = record.keys & possibles
      value = record[colname.first]
      if value
        value
      else
        nil
      end
    end
  
    def price(record, possibles)
      colname = record.keys & possibles
      value = record[colname.first]
      if value
        value.to_f
      else
        0.00
      end
    end
  
    def date(record, possibles)
      colname = record.keys & possibles
      value = record[colname.first]
      if value
        value.to_date
      else
        nil
      end
    end
    
    def phone(record, possibles)
      colname = record.keys & possibles
      value = record[colname.first]
      if value
        value.to_s.gsub(/\D/, '')
      else
        nil
      end
    end
    
    def email_map
      [:email, :email_address, :email_1, :primary_email, :email_address_1, :e_mail_address, :"e-mail_address", :e_mail, :e_mail_address_1, :e_mail_1_value, :"e-mail_1_-_value"]
    end
  
    def alt_email_map
      [:alt_email, :email_2, :secondary_email, :email_address_2, :other_email, :e_mail_2_address, :email_2_address, :alt_email_1, :alternate_email_1]
    end
  
    def first_name_map
      [:primary_first_name, :primary_firstname, :first_name, :firstname, :fname, :first, :given_name]
    end
  
    def last_name_map
      [:primary_last_name, :primary_lastname, :last_name, :lastname, :lname, :last, :family_name]
    end
  
    def kind_map
      [:contact_type, :type]
    end
  
    def address1_map
      [:address, :street_address, :address1, :address_1, :mailing_address, :home_street, :home_address]
    end
  
    def address2_map
      [:address_2, :address2, :home_street_2]
    end
  
    def city_map
      [:city, :home_city, :address_1__city]
    end
  
    def state_map
      [:state, :home_state]
    end
  
    def zipcode_map
      [:postal_code, :zip, :zip_1, :zipcode, :zipcode_1, :postal_code_1, :postalcode, :postalcode_1, :primary_zipcode, :home_postal_code, :home_zip]
    end
  
    def source_map
      [:source, :lead_source]
    end
  
    def category_map
      [:lead_status, :contact_status, :group, :group_membership, :categories, :groups]
    end
    
    def company_map
      [:company]
    end
    
    def title_map
      [:title, :job_title, :position, :occupation, :profession]
    end
    
    def department_map
      [:department]
    end
    
    def comments_map
      [:comments, :notes]
    end
  
    def phone_mobile_map
      [:mobile_phone, :cell_phone, :mobile, :cell, :phone_mobile, :phone3, :phone_3, :primary_phone, :phone, :"phone_1_-_value"]
    end
  
    def phone_home_map
      [:home_phone, :phone_home, :phone1, :phone_1, :home]
    end
  
    def phone_fax_map
      [:business_fax, :home_fax, :fax, :fax_number, :phone_fax, :fax_phone]
    end
  
    def phone_work_map
      [:bus_phone, :work_phone, :business_phone, :phone_work, :phone_business, :office_phone, :phone_office, :phone2, :phone_2, :work]
    end
  
    def birthday_map
      [:birthday, :primary_birthday, :birthday_1]
    end
  
    def purchase_date_map
      [:closing_date, :close_date, :purchase_date, :anniversary]
    end
  
    def budget_map
      [:future_max_price, :budget, :high_price, :highprice, :max_price]
    end
  
    def home_value_map
      [:list_price]
    end
  
    def status_map
      [:lead_status, :contact_status, :client_status]
    end
  
    def referred_by_map
      [:referred_contact_name, :referred_by, :lead_source_name]
    end
  
    def skype_map
      [:skype]
    end
  
    def facebook_map
      [:facebook]
    end
  
    def gchat_map
      [:gchat]
    end
  
    def aol_map
      [:aol]
    end
  
    def yahoo_map
      [:yahoo]
    end
    
  end
end