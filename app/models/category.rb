class Category < ApplicationRecord
    has_many :doubts
    has_many :users, through: :doubts

    resourcify
end
