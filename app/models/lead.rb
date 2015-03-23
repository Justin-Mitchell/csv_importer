class Lead < ActiveRecord::Base
  # Associations  
  belongs_to :user

  # Pagination
  # paginates_per 100
    
  def self.import(file)
    # Requirements
    require 'smarter_csv'
    SmarterCSV.process(file.path, key_mapping: true) do |row|
      lead_hash = Lead.build_from_record(row[0])
      lead = Lead.where(:email => lead_hash[:email])
      if lead.size == 1
        lead.first.update_attributes(lead_hash)
      else
        Lead.create!(lead_hash)
      end
    end
  end
  
  def self.build_from_record(record)
    # Top Producer Values
    address_line_1 = "#{record[:house_number]} #{record[:direction_prefix]} #{record[:street]} #{record[:street_designator]} #{record[:direction_suffix]}"
    address_line_2 = (record[:bldg_floor].blank? ? "#{record[:suite_no]}" : "Bldg #{record[:bldg_floor]} ##{record[:suite_no]}") unless record[:suite_no].blank?
    hash = {
      first_name: record[:primary_firstname],
      last_name: record[:primary_lastname],
      email: record[:email_address],
      kind: record[:contact_type],
      address1: address_line_1.blank? ? nil : address_line_1.split(' ').join(' '),
      address2: address_line_2.blank? ? nil : address_line_2.split(' ').join(' '),
      city: record[:city],
      state: record[:state],
      zipcode: record[:zip],
      source: record[:source],
      category: record[:lead_status],
      company: record[:company],
      phone_mobile: record[:mobile_phone],
      phone_home: record[:home_phone],
      phone_fax: record[:fax_number],
      phone_work: record[:bus_phone],
      birthday: record[:primary_birthday].blank? ? nil : record[:primary_birthday].to_date,
      purchase_date: record[:closing_date].blank? ? nil : record[:closing_date].to_date,
      budget: [0, nil].include?(record[:future_max_price]) ? nil : record[:future_max_price].to_f,
      rating: nil,
      home_value: record[:list_price],
      entry_point: "CSV Import",
      alt_email: record[:other_email_web_addr],
      status: record[:lead_status],
      referred_by: record[:referred_contact_name] || record[:"referred_to/by_contact_name"],
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
  
  def self.import_options_for_select
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
  
  def name_or_email
    if self.first_name
      "#{self.first_name} #{self.last_name}"
    else
      self.email || self.alt_email
    end
  end
end