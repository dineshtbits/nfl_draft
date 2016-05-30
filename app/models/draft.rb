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

  def filter(params)
    results = {by_round: [], by_team: []}

    params[:round] = params[:round].to_i > 0 ? params[:round].to_i : 1
    results[:by_round] = ownerships.where.not(player_id: nil).where(round: params[:round]).all

    params[:team_id] = params[:team_id].to_i > 0 ? params[:team_id].to_i : Team.first.id
    results[:by_team] = ownerships.where.not(player_id: nil).where(team_id: params[:team_id]).all
    results
  end
end
