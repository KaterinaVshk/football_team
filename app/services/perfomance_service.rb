module PerfomanceService
  module_function

  def assign_indicator_to_player(indicator_id: nil, player_id: nil, match_id: nil)
    return 'Please enter correct indicator_id' if Indicator.find_by(id: indicator_id).blank?
    return 'Please enter correct player_id' if Player.find_by(id: player_id).blank?
    return 'Please enter correct match_id' if Match.find_by(id: match_id).blank?

    match_indicator = MatchIndicator.new(indicator_id: indicator_id, player_id: player_id, match_id: match_id)

    if match_indicator.save
      'Success'
    else
      match_indicator.errors.full_messages.join(',')
    end
  end

  def check_indicator_for_several_matches(indicator_id: nil, player_id: nil, matches_number: 5)
    indicator = Indicator.find_by(id: indicator_id)
    return 'Please enter correct indicator_id' if indicator.blank?

    player = Player.find_by(id: player_id)
    return 'Please enter correct player_id' if player.blank?

    match_indicators = MatchIndicator.joins(:match).where(
      player_id: player.id,
      indicator_id: indicator.id
    ).order(ended_at: :desc).limit(matches_number)

    "Player: #{player.name} #{player.surname}, met the indicator '#{indicator.name}' #{match_indicators.size} times for last #{matches_number} matches"
  end

  def top_5_by_indicator_in_team(team_id: nil, indicator_id: nil)
    return 'Please enter correct team_id' if Team.find_by(id: team_id).blank?
    return 'Please enter correct indicator_id' if Indicator.find_by(id: indicator_id).blank?

    results = MatchIndicator.joins(player: :team).where(teams: { id: team_id }).where(indicator_id: indicator_id).group(:player_id).order(count: :desc).count
    results.keys[0..4].map { |id| Player.find(id) }
  end

  def top_5_players
    results = MatchIndicator.joins(player: :team).group(:player_id).order(count: :desc).count
    results.keys[0..4].map { |id| Player.find(id) }
  end
end
