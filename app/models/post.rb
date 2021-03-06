class Post < ApplicationRecord
  validates :title, presence: true, length: { maximum: 250 }
  validates :likes_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :comments_count, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  belongs_to :author, class_name: 'User',
                      foreign_key: 'author_id',
                      counter_cache: :posts_counter
  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy

  after_save :update_posts_count

  def most_recent_five_comments
    comments.includes(:user).order(created_at: :desc).limit(5)
  end

  private

  def update_posts_count
    author.update(posts_counter: author.posts.size)
  end
end
