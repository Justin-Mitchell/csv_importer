class RemaxCsv
  
  def self.fields
    [
      'Client ID', 'First Name', 'Last Name', 'E-mail Address', 'Password', 
      'Classification', 'Home Street', 'Home City', 'Home State', 
      'Home Postal Code', 'Country Code', 'Home Phone', 'Cell Phone', 
      'Business Phone', 'Home Fax', 'Birthday', 'Company Name', 'Gender', 
      'Lead Type', 'Client Status', 'Moving Timeframe', 'Residence', 
      'Selling', 'Buying', 'Loan Services', 'Pre-Approved', 'Created Date', 
      'Accepted Date', 'Able to Login', 'Last Activity Date', 'Notes', 
      '2nd First Name', '2nd Last Name', 'Groups', '2nd Client ID', 
      'Relationship', '2nd Gender', '2nd E-mail Address', '2nd Home Phone', 
      '2nd Business Phone', '2nd Cell Phone', '2nd Fax', '2nd Company Name', 
      '2nd Birthday'
    ]
  end
  
  def fields
    self.fields
  end
  
  def self.build_hash(record, type)
     address_line_1 = "#{CsvMap.field(record, CsvMap.address1_map)}"
     {
       entry_point:     "CSV Import (Remax Contacts)",
       first_name:      CsvMap.field(record, CsvMap.first_name_map),
       last_name:       CsvMap.field(record, CsvMap.last_name_map),
       email:           CsvMap.field(record, CsvMap.email_map),
       kind:            CsvMap.field(record, CsvMap.kind_map) || type,
       address1:        address_line_1.blank? ? nil : address_line_1.split(' ').join(' '),
       address2:        nil,
       company:         CsvMap.field(record, CsvMap.company_map),
       title:           CsvMap.field(record, CsvMap.title_map),
       city:            CsvMap.field(record, CsvMap.city_map),
       state:           CsvMap.field(record, CsvMap.state_map),
       zipcode:         CsvMap.field(record, CsvMap.zipcode_map),
       source:          CsvMap.field(record, CsvMap.source_map) || 'Fusion Contacts',
       category:        CsvMap.field(record, CsvMap.category_map),
       phone_mobile:    CsvMap.phone(record, CsvMap.phone_mobile_map),
       phone_home:      CsvMap.phone(record, CsvMap.phone_home_map),
       phone_fax:       CsvMap.phone(record, CsvMap.phone_fax_map),
       phone_work:      CsvMap.phone(record, CsvMap.phone_work_map),
       birthday:        CsvMap.date(record,  CsvMap.birthday_map),
       purchase_date:   CsvMap.date(record,  CsvMap.purchase_date_map),
       budget:          CsvMap.field(record, CsvMap.budget_map),
       rating:          nil,
       home_value:      CsvMap.field(record, CsvMap.home_value_map),
       alt_email:       CsvMap.field(record, CsvMap.alt_email_map),
       status:          CsvMap.field(record, CsvMap.status_map),
       referred_by:     CsvMap.field(record, CsvMap.referred_by_map),
       skype:           CsvMap.field(record, CsvMap.skype_map),
       facebook:        CsvMap.field(record, CsvMap.skype_map),
       gchat:           CsvMap.field(record, CsvMap.gchat_map),
       aol:             CsvMap.field(record, CsvMap.aol_map),
       yahoo:           CsvMap.field(record, CsvMap.yahoo_map),
       comments:        CsvMap.field(record, CsvMap.comments_map),
       access:          'Public'
     }
  end
  
end