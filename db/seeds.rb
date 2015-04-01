# Generated with RailsBricks
# Initial seed file to use with Devise User Model
require 'ffaker'

# Arrays Used to create seed data
@kind = Lead.kind_options.map {|p| p[1]}
@kind << nil # included for completeness

@source = Lead.source_options.map {|p| p[1]}
@source << nil

@price = (50000..900000).to_a

@status = ['New', 'Active', 'Active-Hot', 'Closed', 'Inactive', 'Casual', nil, nil, 'Cold']

# Temporary admin account
u = User.new(
    email: ENV['ADMIN_EMAIL'],
    password: ENV['ADMIN_PASS'],
    password_confirmation: ENV['ADMIN_PASS'],
    admin: true
)
u.skip_confirmation!
u.save!

# Test user accounts
(1..50).each do |i|
  u = User.new(
      email: "user#{i}@example.com",
      password: "1234",
      password_confirmation: "1234"
  )
  u.skip_confirmation!
  u.save!

  puts "#{i} test users created..." if (i % 5 == 0)

end

# Example Leads Associated to First User
(1..50).each do |i|
  l = Lead.new(
         first_name: FFaker::Name.first_name,
         last_name: FFaker::Name.last_name,
         email: FFaker::Internet.email,
         kind: @kind.sample,
         address1: [nil, FFaker::Address.street_address].sample,
         address2: [nil, nil, nil, nil, FFaker::Address.secondary_address].sample,
         city: ['Las Vegas', 'Henderson', 'North Las Vegas'].sample,
         state: 'Nevada',
         zipcode: FFaker::AddressUS.zip_code,
         source: @source.sample,
         title: FFaker::Company.position,
         company: FFaker::Company.name,
         category: FFaker::Skill.tech_skill,
         phone_mobile: FFaker::PhoneNumber.short_phone_number,
         phone_home: FFaker::PhoneNumber.short_phone_number,
         phone_fax: FFaker::PhoneNumberSG.toll_free_number,
         phone_work: FFaker::PhoneNumber.short_phone_number,
         birthday: FFaker::Time.date.to_date,
         purchase_date: FFaker::Time.date.to_date,
         budget: @price.sample.to_f,
         rating: [0,1,2,3,4,5].sample,
         home_value: @price.sample.to_f,
         entry_point: "CSV Import " + ['(Fusion)', '(Outlook)', '(Top Producer)'].sample,
         alt_email: FFaker::Internet.email,
         status: @status.sample,
         referred_by: FFaker::Name.name,
         skype: 'skype:' + FFaker::Internet.user_name + '?call',
         facebook: "https://www.facebook.com/" + FFaker::Internet.user_name,
         gchat: "https://plus.google.com/" + FFaker::Internet.user_name,
         aol: "aol:" + FFaker::Internet.user_name,
         yahoo: "yahoo:" + FFaker::Internet.user_name,
         access: 'Public',
         user_id: User.first.id
  )
  l.save!
  
  puts "#{i} test leads created..." if (i % 5 == 0)
     
end
