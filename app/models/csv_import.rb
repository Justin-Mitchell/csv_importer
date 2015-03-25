class CsvImport < ActiveRecord::Base
  belongs_to :user
  # Carrierwave
  mount_uploader :csv, CsvUploader
  
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
  
  def file_name
    File.basename(csv.path || csv.filename) if csv
  end
end
