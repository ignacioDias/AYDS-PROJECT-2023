# frozen_string_literal: true

class RecordLevel < ActiveRecord::Base
  belongs_to :record
  belongs_to :level
end
