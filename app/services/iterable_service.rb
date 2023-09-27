class IterableService
  BASE_URL = "https://api.iterable.com".freeze

  def initialize(user, event = nil)
    @user = user
    @event = event
  end

  # TODO: flash messages on success and error (waiting for the API key)

  def create_user
    # update user API itself is used to create user
    uri = URI("#{base_url}/api/users/update")

    req = request(uri, user_params)
    res = response(req, uri)

    response_code = res.code.to_i

    flash_message(response_code,
                  "Iterable user for #{@user.email} created successfully.",
                  "Unable to create user.")

    # TODO: view the response object and display if possible
  end

  def create_event
    # track event API itself is used to create event
    uri = URI("#{base_url}events/track")

    req = request(uri, event_params)
    res = response(req, uri)

    response_code = res.code.to_i

    flash_message(response_code,
                  "Iterable Event for #{@user.email} created successfully.",
                  "Unable to create event.")

    # TODO: view the response object and display if possible
  end

  def send_email
    uri = URI("#{base_url}/api/email/target")

    req = request(uri, email_params)
    res = response(req, uri)

    response_code = res.code.to_i

    flash_message(response_code,
                  "Email sent to user with email #{@user.email} successfully.",
                  "Unable to send email.")

    # TODO: view the response object and display if possible
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

  def request(uri, params)
    req = Net::HTTP::Post.new(uri)
    req["Content-Type"] = "application/json"
    req["Api-Key"] = ENV["ITERABLE_API_KEY"]

    req.body = params.to_json

    req
  end

  def response(request, uri)
    Net::HTTP.start(uri.hostname, uri.port, use_ssl: true) do |http|
      http.request(request)
    end
  end
end
