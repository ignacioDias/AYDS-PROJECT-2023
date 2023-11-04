# frozen_string_literal: true

class Exam < ActiveRecord::Base
  belongs_to :category
  has_many :questions
  has_and_belongs_to_many :profiles
  has_many :record_exams
  has_many :records, through: :record_exams
end
