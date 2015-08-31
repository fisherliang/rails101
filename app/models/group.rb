class Group < ActiveRecord::Base
	validates :title, presence: { message: "此欄不可留空" }
end
