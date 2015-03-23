class String
  
  # Converts Given String To Underscored String
  # Examples:
  #   CamelCasedStrings         # => camel_cased_strings
  #   CamelCase::Error          # => camel_case/error
  #   Regular spaced            # => regular_spaced
  #   "\xEF\xBB\xBFFirst Name"  # => first_name
  def to_underscore
    string = self.clean
    string = ActiveSupport::Inflector.underscore(string)
    string.gsub!(" ", '_')
  end
  
  # Removes invalid byte codes from string
  # Example:
  #   "\xEF\xBB\xBFFirst Name"  => "First Name"
  def clean
    self.encode!('UTF-8', :invalid => :replace, :undef => :replace, replace: '')
  end
  
end

#  @csv_array = CSV.parse(open(docs[2].data.url).read)

# uploads.each do |doc|
#   csv = CSV.parse(open(doc.data.url).read)
#   @headers << csv.first
# end 