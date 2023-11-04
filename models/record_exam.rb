# frozen_string_literal: true

class RecordExam < ActiveRecord::Base
  belongs_to :record
  belongs_to :exam
end
