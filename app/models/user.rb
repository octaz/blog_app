class User < ActiveRecord::Base
	has_many :microposts
	validates :name, presence: true, length: {maximum: 50}, uniqueness: true
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
	before_save {self.email = email.downcase}
	has_secure_password
	validates :password, length: {minimum: 6}
	before_create :create_remember_token
	has_many :posts, dependent: :destroy
	

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.digest(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private

		def create_remember_token
			self.remember_token = User.digest(User.new_remember_token)
		end


end
