module JwtToken
  extend ActiveSupport::Concern

  class_methods do
    def decode(token)
      JWT.decode token, Rails.application.credentials.secret_key_base
    end
  end

  def create_tokens
    payload = { user_id: id }
    issue_token(payload.merge(exp: Time.current.to_i + 1.month))
  end

  private

  def issue_token(payload)
    JWT.encode payload, Rails.application.credentials.secret_key_base
  end
end
