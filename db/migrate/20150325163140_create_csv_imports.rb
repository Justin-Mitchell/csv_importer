class CreateCsvImports < ActiveRecord::Migration
  def change
    create_table :csv_imports do |t|
      t.string :source
      t.boolean :is_temp
      t.string :lead_type
      t.string :name
      t.integer :user_id
      t.string :csv
      t.integer :total_records
      t.integer :new_records_count
      t.integer :updated_records_count
      t.boolean :csv_processed,           default: false
      t.string  :key

      t.timestamps null: false
    end
  end
end
