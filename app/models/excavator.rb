class Excavator < ApplicationRecord
  belongs_to :ticket
  validates :company_name, presence: true
end
