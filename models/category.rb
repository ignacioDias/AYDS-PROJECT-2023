# frozen_string_literal: true

class Category < ActiveRecord::Base
  has_one :exam
  has_many :levels
end
