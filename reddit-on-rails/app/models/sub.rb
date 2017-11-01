class Sub < ApplicationRecord
  validates :title, presence: true, uniqueness: true

  has_many :post_subs, inverse_of: :sub, dependent: :destroy

  has_many :posts,
    through: :post_subs,
    source: :post

  belongs_to :moderator,
    class_name: :User,
    primary_key: :id,
    foreign_key: :moderator_id,
    inverse_of: :subs
end
