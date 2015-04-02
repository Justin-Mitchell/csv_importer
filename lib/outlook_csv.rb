class OutlookCsv
  
  def self.fields
    [
      "Title","First Name","Middle Name","Last Name","Suffix",
      "Company","Department","Job Title","Business Street",
      "Business Street 2","Business Street 3","Business City",
      "Business State","Business Postal Code","Business Country/Region",
      "Home Street","Home Street 2","Home Street 3","Home City",
      "Home State","Home Postal Code","Home Country/Region",
      "Other Street","Other Street 2","Other Street 3","Other City",
      "Other State","Other Postal Code","Other Country/Region",
      "Assistant's Phone","Business Fax","Business Phone",
      "Business Phone 2","Callback","Car Phone","Company Main Phone",
      "Home Fax","Home Phone","Home Phone 2","ISDN","Mobile Phone",
      "Other Fax","Other Phone","Pager","Primary Phone","Radio Phone",
      "TTY/TDD Phone","Telex","Account","Anniversary","Assistant's Name",
      "Billing Information","Birthday","Business Address PO Box",
      "Categories","Children","Directory Server","E-mail Address",
      "E-mail Type","E-mail Display Name","E-mail 2 Address",
      "E-mail 2 Type","E-mail 2 Display Name","E-mail 3 Address",
      "E-mail 3 Type","E-mail 3 Display Name","Gender","Government ID Number",
      "Hobby","Home Address PO Box","Initials","Internet Free Busy",
      "Keywords","Language","Location","Manager's Name","Mileage",
      "Notes","Office Location","Organizational ID Number",
      "Other Address PO Box","Priority","Private","Profession",
      "Referred By","Sensitivity","Spouse","User 1","User 2","User 3",
      "User 4","Web Page"
    ]
  end
  
  def poly_lookup(type, value)
    result = []
    ('', '2_', '3_').map {|i| "#{type}_#{i}type".to_sym}.each do |key|
      if data[key] && data[key].gsub(/\*/, '').strip.downcase == value.downcase
        digit = key.to_s.gsub(/\D/, '')
        if digit then digit + "_" end
        value_key = ("#{type.downcase}_" + digit + 'address').to_sym
        result << data[value_key]
      end
    end
    result.first
  end
  
end