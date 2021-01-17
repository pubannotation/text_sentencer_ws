class Config < ApplicationRecord
	belongs_to :user

	include FriendlyId
	friendly_id :name

	validates :name, presence: true, uniqueness: true, length:{minimum:5, maximum:32}
	validates_format_of :name, :with => /\A[a-z0-9]+\z/i

	validates :body, presence: true
	validate :body_must_be_json

	private

	def body_must_be_json
		JSON.parse(body)
	rescue => e
		errors.add(:base, "Body is not a valid JSON object")
		errors.add(:base, e.message)
	end

end
