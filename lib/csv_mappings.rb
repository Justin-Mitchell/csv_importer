module CsvMappings
  
  def map_it(record, possibles)
    colname = record.keys & possibles
    value = record[colname.first]
    if value
      value
    else
      nil
    end
  end
  
  def email_map
    [:email, :email_address, :email_1, :primary_email, :email_address_1]
  end
  
  def alt_email_map
    [:alt_email, :email_2, :secondary_email, :email_address_2, :other_email]
  end
  
  def first_name_map
    [:primary_first_name, :primary_firstname, :first_name, :firstname, :fname]
  end
  
  def last_name_map
    [:primary_last_name, :primary_lastname, :last_name, :lastname, :lname]
  end
  
  def kind_map
    [:contact_type, :type]
  end
  
  def address1_map
    [:address, :street_address, :address1, :address_1, :mailing_address,]
  end
  
  def address2_map
    [:address_2, :address2, ]
  end
  
  def city_map
    [:city]
  end
  
  def state_map
    [:state]
  end
  
  def zipcode_map
    [:postal_code, :zip, :zip_1, :zipcode, :zipcode_1, :postal_code_1, :postalcode, :postalcode_1, :primary_zipcode]
  end
  
  def source_map
    [:source, :lead_source]
  end
  
  def category_map
    [:lead_status, :contact_status]
  end
  
  def phone_mobile_map
    [:mobile_phone, :cell_phone, :mobile, :cell, :phone_mobile]
  end
  
  def phone_home_map
    [:home_phone, :phone_home]
  end
  
  def phone_fax_map
    [:fax, :fax_number, :phone_fax, :fax_phone]
  end
  
  def phone_work_map
    [:bus_phone, :work_phone, :business_phone, :phone_work, :phone_business, :office_phone, :phone_office]
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
    [:lead_status, :contact_status]
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