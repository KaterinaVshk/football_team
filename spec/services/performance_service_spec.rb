require 'rails_helper'

RSpec.describe PerfomanceService, type: :model do
  let(:player) { create(:player) }
  let(:indicator) { create(:indicator) }
  let(:match) { create(:match, ended_at: 1.day.ago) }
  let(:match_indicator) { create(:match_indicator, player: player, indicator: indicator, match: match) }

  describe '#assign_indicator_to_player' do
    context 'when match_indicator is new' do 
      it 'assigns indicator to player' do
        res = described_class.assign_indicator_to_player(player_id: player.id, indicator_id: indicator.id, match_id: match.id)

        expect(res).to(eq('Success'))
        expect(player.indicators.last.id).to(eq(indicator.id))
      end

      it 'returns error if indicator_id is invalid' do 
        res = described_class.assign_indicator_to_player(indicator_id: indicator.id + 1)

        expect(res).to(eq('Please enter correct indicator_id'))
      end
      
      it 'returns error if player_id is invalid' do 
        res = described_class.assign_indicator_to_player(player_id: player.id + 1, indicator_id: indicator.id)

        expect(res).to(eq('Please enter correct player_id'))
      end
          
      it 'returns error if match_id is invalid' do 
        res = described_class.assign_indicator_to_player(player_id: player.id, indicator_id: indicator.id, match_id: match.id + 1)

        expect(res).to(eq('Please enter correct match_id'))
      end 
    end

    context 'when match_indicator is duplicate' do
      before { match_indicator }

      it 'returns error' do
        res = described_class.assign_indicator_to_player(player_id: player.id, indicator_id: indicator.id, match_id: match.id)

        expect(res).to(eq('Indicator has already been taken'))
      end
    end
  end

  describe '#check_indicator_for_several_matches' do
    context 'when match_indicator is present' do
      before { match_indicator }
      
      it 'returns number of indicators for specific player' do
        res = described_class.check_indicator_for_several_matches(player_id: player.id, indicator_id: indicator.id)

        expect(res).to include('1 times')
      end

      it 'returns number only for last 5 matches' do
        6.times do 
          match = create(:match, ended_at: Time.now - 1.day)
          create(:match_indicator, player: player, indicator: indicator, match: match)
        end

        res = described_class.check_indicator_for_several_matches(player_id: player.id, indicator_id: indicator.id)

        expect(res).to include('5 times')
      end

      it 'returns error if indicator_id is invalid' do 
        res = described_class.check_indicator_for_several_matches(indicator_id: indicator.id + 1)

        expect(res).to(eq('Please enter correct indicator_id'))
      end
      
      it 'returns error if player_id is invalid' do 
        res = described_class.check_indicator_for_several_matches(player_id: player.id + 1, indicator_id: indicator.id)

        expect(res).to(eq('Please enter correct player_id'))
      end
    end

    context 'when match_indicator is not present' do      
      it 'returns number of indicators for specific player' do
        res = described_class.check_indicator_for_several_matches(player_id: player.id, indicator_id: indicator.id)

        expect(res).to include('0 times')
      end
    end
  end

  describe '#top_5_by_indicator_in_team' do
    let(:team) { create(:team) }
    let(:match) { create(:match, ended_at: 1.day.ago, first_team: team) }
    let(:second_match) { create(:match, ended_at: 2.day.ago, first_team: team) }
    let(:best_player) { create(:player, team: team) }  

    before do 
      6.times do
        player =  create(:player, team: team)
        create(:match_indicator, player: player, indicator: indicator, match: match)
      end

      create(:match_indicator, player: best_player, indicator: indicator, match: match)
      create(:match_indicator, player: best_player, indicator: indicator, match: second_match)
    end

    context 'when match_indicator is present' do
      it 'returns top 5 players' do
        res = described_class.top_5_by_indicator_in_team(team_id: team.id, indicator_id: indicator.id)

        expect(res.first).to eq(best_player)
        expect(res.size).to eq(5)
      end

      it 'returns error if indicator_id is invalid' do 
        res = described_class.top_5_by_indicator_in_team(team_id: team.id, indicator_id: indicator.id + 30)

        expect(res).to(eq('Please enter correct indicator_id'))
      end
      
      it 'returns error if team_id is invalid' do 
        res = described_class.top_5_by_indicator_in_team(team_id: team.id + 30, indicator_id: indicator.id)

        expect(res).to(eq('Please enter correct team_id'))
      end
    end

    context 'when match_indicator is not present' do
      let(:second_indicator) { create(:indicator, name: 'Some description') }

      it 'returns top 5 players' do
        res = described_class.top_5_by_indicator_in_team(team_id: team.id, indicator_id: second_indicator.id)

        expect(res).to eq([])
      end
    end
  end

  describe '#top_5_players' do
    let(:match) { create(:match, ended_at: 1.day.ago) }
    let(:second_match) { create(:match, ended_at: 2.day.ago) }
    let(:best_player) { create(:player) }  

    context 'when match_indicator is present' do
      before do 
        10.times do
          player =  create(:player)
          create(:match_indicator, player: player, indicator: indicator)
        end
  
        create(:match_indicator, player: best_player, indicator: indicator, match: match)
        create(:match_indicator, player: best_player, indicator: indicator, match: second_match)
      end

      it 'returns top 5 players' do
        res = described_class.top_5_players

        expect(res.first).to eq(best_player)
        expect(res.size).to eq(5)
      end
    end

    context 'when indicators is not exists' do
      it 'returns top 5 players' do
        res = described_class.top_5_players

        expect(res).to eq([])
      end
    end
  end
end