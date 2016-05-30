class OwnershipsController < ApplicationController
  before_action :set_draft_and_current_pick, only: [:update]

  def update
    @current_pick.errors.add(:base, "A player is already assigned to this pick. Please refresh to view next pick.") if @current_pick.player_id.present?
    if @current_pick.assign_player(params[:ownership][:player_id].to_i)
      redirect_to assign_player_draft_url(@draft), notice: 'Player was successfully Assigned.'
    else
      @draftable_players = @draft.draftable_players
      render template: "drafts/assign_player"
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_draft_and_current_pick
      @draft = Draft.find(params[:draft_id])
      @current_pick = Ownership.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ownership_params
      params.require(:ownership).permit(:player_id)
    end
end