class Answer < ApplicationRecord
    belongs_to :user
    belongs_to :doubt

    validates :content, presence: true
end
