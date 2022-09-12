class Output < ApplicationRecord
  belongs_to :user
  belongs_to :video
  validates :summary, :impression, presence: true
end
