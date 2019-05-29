class Ticket < ApplicationRecord
  has_one :excavator , dependent: :destroy

  validates :request_number, presence: true
  validates :request_type, presence: true
  serialize :additional_sa_code

  def self.create_ticket(ticket_params, excavator_params)
    ActiveRecord::Base.transaction do
      ticket = self.new(ticket_params)
      ticket.save!
      excavator = Excavator.new(excavator_params.merge(ticket: ticket))
      return  [true, ticket, nil] if excavator.save!(excavator_params)
    end
    rescue ActiveRecord::RecordInvalid => ex
    [false, nil, ex.message.split(': ').drop(1) ]
  end

  def self.convert_polygon(polygon)
    polygon.gsub('POLYGON((', '').gsub('))', '').gsub(' ',',-').split(',').map(&:to_f).each_slice(2).to_a
  end
end
