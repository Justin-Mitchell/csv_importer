class CreateCsvImports < ActiveRecord::Migration
  def change
    create_table :csv_imports do |t|
      t.string :source
      t.boolean :is_temp
      t.string :lead_type
      t.string :name
      t.integer :user_id,                 :null => false
      t.string :csv
      t.integer :total_records,           :default => 0
      t.integer :new_records_count,       :default => 0
      t.integer :updated_records_count,   :default => 0
      t.boolean :csv_processed,           :default => false
      t.string  :key

      t.timestamps null: false
    end
  end
end
