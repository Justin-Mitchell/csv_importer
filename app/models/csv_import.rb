class CsvImport < ActiveRecord::Base
  # Requirements
  mount_uploader :csv, CsvUploader
  
  # Relations
  belongs_to :user
  has_many :import_errors

  # Validations
  after_create :process
  
  # ClassMethods
  class << self
    def source_options_for_select
      [
        ['--------------', 'other'],
        ['Top Producer', 'top_producer'],
        ['MLS Fusion', 'fusion'],
        ['Outlook', 'outlook'],
        ['Google', 'google'],
        ['Remax', 'remax'],
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
  end
  
  # Instance Methods
  def load_csv_file_data
    SmarterCSV.process(self.csv.file.path, key_mapping: true) 
  rescue CSV::MalformedCSVError
    Rails.logger.error { "Error while loading csv file for: #{self.csv.file.original_filename}, #{e.message} #{e.backtrace.join("\n")}" }
    flash[:error] = "The uploaded file, #{self.csv.file.original_filename}, was malformed or not in CSV format." 
    return false
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
      TopProducer.build_hash(record, type)
    when "fusion"
      Fusion.build_hash(record, type)
    when "outlook"
      row[0]
    when "google"
      #Fusion.build_hash(record, type)
      obj = GoogleCsv.new(record, type)
      obj.build_hash
    when "other"
      raise
    else
    end
  end
  
  def process
    @data = load_csv_file_data
    set_total_records_count(@data.size)
    @data.each do |row|
      lead_hash = build_record(row, lead_type)
      lead = Lead.find_by(:email => lead_hash[:email], :first_name => lead_hash[:first_name], :last_name => lead_hash[:last_name])
      if lead
        lead.update_attributes(lead_hash)
        self.updated_records_count += 1
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
