class Level < ActiveRecord::Base
  belongs_to :category
  has_many :questions
  has_many :record_levels
  has_many :records, through: :record_levels
end

