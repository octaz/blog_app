class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true
	validates :user_id, presence: true
	belongs_to :user
	default_scope -> {order('created_at DESC')}
end
