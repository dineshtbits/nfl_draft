# spec/models/draft_spec.rb
require 'rails_helper'
require 'rake'

describe Draft do
  describe "Before the first pick" do
    before :all do
      $rake['import:data'].execute
      @draft = Draft.first
    end

    it "is an instance draft" do
      expect(@draft).to be_instance_of(Draft)
    end

    it "has a valid draft year" do
      expect(@draft.year).to eql(2010)
    end

    it "is checking for no drafted players" do
      expect(@draft.drafted_players).to be_empty
    end

    it "is checking for draftable players" do
      expect(@draft.draftable_players.count).to eql(Player.count)
    end

    it "is checking the next pick to be first pick " do
      expect(@draft.next_picks.first.pick).to eql(1)
    end

    it "is checking the next pick to be first round" do
      expect(@draft.next_picks.first.round).to eql(1)
    end
  end

  describe "After the first pick" do
    before :all do
      $rake['import:data'].execute
      @draft = Draft.first
      @current_pick = @draft.next_picks.first
      @picked_player = @draft.draftable_players.sample
      @current_pick.assign_player(@picked_player.id)
      @current_pick = @draft.next_picks.first
    end
    it "is checking for no drafted players" do
      expect(@draft.drafted_players.count).to eql(1)
    end

    it "is checking for draftable players" do
      expect(@draft.draftable_players.count).to eql(Player.count - 1)
    end

    it "is checking the next pick to be first pick " do
      expect(@draft.next_picks.first.pick).to eql(2)
    end

    it "is checking the next pick to be first round" do
      expect(@draft.next_picks.first.round).to eql(1)
    end

    it "is checking the previous picks " do
      expect(@draft.previous_picks(3).count).to eql(1)
    end

    it "is checking if selected player not in the draftable_players" do
      expect(@draft.draftable_players.collect(&:id)).not_to  include(@picked_player.id)
    end
  end

  describe "After 10 picks" do
    before :all do
      $rake['import:data'].execute
      @draft = Draft.first
      @picked_players = []
      10.times do
        @current_pick = @draft.next_picks.first
        @picked_player = @draft.draftable_players.sample
        @picked_players << @picked_player.id
        @current_pick.assign_player(@picked_player.id)
      end
    end
    it "is checking for no drafted players" do
      expect(@draft.drafted_players.count).to eql(10)
    end

    it "is checking for draftable players" do
      expect(@draft.draftable_players.count).to eql(Player.count - 10)
    end

    it "is checking the next pick to be 11th pick " do
      expect(@draft.next_picks.first.pick).to eql(11)
    end

    it "is checking the previous picks " do
      expect(@draft.previous_picks(3).count).to eql(3)
    end

    it "is checking the next pick to be second round" do
      expect(@draft.next_picks.first.round).to eql(1)
    end

    it "is checking if selected player not in the draftable_players" do
      expect(@draft.draftable_players.collect(&:id)).not_to  include(@picked_playes)
    end
  end
end