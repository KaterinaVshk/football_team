require 'rails_helper'

RSpec.describe(Indicator) do
  let(:indicator_1) { build(:indicator) }

  describe 'validations' do
    describe '#name' do
      it 'isn\'t valid without a name' do
        indicator_1.name = nil

        expect(indicator_1).not_to be_valid
      end

      it 'isn\'t valid with a too long name' do
        indicator_1.name = SecureRandom.base64(256)

        expect(indicator_1).not_to be_valid
      end

      it 'isn\'t valid with a not unique values' do
        indicator_2 = create(:indicator)
  
        expect(indicator_1).not_to be_valid
      end
  
      it 'is valid with a unique values' do
        indicator_2 = create(:indicator, name: 'Another description')
  
        expect(indicator_1).to be_valid
      end
    end
  end
end
