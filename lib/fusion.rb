class Fusion
   
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
    
    def self.build_hash(record)
       address_line_1 = "#{record[:house_number]} #{record[:direction_prefix]} #{record[:street]} #{record[:street_designator]} #{record[:direction_suffix]}"
       address_line_2 = (record[:bldg_floor].blank? ? "#{record[:suite_no]}" : "Bldg #{record[:bldg_floor]} ##{record[:suite_no]}") unless record[:suite_no].blank?
       hash = {
         first_name: record[],
         last_name: record[],
         email: record[],
         kind: record[],
         address1: address_line_1.blank? ? nil : address_line_1.split(' ').join(' '),
         address2: address_line_2.blank? ? nil : address_line_2.split(' ').join(' '),
         city: record[],
         state: record[],
         zipcode: record[],
         source: record[],
         category: record[],
         company: record[],
         phone_mobile: record[],
         phone_home: record[],
         phone_fax: record[],
         phone_work: record[],
         birthday: record[].to_date,
         purchase_date: record[].to_date,
         budget: record[].to_f,
         rating: nil,
         home_value: record[],
         entry_point: "CSV Import (Fusion)",
         alt_email: record[],
         status: record[],
         referred_by: record[],
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