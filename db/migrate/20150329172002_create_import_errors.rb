class CreateImportErrors < ActiveRecord::Migration
  def change
    create_table :import_errors do |t|
      t.string :name
      t.string :email
      t.string :field
      t.text :message
      t.references :csv_import, index: true

      t.timestamps null: false
    end
    add_foreign_key :import_errors, :csv_imports
  end
end
