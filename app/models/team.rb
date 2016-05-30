class Team < ActiveRecord::Base
  belongs_to :division
  has_many :ownerships
  has_many :players, through: :ownerships

end
