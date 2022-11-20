class User < ApplicationRecord
  include JwtToken
  authenticates_with_sorcery!

  has_many :videos, dependent: :destroy
  has_many :outputs, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmark_videos, through: :bookmarks, source: :video
  has_many :likes, dependent: :destroy
  has_many :like_outputs, through: :likes, source: :output

  validates :password, length: { minimum: 6 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true, presence: true
  validates :name, presence: true
  validates :reset_password_token, presence: true, uniqueness: true, allow_nil: true

  def bookmark(video)
    bookmark_videos << video
  end

  def unbookmark(video)
    bookmark_videos.destroy(video)
  end

  def like(output)
    like_outputs << output
  end

  def unlike(output)
    like_outputs.destroy(output)
  end

  # ゲストユーザーが存在しない場合、ゲストユーザーを作成
  def self.guest
    password = SecureRandom.urlsafe_base64
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = password
      user.password_confirmation = password
      user.name = 'ゲストユーザー'
    end
  end
end
