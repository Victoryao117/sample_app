class User < ActiveRecord::Base
	#设置email最大长度为50
	before_save	{ self.email = email.downcase }
	validates(:name, presence: true,length: { maximum: 50 })
	#VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	#不允许出现..com样式的邮件地址
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z]+)*\.[a-z]+\z/i
	validates(:email, presence: true,format: {with: VALID_EMAIL_REGEX} ,uniqueness: {case_sensitive: false})
	#此处为用户添加密码验证，设置密码最少为6位
	has_secure_password
	validates :password, length: { minimum: 6 }
	
	#创建用户时，直接赋予记忆权标
	before_create :create_remember_token
	#使用urlsafe_base64方法来标记记忆权标（16位长度，每位有64种可能）
	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end
	#使用SHA1来加密记忆权标，安全性不如Bcrypt，但性能高，安全也基本满足现有需求。
	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

	private
	def create_remember_token
		self.remember_token = User.encrypt(User.new_remember_token)
	end
	
end
