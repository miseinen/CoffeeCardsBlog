class Article < ApplicationRecord
    validates :title, presence: true, length: 1..50
    validates :description, presence: true, length: 5..1500
end