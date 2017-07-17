class Wiki < ApplicationRecord
  belongs_to :user
  has_many :collaborators, dependent: :delete_all
  has_many :collaborate_users, through: :collaborators, source: :user
  
  validates :title, length: { minimum: 2 }
  validates :body, length: { minimum: 5 }
end
