class Devise::OmniauthCallbacksController < ApplicationController
	
	skip_before_filter :authenticate_user!

	def twitter
		auth = env['omniauth.auth']
		uid = auth['uid']
		provider = auth['provider']

		user = User.where(uid: uid, provider: provider).first_or_create do |u|
			u.email= "#{uid}@twitter.com"
		end
		
		sign_in_and_redirect_user user

	#	u = User.where(uid: uid, provider: provider).first
	#	if u.nil
	#		u = User.new
	#		u.uid = uid
	#		u.provider = provider
	#		u.save
	#	end
	end
end
