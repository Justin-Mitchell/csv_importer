class ImportWorker
  include Sidekiq::Worker
  require 'smarter_csv'
  require 'open-uri'
  
  def perform(job_id)
    import = CsvImport.find(job_id)
    raw_data = import.csv.file.read
    File.open("/tmp/csv_#{import.id}") { |file| file.write(raw_data) }
    data = SmarterCSV.process("/tmp/csv_#{import.id}", key_mapping: true)
    data.each do |row|
      LineImportWorker.perform_async(job_id, row)
    end
  end
end