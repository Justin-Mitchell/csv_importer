class GoogleCsv
  
  def initialize(record, type)
    @params = {
      data: record,
      type: type
    }
    build_hash
  end
  
  def data
    @params[:data]
  end
  
  def type
    @params[:type]
  end
  
  def self.fields
    # Yomi:  Phonetic equivalent for Japanese Kanji symbol.
    [
      'Name', 'Given Name', 'Additional Name', 'Family Name', 'Yomi Name', 
      'Given Name Yomi', 'Additional Name Yomi', 'Family Name Yomi', 'Name Prefix', 
      'Name Suffix', 'Initials', 'Nickname', 'Short Name', 'Maiden Name', 
      'Birthday', 'Gender', 'Location', 'Billing Information', 'Directory Server', 
      'Mileage', 'Occupation', 'Hobby', 'Sensitivity', 'Priority', 'Subject', 
      'Notes', 'Group Membership', 'E-mail 1 - Type', 'E-mail 1 - Value', 
      'E-mail 2 - Type', 'E-mail 2 - Value', 'Phone 1 - Type', 'Phone 1 - Value', 
      'Phone 2 - Type', 'Phone 2 - Value', 'Address 1 - Type', 'Address 1 - Formatted', 
      'Address 1 - Street', 'Address 1 - City', 'Address 1 - PO Box', 
      'Address 1 - Region', 'Address 1 - Postal Code', 'Address 1 - Country', 
      'Address 1 - Extended Address', 'Organization 1 - Type', 'Organization 1 - Name', 
      'Organization 1 - Yomi Name', 'Organization 1 - Title', 
      'Organization 1 - Department', 'Organization 1 - Symbol', 
      'Organization 1 - Location', 'Organization 1 - Job Description', 
      'Relation 1 - Type', 'Relation 1 - Value'
    ]
  end
  
  def fields
    Google.fields
  end
  
  def build_hash
    # Google CSV
    address_line_1 = "#{data[:"address_1_-_street"]}"
    hash = {
      first_name: data[:given_name],
      last_name: data[:family_name],
      email: primary_email,
      kind: type,
      address1: data[:"address_1_-_street"],
      address2: nil,
      city: data[:"address_1_-_city"],
      state: data[:"address_1_-_region"],
      zipcode: data[:"address_1_-_postal_code"],
      source: 'google contacts',
      category: data[:lead_status],
      company: data[:company],
      phone_mobile: data[:mobile_phone],
      phone_home: data[:home_phone],
      phone_fax: data[:fax_number],
      phone_work: data[:bus_phone],
      birthday: data[:primary_birthday],
      purchase_date: nil,
      budget: [0, nil].include?(data[:future_max_price]) ? nil : data[:future_max_price].to_f,
      rating: nil,
      home_value: nil,
      entry_point: "CSV Import (Top Producer)",
      alt_email: alt_email,
      status: data[:lead_status],
      referred_by: data[:referred_contact_name] || data[:"referred_to/by_contact_name"],
      skype: nil,
      facebook: nil,
      gchat: nil,
      aol: nil,
      yahoo: nil,
      access: 'Public',
      user_id: nil
    }
    return hash
  end
  
  def fetch_emails
    column_names = data.keys & [:"e-mail_1_-_value", :"e-mail_2_-_value", :"e-mail_3_-_value", :"e-mail_4_-_value"]
    arry = column_names.map {|key| data[key]}.compact
  end
  
  def primary_email
    fetch_emails.compact.first
  end
  
  def alt_email
    if fetch_emails.size > 2
      fetch_emails.last
    else
      nil
    end
  end
  
  def spouse
    key = data.key("Spouse")
    if key
      data[("relation_" + key.to_s.gsub!(/\D/, "") + "_-_value").to_sym]
    end
  end
      
  
end