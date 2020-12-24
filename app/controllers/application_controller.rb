class ApplicationController < ActionController::API
  include ActionController::MimeResponds

  respond_to :json

  rescue_from ActiveRecord::RecordNotFound, with: :not_found

  def render_jsonapi_response(resource)
    if resource.respond_to?(:errors)
      render jsonapi: resource if resource.errors.empty?

      render jsonapi_errors: resource.errors, status: 400
    else
      render jsonapi: resource
    end
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
