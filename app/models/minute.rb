class Minute < ApplicationRecord
  validates :minutes_per_15, presence: true
end
