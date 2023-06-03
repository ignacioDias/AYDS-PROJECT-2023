class RecordExam < ActiveRecord::Base
  belongs_to :record
  belongs_to :exam
end
