class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def render_resource(resource)
    if resource.errors.empty?
      render json: resource
    else
      validation_error(resource)
    end
  end

  def validation_error(resource)
    render json: {
        errors: [
            status: 400,
            title: 'Bad request',
            detail: resource.errors,
            code: 100
        ]
    }, status: :bad_request
  end

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
