class ImportWorker
  include Sidekiq::Worker
  require 'smarter_csv'
  
  def perform(job_id, file_path)
    data = SmarterCSV.process(file_path, key_mapping: true)
    
    data.each do |line|
      LineImportWorker.perform_async(job_id, line)
    end
  end
end