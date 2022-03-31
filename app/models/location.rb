# frozen_string_literal: true

class Location < ActiveRecord::Base
  belongs_to :region
  has_many :people

  scope :alphabetically_by_region, lambda {
    joins(:region).merge(Region.alphabetical_order).order(:name)
  }

  # NOTE: https://stackoverflow.com/questions/27106853/rails-pgundefinedtable-error-missing-from-clause-entry-for-table
  def self.in_region(region_name)
    joins(:region).preload(:region).where(regions: { name: region_name })
  end
end
