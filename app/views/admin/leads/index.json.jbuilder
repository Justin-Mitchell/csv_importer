json.array!(@leads) do |lead|
  json.extract! lead, :id, :first_name, :last_name, :email, :kind, :address1, :address2, :city, :state, :zipcode, :source, :category, :company, :phone_mobile, :phone_home, :phone_fax, :phone_work, :birthday, :purchase_date, :budget, :purchase_price, :rating, :home_value, :entry_point, :alt_email, :status, :referred_by, :skype, :facebook, :gchat, :aol, :yahoo, :access, :user_id
  json.url lead_url(lead, format: :json)
end
