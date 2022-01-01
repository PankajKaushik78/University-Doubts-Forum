class Doubt < ApplicationRecord
    
    belongs_to :category
    belongs_to :user
    has_many :comments, dependent: :destroy
    has_one :answer, dependent: :destroy

    validates :title, :description, presence: true
    resourcify
end
