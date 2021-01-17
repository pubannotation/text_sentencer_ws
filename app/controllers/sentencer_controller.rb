class SentencerController < ApplicationController
	skip_before_action :verify_authenticity_token

	def annotation
		begin
			text = if params[:text].present?
				params[:text]
			else
				request.body.read.dup.force_encoding('UTF-8')
			end

			config_name = if params[:config].present?
				params[:config]
			else
				'PubMed'
			end

			c = Config.friendly.find(config_name)
			config = JSON.parse c.body, symbolize_names: true

			@result = if text.present?
				annotator = TextSentencer.new(config)
				annotator.annotate(text)
			else
				{}
			end

			respond_to do |format|
				format.html {
					@configs = Config.all.pluck(:name)
				}
				format.json {
					raise ArgumentError, "no text was supplied." unless text.present?
					render json:@result
				}
			end
		rescue ArgumentError => e
			respond_to do |format|
				format.html
				format.any {render json: {message:e.message}, status: :bad_request}
			end
		rescue => e
			respond_to do |format|
				format.html
				format.any {render json: {message:e.message}, status: :internal_server_error}
			end
		end
	end
end
