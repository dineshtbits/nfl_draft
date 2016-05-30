require 'rails_helper'

describe DraftsController do
  describe "GET Index" do
    before :all do
      $rake['import:data'].execute
    end
    it "gets the index view" do
      get "index"
      expect(response.status).to eql(200)
    end

    it "gets the correct index view template" do
      get "index"
      expect(response).to render_template("drafts/index")
    end

    it "checks the result" do
      get 'index'
      expect(assigns(:drafts).count).to eql(1)
    end
  end

  describe "GET Show" do
    before :all do
      $rake['import:data'].execute
      @draft = Draft.first
      @team_ids = []
      30.times do
        @current_pick = @draft.next_picks.first
        @picked_player = @draft.draftable_players.sample
        @team_ids << @current_pick.team_id
        @current_pick.assign_player(@picked_player.id)
      end
    end

    it "checks the results of filters by round" do
      params = {id: @draft.id, round: 1}
      get 'show', params
      expect(assigns(:results)[:by_round]).not_to be_empty
    end

    it "checks the results of filters by team" do
      params = {id: @draft.id, team_id: @team_ids.sample}
      get 'show', params
      expect(assigns(:results)[:by_team]).not_to be_empty
    end

    it "checks next_picks" do
      params = {id: @draft.id}
      get 'show', params
      expect(assigns(:next_picks).count).to eql(4)
    end

    it "checks previous_picks" do
      params = {id: @draft.id}
      get 'show', params
      expect(assigns(:previous_picks).count).to eql(3)
    end

    it "checks draftable_players" do
      params = {id: @draft.id}
      get 'show', params
      expect(assigns(:draftable_players).count).to eql(Player.count-30)
    end


    it "checks teams data" do
      params = {id: @draft.id}
      get 'show', params
      expect(assigns(:teams).count).to eql(Team.count)
    end

  end
end