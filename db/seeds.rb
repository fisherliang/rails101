puts "已建立一個帳號，並建10個Groups, 每個group有20篇posts"
create_account = User.create([email: 'fisher@gmail.com', password: '00000000', password_confirmation: '00000000', name: 'Fisher'])

create_groups = for i in 1..10 do 
					Group.create!([title: "Group #{i}", description: "這是用種子建的第#{i}個版", user_id: "1"])
					for j in 1..20 do
						Post.create!([group_id: "#{i}", content: "這用種子建的第#{j}篇文章", user_id: "1"])
					end
				end
