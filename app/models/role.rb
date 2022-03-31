# frozen_string_literal: true

class Role < ActiveRecord::Base
  has_many :people
end
