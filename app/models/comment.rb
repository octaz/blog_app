class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :user
  validate :atleast_user_or_author
  validate :dynamic_length
  validates :post, presence: true
  validates :author, length: {maximum: 12}
 
  default_scope -> {order('created_at ASC')}

  def atleast_user_or_author
  	if (user==nil && (author == nil or author.blank?))
  		errors.add :base, 'You need to be either signed in or fill out an authors name!'
  	end
  end

  def dynamic_length
  	
  	if (user==nil)

  		if (content.length>200)
  			errors.add :base, 'You can only comment up to 200 characters as an unregistered user'
      elsif (content.length<3)
        errors.add :base, 'Your comment must be at least 3 characters'
      end

  	else

  		if (content.length>1000)
  			errors.add :base, 'You can only comment up to 1000 characters'
      elsif (content.length<3)
        errors.add :base, 'Your comment must be at least 3 characters'
      end
        

  	end

  end

  
end
