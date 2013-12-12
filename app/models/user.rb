class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
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
	
end