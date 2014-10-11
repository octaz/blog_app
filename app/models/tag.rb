class Tag < ActiveRecord::Base
	has_many :taggings
	has_many :posts, through: :taggings




	def self.related_posts
		Post.joins(:tag)	
	end

	# def self.tag_counts
	# 	#wrking code
	# 	# Tag.select("tags.id, tags.title,count(taggings.tag_id) as count").
 #  #   		joins(:taggings).group("taggings.tag_id, tags.id, tags.title")
 #    	Tag.select("tags.id, tags.title,count(taggings.tag_id) as count").
 #    		joins(:taggings).group("taggings.tag_id, tags.id, tags.title")
	# end

	# def tag_list=(titles)
	# 	self.tags = titles.split(", ").map do |n|
	# 		Tag.where(title: n.strip).first_or_create!
	# 	end
	# end

	# def self.tag_counts(pTags)
	# 	Tag.where(Tagging.where)
 #    end

 

end
