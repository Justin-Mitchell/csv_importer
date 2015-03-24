class Importer
  
  def initialize(file)
    @data = SmartCSV.process(file.path, key_mapping: true)
  end
  
  
  def determine_mapping(row)
    matches = 0
    row.keys.each do |key|
      if TopProducer.field_names.include?(key)
        "top_producer"
      elsif Fusion.field_names
  end
end