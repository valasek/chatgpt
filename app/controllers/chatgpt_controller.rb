class ChatgptController < ApplicationController
  def index
  end
  
  def message
    openai = OpenAI::Client.new(access_token: Rails.application.credentials.openai.api_key)
    @response = ""
    begin
      openaiResponse = openai.chat(
        parameters: {
            model: "gpt-3.5-turbo", # Required.
            messages: [{ role: "user", content: params['question']}], # Required.
            temperature: 0.7,
        })
        logger.warn(openaiResponse)
        if openaiResponse.key?('error')
          flash[:notice] = openaiResponse['error']['message']
        else
          logger.warn("budeme mit odpoved")
          @response = openaiResponse.dig("choices", 0, "message", "content")
          logger.warn("mame odpoved #{response}")
          logger.warn("koniec #{response}")
        end
    rescue => error
      logger.warn("exception")
      logger.warn(error.message)
      response = "Error"
    end
    render :index
  end
end
