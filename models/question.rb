class Question < ActiveRecord::Base
  belongs_to :exam
  belongs_to :level
end
