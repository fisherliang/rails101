class GroupsController < ApplicationController
	before_action :authenticate_user! , only: [:new, :edit, :create, :update, :destroy]

	def index
		#flash[:notice] = "早安，您好！"
		#flash[:alert] = "晚安，該睡了！"
		#flash[:warning] = "This is Warning"
		@groups = Group.all
	end

	def show
		@group = Group.find(params[:id])
		@posts = @group.posts
	end

	def new
		@group = Group.new
	end

	def edit
		@group = current_user.groups.find(params[:id])
	end

	def create
		@group = current_user.groups.new(group_params)
		#@group = Group.create(group_params)

		if @group.save
			current_user.join!(@group)
			redirect_to groups_path
		else
			render :new
		end
	end

	def update
		@group = current_user.groups.find(params[:id])

		if @group.update(group_params)
			redirect_to groups_path, notice: "修改討論版成功"
		else
			render :edit
		end
	end

	def destroy
		@group = current_user.groups.find(params[:id])
		@group.destroy
		redirect_to groups_path, alert: "討論版已刪除"
	end

	def join
		@group = Group.find(params[:id])

		if !current_user.is_member_of?(@group)
			current_user.join!(@group)
			flash[:notice] = "成功加入討論版"
		else
			flash[:warning] = "你已是本版會員"
		end

		redirect_to group_path(@group)
	end

	def quit
		@group = Group.find(params[:id])

		if current_user.is_member_of?(@group)
			current_user.quit!(@group)
			flash[:alert] = "已退出討論版"
		else
			flash[:warning] = "你不是這個討論版的成員啊傻B"
		end

		redirect_to group_path(@group)
	end

	private

	def group_params
		params.require(:group).permit(:title, :description)
	end
end
