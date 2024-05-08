# README

* Ruby version - 3.0.2

* Creating database: rails db:create

* Migrating database: rails db:migrate

* Create seeds: rails db:seed

* Run tests: rspec

**Example of usage:**

`PerfomanceService.assign_indicator_to_player(indicator_id: 1, player_id: 7, match_id: 1)`

`PerfomanceService.check_indicator_for_several_matches(indicator_id: 1, player_id: 7, matches_number: 5)`

`PerfomanceService.top_5_by_indicator_in_team(team_id: 1, indicator_id: 1)`

`PerfomanceService.top_5_players`
