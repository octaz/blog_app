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



	#this only gets posts with tags
	# def self.not_tagged_with(title)
	# 	allPosts = Post.all.to_a
	# 	thePosts  = []
	# 	allTags = Tag.where("title != ? OR title = ?", title, nil)
	# 	allTags.each do |tag|
	# 		tag.posts.each do |post|
	# 			if !thePosts.include?(post)
	# 				thePosts.push(post)
	# 			end
	# 		end
	# 	end
	# 	return thePosts
	# end
	def self.not_tagged_with(title)
		allPosts = Post.all.to_a
		tagged_with = Tag.find_by_title(title)
		if (tagged_with.!=nil)
			tagged_with = tagged_with.posts.to_a
			tagged_with.each do |post|
				allPosts.delete(post)
			end
		end
		return allPosts
	end

	#this doesn't seem to be working
	def self.not_tagged_with_by_all(title)
		thePosts = []
		thePosts = Post.all.to_a
		logger.debug "testMonkey blogQuote " 
		#theTitle = Tag.where("title == ?", title)
		thePosts.each do |post|
			if post.has_tag?(title)
				logger.debug "testMonkey blogQuote inside" 
				thePosts.delete(post)
			end
		end
		return thePosts
	end



	##this is what we're using to not render blogQuotes
	def self.not_tagged_with_find_by_title(title)
		allPosts = Post.all.to_a
		blogQuotePosts = Tag.find_by_title!(title).posts.to_a

		blogQuotePosts.each do |post|
			allPosts.delete(post)
		end
		return allPosts

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

	def self.tag_exists?(title)
		aTag = Tag.find_by title: title
		return aTag!=nil
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
