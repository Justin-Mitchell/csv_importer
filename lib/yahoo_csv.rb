class YahooCsv
  # https://help.yahoo.com/kb/back-contacts-sln22580.html
  
  def self.field_names
    [
      'First', 'Middle', 'Last', 'Nickname', 'Email', 'Category', 
      'Distribution List', 'Messenger ID', 'Home', 'Work', 'Pager', 
      'Fax', 'Mobile', 'Other', 'Yahoo Phone', 'Primary', 
      'Alternate Email 1', 'Alternate Email 2', 'Personal Website', 
      'Business Website', 'Title', 'Company', 'Work Address', 'Work City', 
      'Work State', 'Work Zip', 'Work Country', 'Home Address', 
      'Home State', 'Home City', 'Home Zip', 'Home Country', 'Birthday', 
      'Anniversary', 'Custom 1', 'Custom 2', 'Custom 3', 'Custom 4', 
      'Comments', 'Skype ID', 'IRC ID', 'ICQ ID', 'Google ID', 'MSN ID', 
      'AIM ID', 'QQ ID'
    ]
  end
  
  def self.build_hash(record, type)
     address_line_1 = "#{CsvMap.field(record, CsvMap.address1_map)}"
     {
       first_name: CsvMap.field(record, CsvMap.first_name_map),
       last_name: CsvMap.field(record, CsvMap.last_name_map),
       email: CsvMap.field(record, CsvMap.email_map),
       kind: CsvMap.field(record, CsvMap.kind_map) || type,
       address1: address_line_1.blank? ? nil : address_line_1.split(' ').join(' '),
       address2: nil,
       company: CsvMap.field(record, CsvMap.company_map),
       title: CsvMap.field(record, CsvMap.title_map),
       city: CsvMap.field(record, CsvMap.city_map),
       state: CsvMap.field(record, CsvMap.state_map),
       zipcode: CsvMap.field(record, CsvMap.zipcode_map),
       source: CsvMap.field(record, CsvMap.source_map),
       category: CsvMap.field(record, CsvMap.category_map),
       phone_mobile: CsvMap.phone(record, CsvMap.phone_mobile_map),
       phone_home: CsvMap.phone(record, CsvMap.phone_home_map),
       phone_fax: CsvMap.phone(record, CsvMap.phone_fax_map),
       phone_work: CsvMap.phone(record, CsvMap.phone_work_map),
       birthday: CsvMap.date(record, CsvMap.birthday_map),
       purchase_date: CsvMap.date(record, CsvMap.purchase_date_map),
       budget: CsvMap.field(record, CsvMap.budget_map),
       rating: nil,
       home_value: CsvMap.field(record, CsvMap.home_value_map),
       entry_point: "CSV Import (Yahoo Contacts)",
       alt_email: CsvMap.field(record, CsvMap.alt_email_map),
       status: CsvMap.field(record, CsvMap.status_map),
       referred_by: CsvMap.field(record, CsvMap.referred_by_map),
       skype: CsvMap.field(record, CsvMap.skype_map),
       facebook: CsvMap.field(record, CsvMap.skype_map),
       gchat: CsvMap.field(record, CsvMap.gchat_map),
       aol: CsvMap.field(record, CsvMap.aol_map),
       yahoo: CsvMap.field(record, CsvMap.yahoo_map),
       comments: CsvMap.field(record, CsvMap.comments_map),
       access: 'Public'
     }
  end
end