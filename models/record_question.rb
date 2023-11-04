# frozen_string_literal: true

class RecordQuestion < ActiveRecord::Base
  belongs_to :record
  belongs_to :question
end
