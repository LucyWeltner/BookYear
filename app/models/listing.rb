class Listing < ApplicationRecord
	belongs_to :book
	belongs_to :list
end
