module ResponseHelper
  def handle_response(response, success_message, error_message)
    response_code = response.code.to_i

    response_code == 200 ? flash_success(success_message) : flash_error(error_message)
  end

  def flash_success(message)
    flash[:message] = message
  end

  def flash_error(err)
    flash[:error] = err
  end
end
