# frozen_string_literal: true

class Profile < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :exams
  validates :user_id, presence: true, uniqueness: true

  def self.update_points_profile(points, user_id)
    profile = Profile.find_by(user_id: user_id)
    new_total = profile.totalPoints + points
    profile.update(totalPoints: new_total)
    ranking = Ranking.find_by(user_id: user_id)
    ranking.update(points: new_total)
  end
end
