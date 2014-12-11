class Status < ActiveRecord::Base
	belongs_to :user

	def full_name
  @user.full_name
end


end
