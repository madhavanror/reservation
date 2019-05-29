class CreateExcavators < ActiveRecord::Migration[5.2]
  def change
    create_table :excavators do |t|
      t.references :ticket, foreign_key: true
	  t.string  :company_name
	  t.string  :address
	  t.string  :city
	  t.string  :state
	  t.string  :zip_code
	  t.boolean :crew_on_site

      t.timestamps
    end
  end
end
