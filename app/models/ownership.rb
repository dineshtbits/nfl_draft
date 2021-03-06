class Ownership < ActiveRecord::Base
  belongs_to :team
  belongs_to :player
  belongs_to :draft
  validates_uniqueness_of :player_id, :allow_nil => true, :scope => :draft_id

  def assign_player(player_id)
    self.player_id = player_id
    self.save
  end
end
