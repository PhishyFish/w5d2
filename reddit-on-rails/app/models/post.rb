class Post < ApplicationRecord
  validates :title, presence: true

  has_many :post_subs, inverse_of: :post, dependent: :destroy

  has_many :subs,
    through: :post_subs,
    source: :sub

  belongs_to :author,
    class_name: :User,
    foreign_key: :author_id,
    inverse_of: :posts
end
