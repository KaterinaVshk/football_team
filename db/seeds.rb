first_team = Team.find_or_create_by(name: 'Barcelona', country_name: 'Spain')
second_team = Team.find_or_create_by(name: 'Paris Saint-Germain', country_name: 'France')

Match.find_or_create_by(first_team: first_team, second_team: second_team , ended_at: 5.day.ago)
Match.find_or_create_by(first_team: first_team, second_team: second_team , ended_at: 7.day.ago)
Match.find_or_create_by(first_team: first_team, second_team: second_team , ended_at: 1.day.ago)

Indicator.find_or_create_by(name: 'ran more than 10 km')
Indicator.find_or_create_by(name: 'more than 70% accurate passes')
indicators = Indicator.all

# PLAYERS from Paris Saint-Germain

Player.find_or_create_by(name: 'Keylor', surname: 'Navas', player_number: 1, team: second_team)
binding.pry
Player.find_or_create_by(name: 'Achraf', surname: 'Hakimi', player_number: 2, team: second_team) do |player|
  indicators.each do |indecator|
    MatchIndicator.find_or_create_by(indicator: indecator, player: player, match_id: 3)
  end

  MatchIndicator.find_or_create_by(indicator: indicators.second, player: player, match_id: 3)
end

# best player in team
Player.find_or_create_by(name: 'Manuel', surname: 'Ugarte', player_number: 4, team: second_team) do |player|
  indicators.each do |indecator|
    MatchIndicator.find_or_create_by(indicator: indecator, player: player, match_id: 1)
    MatchIndicator.find_or_create_by(indicator: indecator, player: player, match_id: 2)
  end
end

# PLAYERS from Barcelona

Player.find_or_create_by(name: 'Ander', surname: 'Astralaga', player_number: 26, team: first_team) do |player|
  MatchIndicator.find_or_create_by(indicator: indicators.second, player: player, match_id: 2)
end

Player.find_or_create_by(name: 'Ronald', surname: 'Araujo', player_number: 4, team: first_team) do |player|
    MatchIndicator.find_or_create_by(indicator: indicators.first, player: player, match_id: 2)
end

#best player in team and among all
Player.find_or_create_by(name: 'Gavi', player_number: 6, team: first_team) do |player|
  indicators.each do |indecator|
    MatchIndicator.find_or_create_by(indicator: indecator, player: player, match_id: 1)
    MatchIndicator.find_or_create_by(indicator: indecator, player: player, match_id: 2)
    MatchIndicator.find_or_create_by(indicator: indecator, player: player, match_id: 3)
  end
end
