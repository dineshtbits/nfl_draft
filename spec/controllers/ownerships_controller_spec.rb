require 'rails_helper'

describe OwnershipsController do
  describe "Update Ownership - Assign Player" do
    before :all do
      $rake['import:data'].execute
      @draft = Draft.first
      @team_ids = []
      55.times do
        @current_pick = @draft.next_picks.first
        @picked_player = @draft.draftable_players.sample
        @team_ids << @current_pick.team_id
        @current_pick.assign_player(@picked_player.id)
      end
    end

    it "tries to update player id for already assigned ownership and renders the assign_player template if error" do
      @previous_pick = @draft.previous_picks.first
      @drafted_player = @draft.drafted_players.sample
      put "update", {draft_id: @draft.id, id: @previous_pick.id, ownership: {player_id: @drafted_player}}
      expect(response).to render_template("drafts/assign_player")
    end

    it "tries to update player id for already assigned ownership and checks the error message in the body" do
      @previous_pick = @draft.previous_picks.first
      @drafted_player = @draft.drafted_players.sample
      put "update", {draft_id: @draft.id, id: @previous_pick.id, ownership: {player_id: @drafted_player}}
      current_pick = assigns(:current_pick)
      expect(current_pick.errors.full_messages).to include('Player has already been taken')
    end

    it "successfully assignes player and redirects to assign_player" do
      @current_pick = @draft.next_picks.first
      @picked_player = @draft.draftable_players.sample
      @current_pick.assign_player(@picked_player.id)
      put "update", {draft_id: @draft.id, id: @current_pick.id, ownership: {player_id: @picked_player.id}}
      expect(response).to redirect_to(assign_player_draft_url(@draft))
    end

  end
end