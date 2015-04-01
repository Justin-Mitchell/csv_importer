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
    hash = {
      first_name: data[:given_name],
      last_name: data[:family_name],
      email: primary_email,
      kind: type,
      address1: primary_address[:street],
      address2: nil,
      city: primary_address[:city],
      state: primary_address[:state],
      zipcode: primary_address[:postal_code],
      source: 'google contacts',
      category: data[:lead_status],
      company: data[:company],
      phone_mobile: mobile_phone,
      phone_home: home_phone,
      phone_fax: fax_number,
      phone_work: work_phone,
      birthday: data[:birthday],
      purchase_date: nil,
      budget: nil,
      rating: nil,
      home_value: nil,
      entry_point: "CSV Import (Google)",
      alt_email: alt_email,
      status: nil,
      referred_by: nil,
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
  
  def collect_addresses
    results = {}
    (1..6).map {|i| "address_#{i}_-_type".to_sym}.each do |key|
      unless data[key].nil?
        num = key.to_s.gsub(/\D/, '')
        results[data[key].downcase.to_sym] = {
          formatted: data["address_#{num}_-_formatted".to_sym],
          street: data["address_#{num}_-_street".to_sym],
          city: data["address_#{num}_-_city".to_sym],
          po_box: data["address_#{num}_-_street".to_sym],
          state: data["address_#{num}_-_region".to_sym],
          postal_code: data["address_#{num}_-_postal_code".to_sym],
          country: data["address_#{num}_-_country".to_sym],
          extended: data["address_#{num}_-_extended_address".to_sym]
        }
      end
    end
    results
  end
  
  def fetch_emails
    column_names = data.keys & [:"e-mail_1_-_value", :"e-mail_2_-_value", :"e-mail_3_-_value", :"e-mail_4_-_value"]
    arry = column_names.map {|key| data[key]}.compact
  end
  
  def poly_lookup(type, value)
    result = []
    (1..8).map {|i| "#{type}_#{i}_-_type".to_sym}.each do |key|
      if data[key] && data[key].gsub(/\*/, '').strip.downcase == value.downcase
        value_key = ("#{type.downcase}_" + key.to_s.gsub(/\D/, '') + '_-_value').to_sym
        result << data[value_key]
      end
    end
    result.first
  end
  
  def primary_lookup(type)
    result = []
    (1..8).map {|i| "#{type}_#{i}_-_type".to_sym}.each do |key|
      if data[key] && data[key].include?('*')
        value_key = ("#{type.downcase}_" + key.to_s.gsub(/\D/, '') + '_-_value').to_sym
        result << data[value_key].gsub(/\*/, '').strip.downcase
      end
    end
    result.first
  end
  
  def primary_email
    primary_lookup('e-mail')
  end
  
  def primary_address
    addresses = collect_addresses
    if addresses.size > 0
      if addresses.keys.include?(:home)
        addresses[:home]
      else
        addresses.first[1]
      end
    else
      {}
    end
  end
  
  def alt_email
    results = []
    (1..8).map {|i| "e-mail_#{i}_-_type".to_sym}.each do |key|
      if data[key]
        unless data[key].include?('*')
          value_key = ("e-mail_" + key.to_s.gsub(/\D/, '') + '_-_value').to_sym
          results << data[value_key].strip.downcase
        end
      end
    end
    results.first
  end
  
  def spouse
    key = data.key("Spouse")
    if key
      data[("relation_" + key.to_s.gsub!(/\D/, "") + "_-_value").to_sym]
    end
  end
  
  def home_phone
    poly_lookup('phone', 'home')
  end
  
  def mobile_phone
    poly_lookup('phone', 'mobile')
  end
  
  def work_phone
    poly_lookup('phone', 'work')
  end
  
  def fax_number
    poly_lookup('phone', 'work fax') || poly_lookup('phone', 'home fax')
  end
  
  def custom_phone(name)
    poly_lookup('phone', name)
  end
       
end