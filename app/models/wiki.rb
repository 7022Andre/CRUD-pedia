class Wiki < ApplicationRecord
  belongs_to :user
  validates :title, length: { minimum: 2 }
  validates :body, length: { minimum: 5 }
end
