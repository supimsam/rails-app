class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :active_relationships, class_name: "Relationship",
	                          foreign_key: :follower_id, 
	                          dependent: :destroy
  has_many :passive_relationships, class_name: "Relationship",
	                           foreign_key: :followed_id, 
	                           dependent: :destroy
  has_many :following, through: :active_relationships,  source: :followed # User.first.following
  has_many :followers, through: :passive_relationships, source: :follower # User.first.followers
	validates :password, confirmation: true
	validates_uniqueness_of :email, :username, case_sensitive: false
	validates_presence_of :username, :email, :lname, :fname
	validates :password, presence: true, on: :create
	validates :password_confirmation, presence: true, on: :create
	validates :username, format: { with: /\A\w+\z/,
    message: "only allows letters numbers and underscores." }
  # has_attached_file :image, :styles => { :medium => "300x300>", :thumb => "100x100>", :mini => "25x25" }, :default_url => "insert image " 
  # validates_attachment_content_type :image, :content_type => /\Aimage\/.*\Z/
	def self.find_by_email(email)
  	User.where("lower(email) = ?", email.downcase).first
	end

	def self.find_by_username(username)
  	User.where("lower(username) = ?", username.downcase).first
	end

end
