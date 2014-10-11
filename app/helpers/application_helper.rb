module ApplicationHelper

	def full_title(page_title)
		base_title = "Thomas DeFina Blog App"
		if page_title.empty?
			base_title
		else
			"#{base_title} | #{page_title}"
		end
	end

	def tag_cloud(theTags, classes)
		if theTags.is_a?(Hash)
			max = theTags.sort_by{|k, v| v}.to_a.last[1]
			theTags.keys.each do |key|
				index = theTags[key].to_f / max * (classes.size - 1)
				yield(key, classes[index.round])
			end
		else

			max = theTags.sort_by(&:count).last
			theTags.each do |tag|
				index = tag.count.to_f / max.count * (classes.size - 1)
				yield(tag, classes[index.round])
			end
		end
	end


	# def tag_cloud(tags, classes)
	# 	if tags.is_a?(Hash)
	# 		max = tags.sort_by{|k, v| v}.last 
	# 		tags.keys.each do |tag|
	# 			index = tags[tag].to_f / tags[max].to_f * (classes.size - 1)
	# 			yield(tag, classes[index.round])
	# 		end
	# 	else

	# 		max = tags.sort_by(&:count).last
	# 		tags.each do |tag|
	# 			index = tag.count.to_f / max.count * (classes.size - 1)
	# 			yield(tag, classes[index.round])
	# 		end
	# 	end
	# end



	def related_tags(pPosts)
		arrayTags = []
		
		pPosts.each do |post|
			post.tags.each do |tag|
				if (!arrayTags.include?(tag))
					arrayTags.push(tag)
				end
			end
		end

		return arrayTags

 	end

 	def related_tags_hash(pPosts)
		hashTags = {}
		
		pPosts.each do |post|
			post.tags.each do |tag|
				if (!hashTags.has_key?(tag))
					print "intialize: "
					print tag.title
					print "\n"

					hashTags[tag] = 1
				else
					print "add to "
					print tag.title
					hashTags[tag] = hashTags[tag]+1
					printf "the number: %d spaghetti \n", hashTags[tag]
					
				end
			end
		end

		return hashTags

 	end


	
end
