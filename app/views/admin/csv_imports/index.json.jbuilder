json.array!(@csv_imports) do |csv_import|
  json.extract! csv_import, :id, :source, :is_temp, :name, :user_id, :csv
  json.url csv_import_url(csv_import, format: :json)
end
