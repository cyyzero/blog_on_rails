class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :article
  default_scope -> { order(created_at: :asc)}
  validates :user_id, presence: true
  validates :article_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }
end
