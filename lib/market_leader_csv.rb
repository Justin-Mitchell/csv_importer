class MarketLeaderCsv
  
  def self.fields
    [
      "First Name","Last Name","Home Phone","Work Phone","Cell Phone",
      "Primary Email Address","Email Address 2","Email Address 3",
      "Moving From","Looking In","Average Price","Status","Date","Agent",
      "Primary Email Working","Email Working 2","Email Working 3",
      "Has Agent","Requested Pre-Approval","Has Mortgage Lender",
      "Has Listing Alerts","Total Properties Viewed","Timeframe","Source",
      "Address 1","City 1","State 1","Zip 1","Address 2","City 2","State 2",
      "Zip 2","Address 3","City 3","State 3","Zip 3","Address 4","City 4",
      "State 4","Zip 4","Address 5","City 5","State 5","Zip 5",
      "Registered From Agent Site"
    ]
  end
  
  def fields
    self.fields
  end
  
  def status_map
    [
      "New",
      "Retry",
      "Active",
      "Inactive",
      "Hot",
      "Sold",
      "Trash"
    ]
  end
  
  
end