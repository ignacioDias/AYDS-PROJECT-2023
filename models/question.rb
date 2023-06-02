class Question < ActiveRecord::Base
  belongs_to :exam
  belongs_to :level
  has_and_belongs_to_many :records
end
