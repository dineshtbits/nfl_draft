class Draft < ActiveRecord::Base
  has_many :ownerships

  def next_picks(limit = 1)
    ownerships.where(player_id: nil).order(:pick).limit(limit)
  end

  def previous_picks(limit = 1)
    ownerships.where.not(player_id: nil).order("pick desc").limit(limit)
  end

  def drafted_players
    ownerships.where.not(player_id: nil).pluck(:player_id)
  end

  def draftable_players
    Player.where.not(id: drafted_players).all
  end

  def filter(options)
    set_default_round_to_1(options)
    set_default_team_to_first_team(options)
    {by_round: fetch_results_by_round(options), by_team: fetch_results_by_team(options)}
  end

  private

  def set_default_round_to_1 options
    options[:round] = options[:round].to_i > 0 ? options[:round].to_i : 1
  end

  def fetch_results_by_round options
    ownerships.where.not(player_id: nil).where(round: options[:round]).all
  end

  def set_default_team_to_first_team options
    options[:team_id] = options[:team_id].to_i > 0 ? options[:team_id].to_i : Team.first.id
  end

  def fetch_results_by_team options
    ownerships.where.not(player_id: nil).where(team_id: options[:team_id]).all
  end
end
