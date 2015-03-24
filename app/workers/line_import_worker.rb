class LineImportWorker
  include Sidekiq::Worker
  require 'smarter_csv'
  
  def perform(job_id, line)
    data = TopProducer.build_hash(line)
    
    lead = Lead.where(:email => lead_hash[:email]).first
    if lead
        lead.update_attributes(lead_hash)
    else
        Lead.create!(lead_hash)
    end
  end