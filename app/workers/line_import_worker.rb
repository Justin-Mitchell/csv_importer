class LineImportWorker
  include Sidekiq::Worker
  require 'smarter_csv'
  
  def perform(job_id, line)
    @import = CsvImport.find(job_id)
    
  end
end