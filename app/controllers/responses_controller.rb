class ResponsesController < ApplicationController
  before_action :find_response, only: :create

  def create
    if @response.nil?
      Response.create!(response_params.merge(survey_id: params[:survey_id]))
    else
      @response.update(response_params)
    end
    render plain: 'OK'
  end

  private

  def response_params
    params.require(:response).permit(:question_number, :answer)
  end

  def find_response
    if response_params.key?(:question_number)
      @response = Response.find_by(
	survey_id: params[:survey_id],
	question_number: response_params[:question_number])
    else
      @response = nil
    end
  end
end
