# frozen_string_literal: true

class Profile < ActiveRecord::Base
  belongs_to :user
  has_and_belongs_to_many :exams
  validates :user_id, presence: true, uniqueness: true
end
