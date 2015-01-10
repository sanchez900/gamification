class User < ActiveRecord::Base

	has_many :statuses
	has_many :user_friendships
	has_many :friends,->{ where(user_friendships: { state: 'accepted' }) },
					 through: :user_friendships
						#scope: -> where(user_friendships: { state: 'accepted' })
						#conditions: { user_friendships: { state: 'accepted' }}
  
	has_many :pending_user_friendships,->{where({state: 'pending'})}, class_name: 'UserFriendship',
										foreign_key: :user_id#,
										#{ where(user_id: { state: 'accepted'})}
										#conditions: { state: 'pending' }
	has_many :pending_friends, through: :pending_user_friendships, source: :friend

	has_many :requested_user_friendships,->{where({state: 'requested'})}, class_name: 'UserFriendship',
										foreign_key: :user_id#,
										#{ where(user_id: { state: 'accepted'})}
										#conditions: { state: 'pending' }
	has_many :requested_friends, through: :pending_user_friendships, source: :friend

	has_many :blocked_user_friendships,->{where({state: 'blocked'})}, class_name: 'UserFriendship',
										foreign_key: :user_id#,
										#{ where(user_id: { state: 'accepted'})}
										#conditions: { state: 'pending' }
	has_many :blocked_friends, through: :pending_user_friendships, source: :friend

	has_many :accepted_user_friendships,->{where({state: 'accepted'})}, class_name: 'UserFriendship',
										foreign_key: :user_id#,
										#{ where(user_id: { state: 'accepted'})}
										#conditions: { state: 'pending' }
	has_many :accepted_friends, through: :pending_user_friendships, source: :friend


  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

validates :first_name, presence: true
validates :last_name, presence: true
validates :profile_name, presence: true,
						 uniqueness: true,
						 format: { 
						 	with: /\A[a-zA-Z0-9_-]+\z/,
						 	message: 'Must be formatted correctly.'
						 }


def full_name
"#{first_name} #{last_name}"
end

def to_param
	profile_name
end


def gravatar_url
	stripped_email = email.strip
	downcase_email = stripped_email.downcase
	hash = Digest::MD5.hexdigest(downcase_email)

	"http://gravatar.com/avatar/#{hash}"
end

def has_blocked?(other_user)
	blocked_friends.include?(other_user)
end

end
