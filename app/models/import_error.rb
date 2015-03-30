class ImportError < ActiveRecord::Base
  belongs_to :csv_import
  
  def display
    "<strong>#{name} #{email unless email.blank?}</strong>: #{field} #{message}".html_safe
  end
end
