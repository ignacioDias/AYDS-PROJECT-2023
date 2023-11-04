# frozen_string_literal: true

class Level < ActiveRecord::Base
  belongs_to :category
  has_many :questions
  has_many :record_levels
  has_many :records, through: :record_levels

  def self.level_using_name(cat_name, level_name)
    category = category_using_name(cat_name)
    Level.find(category_id: category.id).where(name: level_name)
  end
end
