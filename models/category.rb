# frozen_string_literal: true

class Category < ActiveRecord::Base
  has_one :exam
  has_many :levels

  def self.category_using_name(cat_name)
    Category.find_by(name: cat_name.capitalize)
  end 
end
