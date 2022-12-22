# frozen_string_literal: true

class Genre < ApplicationRecord
  validates :name, uniqueness: true
end
