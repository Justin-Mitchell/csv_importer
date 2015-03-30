class CreateLeads < ActiveRecord::Migration
  def change
    create_table :leads do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :kind
      t.string :address1
      t.string :address2
      t.string :city
      t.string :state
      t.string :zipcode
      t.string :source
      t.string :category
      t.string :company
      t.string :title
      t.string :phone_mobile
      t.string :phone_home
      t.string :phone_fax
      t.string :phone_work
      t.date :birthday
      t.date :purchase_date
      t.float :budget
      t.float :purchase_price
      t.integer :rating
      t.float :home_value
      t.string :entry_point
      t.string :alt_email
      t.string :status
      t.string :referred_by
      t.string :skype
      t.string :facebook
      t.string :gchat
      t.string :aol
      t.string :yahoo
      t.string :access
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
