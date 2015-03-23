class TopProducer
   
   def self.field_names
      [
          "Contact ID", "Contact Type",  "Source", "Inquiry form",	"Primary FirstName", "Primary LastName", 
          "Primary Initial", "Primary NickName", "Primary Jr_Sr", "Primary Mr_Mrs", "Primary Title", "Primary Designation",	
          "Letter Salutation", "Envelope/Label Salutation", "Company", "Primary Gender", "Primary Birthday", "Email Address", 
          "Unsubscribed", "Web Address", "Other Email_Web Type", "Other Email_Web Addr", "Other Email_Web Desc", "Home Phone", 
          "Home Phone Ext", "Home Ph Desc", "Bus Phone", "Bus Phone Ext", "Bus Ph Desc", "Other Phone", "Other Phone Ext", 
          "Other Ph Desc", 'Other Ph Nums Title', "Other Phone Nums", 'Other Phone Nums Ext', 'Other Ph Nums Desc', 'Mobile Phone', 
          'Mobile Phone Ext', 'Mobile Ph Desc', 'Pager Number', 'Pager Ext', 'Pager Desc', 'Fax Number', 'Fax Ext', 'Fax Desc', 'Urgency'
          'Contact Note Date', 'Contact Notes', 'Hidden contacts', 'Secondary FirstName', "Secondary LastName", 'Secondary Initial', 
          'Secondary NickName', 'Secondary Jr_Sr', 'Secondary Mr_Mrs', 'Secondary Title', 'Secondary Designation', 'Secondary Gender', 
          'Secondary Birthday', 'FF FirstName', 'FF LastName', 'FF Birthday', 'FF Relation', 'FF Resident', 'Asst FirstName', 'Asst LastName', 
          'Asst Initial', 'Asst Designation', 'Asst Email', 'Tenant ID', 'Tenant Primary FirstName', 'Tenant Primary LastName', 
          'Tenant Primary Mr/Mrs', 'Tenant Secondary FirstName', 'Tenant Secondary LastName', 'Tenant Secondary Mr/Mrs', 'Tenant Home Phone', 
          'Tenant Home Ext', 'Tenant Home Ph Desc', 'Tenant Business Phone', 'Tenant Bus Ext', 'Tenant Bus Ph Desc', 'Tenant Mobile Phone', 
          'Tenant Mobile Ext', 'Tenant Mobile Ph Desc', 'Address ID', 'Property Type', 'House Number', 'Direction Prefix', 'Street', 
          'Street Designator', 'Direction Suffix', 'Suite No', 'PO_Box', 'Bldg_Floor', 'City', 'County', 'State', 'Zip', 'Country', 'List Price',
          'Sales Price', 'Taxes', 'Tax Year', 'Tax Asses', 'Land Asses', 'Air Con', 'RV Parking', 'Attached', 'Bldg Improve', 'Tax Roll No', 
          'Year Built', 'Bedrooms', 'Bathrooms', 'Lot Size', 'Sq Feet', 'Levels', 'House Style', 'Parking', 'Zoning', 'Flooring', 
          'Dist To Transit', 'Dist To School', 'Last Sold', 'Heating', 'Roof', 'Other Items', 'Construction', 'Exterior', 'Area', 
          'Fireplaces', 'Basement', 'Sewer', 'Water', 'Financing', 'Legal Descr', 'Property Descr', 'Room Type ID', 'Room Description',
          'Room Length', 'Room Width', 'Room Dimension', 'Room', 'Features', 'Site/View', 'Present Min Price', 'Present Max Price', 
          'Present Property ID', 'Present Hm Note Date', 'Present Hm Notes', 'Future Min Price', 'Future Max Price', 'Future House Style', 
          'Future Sq Feet', 'Future Bedrooms', 'Future Bathrooms', 'Future Area', 'Future Dist', 'To School', 'Future Features', 'Future Parking',
          'Future Other Items', 'Future Hm Note Date', 'Future Hm Notes', 'Listing ID', 'List Addr ID', 'List Addr', 'List Exp Date', 
          'List Exp Reminder Date', 'List MLS No', 'List Property Type', 'List House Style', 'Listing Price', 'List Date', 'List Term',
          'List Source', 'List Terms', 'List Status ID', 'List Status', 'List Note Date', 'List Notes', 'List Inclusions', 'List Exclusions',
          'Sellers Name', 'List Seller', 'List Commission', 'How To Show', 'Sign Placed', 'Lock Box Checkbox State', 'Lock Box No', 'Flyer Description',
          'Flyer Text', 'Closing ID', 'Closing Addr ID', 'Closing Addr', 'Closing MLS No', 'Closing Sales price', 'Closing Commission', 
          'Closing Source', 'File No', 'Closing Property Type', 'Acceptance Date', 'Possession Date', 'Closing Date', 'Representation',
          'Closing Party ID', 'Closing Party Name', 'Closing Party Role', 'Closing Party Role ID', 'Closing Status ID', 'Closing Status',
          'Closing Note Date', 'Closing Notes', 'Lead Type', 'Lead Status ID', 'Lead Status', 'Referred Contact ID', 'Referred Contact Name',
          'Referred To/By Contact ID', 'Referred To/By Contact Name', 'Referral Direction', 'Referral Number', 'Referral Source', 
          'Referral Date', 'Transaction Status ID', 'Transaction Status', 'Referral Closing Date', 'Sale price', 'Commission Amount', 
          'Check Amount', 'Check Sent/Received Date', 'Referral Fee Percent', 'Referral Flat Fee', 'Referral Progress ID', 'Referral Progress Status',
          'Referral Note Date', 'Referral Notes'
      ]
   end 
   
   def self.build_hash(record)
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
       entry_point: "CSV Import (Top Producer)",
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
    
end

