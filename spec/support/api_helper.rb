module ApiHelper
  def json
    JSON.parse(response.body, symbolize_names: true)
  end
end
