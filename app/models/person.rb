# frozen_string_literal: true

class Person < ActiveRecord::Base
  belongs_to :location
  belongs_to :role
  belongs_to :manager, class_name: 'Person', foreign_key: :manager_id
  has_many :employees, class_name: 'Person', foreign_key: :manager_id

  def self.in_region(region)
    locations.merge(Location.in_region(region))
  end

  def self.alphabetically_by_region_and_location
    locations.merge(Location.alphabetically_by_region).order(:name)
  end

  def self.locations
    @locations ||= joins(:location).preload(:location)
  end

  private_class_method :locations
end
