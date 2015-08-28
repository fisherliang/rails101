class GroupsController < ApplicationController
	def index
		flash[:notice] = "早安，您好！"
		flash[:alert] = "晚安，該睡了！"
		flash[:warning] = "This is Warning"
	end
end
