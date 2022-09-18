class Output < ApplicationRecord
  belongs_to :user
  belongs_to :video
  has_many :comments, dependent: :destroy
  validates :summary, :impression, presence: true
end
