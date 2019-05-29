class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string   :request_number, index: true
      t.string   :sequence_number
      t.string   :request_type
      t.string   :primary_sa_code
      t.string   :additional_sa_code
      t.text     :digi_site_info
      t.datetime :due_date_time

      t.timestamps
    end
  end
end
