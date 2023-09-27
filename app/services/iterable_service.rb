class IterableService
  BASE_URL = "https://api.iterable.com".freeze

  def initialize(user, event = nil)
    @user = user
    @event = event
  end

  # TODO: flash messages on success and error (waiting for the API key)

  def create_user
    # update user API itself is used to create user
    uri = build_uri("/api/users/update")

    perform_request(uri, user_params)
  end

  def create_event
    # track event API itself is used to create event
    uri = build_uri("events/track")

    perform_request(uri, event_params)
  end

  def send_email
    uri = build_uri("/api/email/target")

    perform_request(uri, email_params)
  end

  private

  def user_params
    { email: @user.email }
  end

  def event_params
    { email: @user.email, eventName: @event }
  end

  def email_params
    { email: @user.email, eventName: @event }
  end

  def flash_message(res_code, success, error)
    res_code == 200 ? flash[:message] = success : flash[:error] = error
  end

  def build_uri(endpoint)
    URI("#{BASE_URL}#{endpoint}")
  end

  def build_request(uri, params)
    req = Net::HTTP::Post.new(uri)
    req["Content-Type"] = "application/json"
    req["Api-Key"] = ENV["ITERABLE_API_KEY"]

    req.body = params.to_json

    req
  end

  def perform_request(uri, params)
    request = build_request(uri, params)
    response(request, uri)
  end

  def response(request, uri)
    Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end
  end
end
