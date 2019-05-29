require 'rails_helper'

RSpec.describe Ticket, type: :model do

  let!(:ticket){ create(:ticket, request_number: '234567', request_type: 'Normal')}
  let!(:excavator){ create(:excavator, company_name: 'John Doe CONSTRUCTION', ticket: ticket) }  
  let(:ticket_params) do
  	{
      request_number: '09252012-00001',
      request_type: 'Normal',
    }
  end

  let(:excavator_params) do
  	{
      company_name: 'John Doe CONSTRUCTION'
    }
  end

  let(:polygon_params) do
    polygon = [[-81.13390268058475, -32.07206917625161], [-81.14660562247929, -32.04064386441295], [-81.08858407706913, -32.02259853170128], [-81.05322183341679, -32.02434500961698], [-81.05047525138554, -32.042681017283066], [-81.0319358226746, -32.06537765335268], [-81.01202310294804, -32.078469305179404], [-81.02850259513554, -32.07963291684719], [-81.07759774894413, -32.07090546831167], [-81.12154306144413, -32.08806865844325], [-81.13390268058475, -32.07206917625161]]
  end

  describe 'Associations' do
    it { is_expected.to have_one(:excavator) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:request_number) }
    it { should validate_presence_of(:request_type) }
    it { should serialize(:additional_sa_code) }
  end

  it 'is valid with valid attributes' do
    expect(ticket).to be_valid
  end

  it 'is not valid without a request number' do
    ticket.request_number = nil
    expect(ticket).to_not be_valid
  end

  it 'is not valid without a request type' do
    ticket.request_type = nil
    expect(ticket).to_not be_valid
  end

  it 'is valid with return status, object, errors' do
    status, object, errors = Ticket.create_ticket(ticket_params, excavator_params)
    expect(status).to eq true
    expect(object).to be_valid
    expect(errors).to eq nil
  end

  it 'is not valid with return Request Type error' do
    status, object, errors = Ticket.create_ticket(ticket_params.except(:request_type), excavator_params)
    expect(status).to eq false
    expect(object).to eq nil
    expect(errors).to eq ["Request type can't be blank"]
  end

  it 'is not valid with return Request Number error' do
    status, object, errors = Ticket.create_ticket(ticket_params.except(:request_number), excavator_params)
    expect(status).to eq false
    expect(object).to eq nil
    expect(errors).to eq ["Request number can't be blank"]
  end

  it 'is not valid with return Company Name error' do
    status, object, errors = Ticket.create_ticket(ticket_params, excavator_params.except(:company_name))
    expect(status).to eq false
    expect(object).to eq nil
    expect(errors).to eq ["Company name can't be blank"]
  end

  it 'is convert string to google maps polygon' do
    polygon = [[-81.13390268058475, -32.07206917625161], [-81.14660562247929, -32.04064386441295],
               [-81.08858407706913, -32.02259853170128], [-81.05322183341679, -32.02434500961698],
               [-81.05047525138554, -32.042681017283066], [-81.0319358226746, -32.06537765335268],
               [-81.01202310294804, -32.078469305179404], [-81.02850259513554, -32.07963291684719],
               [-81.07759774894413, -32.07090546831167], [-81.12154306144413, -32.08806865844325],
               [-81.13390268058475, -32.07206917625161]]
    ticket.digi_site_info = "POLYGON((-81.13390268058475 32.07206917625161,-81.14660562247929 32.04064386441295,-81.08858407706913 32.02259853170128,-81.05322183341679 32.02434500961698,-81.05047525138554 32.042681017283066,-81.0319358226746 32.06537765335268,-81.01202310294804 32.078469305179404,-81.02850259513554 32.07963291684719,-81.07759774894413 32.07090546831167,-81.12154306144413 32.08806865844325,-81.13390268058475 32.07206917625161))"
    check_polygon = Ticket.convert_polygon(ticket.digi_site_info)
    expect(check_polygon).to eq polygon
  end
end
