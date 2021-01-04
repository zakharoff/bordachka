class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def not_found
    render json: {
        'errors': [
            {
                'status': '404',
                'title': 'Not Found'
            }
        ]
    }, status: 404
  end
end
