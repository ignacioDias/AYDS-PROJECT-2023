class Ranking < ActiveRecord::Base
    belongs_to :user
    validates :user_id, presence: true, uniqueness: true
    validate :consistency_points

    def consistency_points
        user = User.find_by(id: user_id)
        unless user && user.profile.totalPoints == points
            errors.add(:points, "inconsistency in points")
        end 
    end
end

