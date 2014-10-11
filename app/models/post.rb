class Post < ActiveRecord::Base
	validates :title, presence: true
	validates :content, presence: true
	validates :user_id, presence: true
	belongs_to :user
	has_many :taggings, dependent: :destroy
	has_many :tags, through: :taggings

	default_scope -> {order('created_at DESC')}

	def self.tagged_with(title)
		Tag.find_by_title!(title).posts
	end

	def self.tag_counts
		#wrking code
		# Tag.select("tags.id, tags.title,count(taggings.tag_id) as count").
  #   		joins(:taggings).group("taggings.tag_id, tags.id, tags.title")
    	Tag.select("tags.id, tags.title,count(taggings.tag_id) as count").
    		joins(:taggings).group("taggings.tag_id, tags.id, tags.title")
	end

	def tag_list
		tags.map(&:title).join(", ")
	end

	def tags_as_tag
		tags
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

	def current_tags(selectedTag)
	

		@taggings = Tagging.where("tag_id = ?", selectedTag.tag_id)
		# @currentTags = Tag.find(Post.find(taggings_tag)
  #   	Tag.find_by_sql("select * from tags where ")
	
	end
end
