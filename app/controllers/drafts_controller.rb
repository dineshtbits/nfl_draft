class DraftsController < ApplicationController
  before_action :set_draft, only: [:show, :assign_player]

  def index
    @drafts = Draft.all
  end

  def show
    @results = @draft.filter(filter_params)
    @previous_picks = @draft.previous_picks(3).to_a
    @next_picks = @draft.next_picks(4).to_a
    @draftable_players = @draft.draftable_players
    @teams = Team.all
  end

  def assign_player
    @current_pick = @draft.next_picks.first
    redirect_to draft_path(@draft), notice: 'Draft process is completed.' and return if @current_pick.blank?
    @draftable_players = @draft.draftable_players
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_draft
      @draft = Draft.find(params[:id])
    end

    def filter_params
      params.permit(:round, :team_id)
    end
end
