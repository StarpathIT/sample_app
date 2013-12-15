class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	# callback method that creates a remember_token before creating a new user in DB
	# "Method reference" - rails looks for method called create_remember_token
	before_create :create_remember_token
	
	validates(:name, presence: true, length: { maximum: 50 })
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	# VALID_EMAIL_REGEX is a constant
	# format validation
	validates(:email, presence: true, format: { with: VALID_EMAIL_REGEX }, 
		uniqueness: true, uniqueness: { case_sensitive: false })
	# Sometimes when user clicks submit in quick succession, duplication can still occur.
	# to avoid this, create a database index on email column.
	has_secure_password # gets all current password tests to pass
	validates :password, length: { minimum: 6 }

	def User.new_remember_token
    SecureRandom.urlsafe_base64
  	end

  	def User.encrypt(token)
    Digest::SHA1.hexdigest(token.to_s)
  	end

  	# self allows creation of non-local variable, written to DB.
  	private
  	
  	def create_remember_token
	self.remember_token = User.encrypt(User.new_remember_token)
	end
	
end