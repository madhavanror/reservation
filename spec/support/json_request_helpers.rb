module JsonRequestHelpers
  def json_response
    JSON.parse(response.body)
  end

  def json_headers
    {"CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json"}
  end
end