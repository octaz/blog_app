class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true
	validates :user_id, presence: true
	belongs_to :user
	has_many :taggings
	has_many :tags, through: :taggings

	default_scope -> {order('created_at DESC')}

	def self.tagged_with(title)
		Tag.find_by_title!(title).posts
	end

	def self.tag_counts
		Tag.select("tags.*, count(taggings.tag_id) as count").
			joins(:taggings).group("taggings.tag_id")
	end

	def tag_list
		tags.map(&:title).join(", ")
	end

	def has_tag?(title)
		self.tags.include? title
	end

	def tag!(title)
		if !has_tag?(title)
			self.tags.push(Tag.where(title: title))
		end
	end

	def tag_list=(titles)
		self.tags = titles.split(", ").map do |n|
			Tag.where(title: n.strip).first_or_create!
		end
	end

end
