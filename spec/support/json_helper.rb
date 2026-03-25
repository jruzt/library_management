module JsonHelper
  def json_response
    JSON.parse(response.body)
  end

  def jsonapi_data
    json_response.fetch("data")
  end

  def jsonapi_attributes
    jsonapi_data.fetch("attributes")
  end

  def jsonapi_relationship(name)
    jsonapi_data.fetch("relationships").fetch(name.to_s).fetch("data")
  end

  def jsonapi_included(type:, id:)
    json_response.fetch("included").find do |resource|
      resource["type"] == type.to_s && resource["id"] == id.to_s
    end
  end
end

RSpec.configure do |config|
  config.include JsonHelper, type: :request
end
