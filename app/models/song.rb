# frozen_string_literal: true

class Song < ApplicationRecord
  validates :title, presence: true
  validates_uniqueness_of :title, scope: :release_year
  validate :release_year_must_be_present_if_released
  validate :release_year_must_be_in_the_past, if: :released?

  private

  def release_year_must_be_present_if_released
    if released && !release_year.present?
      errors.add(:release_year, 'must be present if released')
    end
  end

  def release_year_must_be_in_the_past
    if released && release_year && release_year > Time.now.year
      errors.add(:release_year, 'must be in the past')
    end
  end
end
