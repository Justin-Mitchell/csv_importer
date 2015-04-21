class CsvImport < ActiveRecord::Base
  # Requirements
  mount_uploader :csv, CsvUploader
  
  # Relations
  belongs_to :user
  has_many :import_errors

  # Callbacks
  before_validation :validate_file_is_processable
  after_validation  :set_csv_source
  after_create      :choose_processing_stratigy
  
  # ClassMethods
  class << self
    def source_options_for_select
      [
        ['--------------', 'other'],
        ['MLS Fusion', 'fusion'],
        ['Top Producer', 'top_producer'],
        ['Lead Street', 'remax'],
        ['Market Leader', 'market_leader'],
        ['Outlook', 'outlook'],
        ['Google', 'google'],
        ['Yahoo', 'yahoo'],
        ['Other', 'other']
      ]
    end
    
    def lead_type_options_for_select
      [
        ['--------------', 'mixed'],
        ['Buyers', 'buyer'],
        ['Sellers', 'seller'],
        ['Investors', 'investors'],
        ['Renters', 'renter'],
        ['Past Clients', 'past_clients'],
        ['Vendors', 'vendor'],
        ['Agents', 'agent'],
        ['Mixed', 'mixed']
      ]
    end
    
    def matchers
      [
        "name",
        "address",
        "email",
        "phone",
        "status",
        "source"
      ]
    end
  end
  
  # Instance Methods
  def choose_processing_stratigy
    if self.source.include?('other') then self.manual_process else self.automated_process end
  end
  
  def set_csv_source
    source = get_csv_source_from_header
    self.source = source
  end
  
  def get_csv_source_from_header
    row = fetch_header_row
    results = {}
    results[:fusion] = (row & FusionCsv.field_names).size
    results[:top_producer] = (row & TopProducerCsv.field_names).size
    results[:google] = (row & GoogleCsv.field_names).size
    results[:yahoo] = (row & YahooCsv.field_names).size
    results[:remax] = (row & RemaxCsv.field_names).size
    results[:outlook] = (row & OutlookCsv.field_names).size
    results[:market_leader] = (row & MarketLeaderCsv.field_names).size
    if results.values.uniq.sort.reverse[0] == 0
      'other'
    else
      results.sort_by {|_key, value| value}.reverse.first[0].to_s
    end
  end
  
  def validate_file_is_processable
    row = fetch_header_row
    if row && is_header_row?(row)
      true
    else
      self.source = 'Malformed CSV'
      raise CSV::MalformedCSVError
    end
  end
  
  def is_header_row?(row)
    headers = row.compact.map(&:downcase)
    @results = []
    headers.each do |col_name|
      CsvImport.matchers.each do |match|
        if col_name.include?(match)
          @results << col_name
        end
      end
    end
    if @results.size >= 3
      true
    else
      false
    end
  end
  
  def fetch_header_row
    temp = CSV.read(self.csv.file.path)
    temp.first
  end
  
  def load_csv_file_data
    SmarterCSV.process(self.csv.file.path, key_mapping: true) 
  end
  
  def set_total_records_count(size)
    update_attribute(:total_records, size) if size && size.is_a?(Integer)
  rescue => e
    Rails.logger.error { "Error while setting total records count for: #{name}, #{e.message} #{e.backtrace.join("\n")}" }
    nil
  end
  
  def build_record(record, type)
    case self.source
    when "top_producer"
      TopProducerCsv.build_hash(record, type)
    when "fusion"
      FusionCsv.build_hash(record, type)
    when 'remax'
      RemaxCsv.build_hash(record, type)
    when 'yahoo'
      YahooCsv.build_hash(record, type)
    when "outlook"
      OutlookCsv.build_hash(record, type)
    when "google"
      obj = GoogleCsv.new(record, type)
      obj.build_hash
    when "other"
      OtherCsv.build_hash(record, type)
    else
      raise
    end
  end
  
  def manual_process
    @data = load_csv_file_with_empty_values
    
    set_total_records_count(@data.size)
  end
  
  def automated_process
    @data = load_csv_file_data
    set_total_records_count(@data.size)
    @data.each do |row|
      lead_hash = build_record(row, lead_type)
      lead = Lead.find_by(:email => lead_hash[:email], :first_name => lead_hash[:first_name], :last_name => lead_hash[:last_name])
      if lead
        lead.update_attributes(lead_hash)
        if lead.flagged
          self.updated_records_count += 1
          lead.update_attribute(:flagged, false)
        end
      else
        lead = user.leads.build(lead_hash)
        if lead.valid?
          lead.save
          self.new_records_count += 1
        else
          lead.errors.each do |attribute, error|
            err = self.import_errors.build({name: "#{lead.first_name} #{lead.last_name}", email: lead.email, field: attribute, message: error})
            err.save!
          end
        end
      end
    end
    self.csv_processed = true
    self.save!
  end

end
