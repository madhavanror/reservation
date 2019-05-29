require 'rails_helper'

RSpec.describe Excavator, type: :model do
  
  describe 'Associations' do
    it { is_expected.to belong_to(:ticket) }
  end

  describe 'Validations' do
    it { should validate_presence_of(:company_name) }
  end
end
