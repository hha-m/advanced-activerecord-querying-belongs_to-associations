# frozen_string_literal: true

class Region < ActiveRecord::Base
  has_many :locations

  scope :alphabetical_order, -> { order(:name) }
end
