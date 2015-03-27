class CsvImport < ActiveRecord::Base
  belongs_to :user
  # Carrierwave
  mount_uploader :csv, CsvUploader
  
  after_create :process
  
  class << self
    def source_options_for_select
      [
        ['--------------', 'other'],
        ['Top Producer', 'top_producer'],
        ['MLS Fusion', 'fusion'],
        ['Outlook', 'outlook'],
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
  
  def process
    file = SmarterCSV.process(self.csv.file.path, key_mapping: true)
    self.total_records = file.size
    file.each do |row|
      lead_hash = self.build_record(row, import.lead_type)
      lead = Lead.where(:email => lead_hash[:email])
      if lead.size == 1
        lead.first.update_attributes(lead_hash)
        import.updated_records_count += 1
      else
        lead = import.user.leads.build(lead_hash)
        if lead.valid?
          lead.save
          import.new_records_count += 1
        else
          lead.errors.each do |err|
          end
        end
      end
    end
    self.save!
  end
  
  def build_record(record, type)
    case self.source
    when "top_producer"
      TopProducer.build_hash(record, type)
    when "fusion"
      Fusion.build_hash(record, type)
    when "outlook"
      row[0]
    else
    end
  end

end
