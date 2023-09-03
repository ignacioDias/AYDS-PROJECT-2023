class Category < ActiveRecord::Base
  has_many :levels

  validate :must_have_at_least_one_level
  validate :valid_name

  def valid_name
    if name = ""
      errors.add(:name, "Empty name")

  def must_have_at_least_one_level
    if levels.empty?
      errors.add(:levels|, "Category must have at least one associated level")
    end
  end
end
