# frozen_string_literal: true

class Person < ActiveRecord::Base
  belongs_to :location
  belongs_to :role
  belongs_to :manager, class_name: 'Person', foreign_key: :manager_id
  has_many :employees, class_name: 'Person', foreign_key: :manager_id

  class << self
    def in_region(region)
      locations.merge(Location.in_region(region))
    end

    def alphabetically_by_region_and_location
      locations.merge(Location.alphabetically_by_region).order(:name)
    end

    def with_employees
      where(manager_id: nil)
    end

    def with_employees_order_by_location_name
      with_employees.joins(:location).merge(Location.order_by_name)
    end

    def locations
      @locations ||= joins(:location).preload(:location)
    end
  end

  private_class_method :locations
end
