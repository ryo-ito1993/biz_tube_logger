class SetYtService
  GOOGLE_API_KEY = ENV.fetch('GOOGLE_API_KEY', nil)

  def initialize
    Yt.configure do |config|
      config.api_key = GOOGLE_API_KEY
      config.log_level = :debug
    end
  end
end