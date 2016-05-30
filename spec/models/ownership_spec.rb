# spec/models/draft_spec.rb
require 'rails_helper'


describe Ownership do
  describe "After the first pick" do
    before :all do
      $rake['import:data'].execute
      @draft = Draft.first
      @current_pick = @draft.next_picks.first
      @picked_player = @draft.draftable_players.sample
      @current_pick.assign_player(@picked_player.id)
    end
    it "is checking for no drafted players" do
      expect(@current_pick.player_id).to eql(@picked_player.id)
    end

    it "is checking if selected player not in the draftable_players" do
      expect(@draft.draftable_players.collect(&:id)).not_to  include(@picked_player.id)
    end
  end
end