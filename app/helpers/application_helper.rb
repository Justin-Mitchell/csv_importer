module ApplicationHelper
  def title(value)
    unless value.nil?
      @title = "#{value} | CsvImporter"
    end
  end
end
