require 'rails_helper'

RSpec.describe(Player) do
  let(:player_1) { build(:player) }

  describe 'validations' do
    describe '#name' do
      it 'isn\'t valid without a name' do
        player_1.name = nil

        expect(player_1).not_to be_valid
      end
    end

    describe '#player_number' do
      it 'isn\'t valid without a player_number' do
        player_1.player_number = nil

        expect(player_1).not_to be_valid
      end

      it 'isn\'t valid with a not unique values' do
        player_2 = create(:player)
        player_1 = build(:player, team: player_2.team, player_number: player_2.player_number)
  
        expect(player_1).not_to be_valid
      end

      it 'is valid with a unique values' do
        player_1 = create(:player, player_number: 2)
        player_2 = build(:player, team: player_1.team)
  
        expect(player_2).to be_valid
      end
    end
  end

  describe 'associations' do
    it { is_expected.to(belong_to(:team)) }
  end
end
