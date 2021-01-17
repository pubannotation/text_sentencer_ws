class AddUserRefToConfigs < ActiveRecord::Migration[6.1]
	def change
		add_reference :configs, :user, index: true, foreign_key: true
	end
end
