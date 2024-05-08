require 'rails_helper'

RSpec.describe(Team) do
  let(:first_team) { build(:team) }

  describe 'validations' do
    describe '#name' do
      it 'isn\'t valid without a name' do
        first_team.name = nil

        expect(first_team).not_to be_valid
      end

      it 'isn\'t valid with a too long name' do
        first_team.name = SecureRandom.base64(256)

        expect(first_team).not_to be_valid
      end

      it 'isn\'t valid with a not unique values' do
        first_team = create(:team)
        second_team = build(:team, name: first_team.name, country_name: first_team.country_name)

        expect(second_team).not_to be_valid
      end
  
      it 'is valid with a unique values' do
        first_team = create(:team)
  
        expect(first_team).to be_valid
      end
    end

    describe '#country_name' do
      it 'isn\'t valid without a country_name' do
        first_team.country_name = nil

        expect(first_team).not_to be_valid
      end

      it 'isn\'t valid with a too long country_name' do
        first_team.country_name = SecureRandom.base64(256)

        expect(first_team).not_to be_valid
      end

      it 'isn\'t valid with a too short country_name' do
        first_team.country_name = '1'

        expect(first_team).not_to be_valid
      end
    end
  end
end
