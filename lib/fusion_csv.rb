class FusionCsv
   
    def self.field_names
       [
           'First Name', 'Last Name', 'Home Phone', 'Work Phone', 'Cell Phone', 'Email Address 1', 
           'Email Address 2', 'Email Address 3', 'Moving From', 'Looking In', 'Average Price', 
           'Status', 'Date', 'Agent', 'Primary Email Working', 'Email Working 2', 'Email Working 3', 
           'Has Agent', 'Requested Pre-Approval', 'Has Mortgage Lender', 'Has Listing Alerts', 
           'Total Properties Viewed', 'Timeframe', 'Source', 'Address 1', 'City 1', 'State 1', 'Zip 1', 
           'Address 2', 'City 2', 'State 2', 'Zip 2', 'Address 3', 'City 3', 'State 3', 'Zip 3', 
           'Address 4', 'City 4', 'State 4', 'Zip 4', 'Address 5', 'City 5', 'State 5', 'Zip 5', 
           'Registered From Agent Site'
       ] 
    end
    
    def self.uniq_headers
      # 12 Fields
      # Minimum Match Should Be
      # 
      [
        'First Name', 'Last Name', 'Home Phone', 'Primary Email Working', 
        'Registered From Agent Site', 'Moving From', 'Looking In', 
        'Has Agent', 'Requested Pre-Approval', 'Has Mortgage Lender', 
        'Has Listing Alerts', 'Total Properties Viewed'
      ]
    end
    
    def self.build_hash(record, type)
       address_line_1 = "#{CsvMap.field(record, CsvMap.address1_map)}"
       {
         entry_point:     "CSV Import (Fusion Contacts)",
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