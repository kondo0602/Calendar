class Color < ApplicationRecord
  validates :color_name, presence: true
end
