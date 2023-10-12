class ChatgptController < ApplicationController
  def index
  end
  
  def message
    response = openai.Completion.create(
            model="text-davinci-003",
            prompt=generate_prompt(params[:query]),
            temperature=0.6,
        )
    render :index, :locals => {:message => params[:query]}
  end
end
