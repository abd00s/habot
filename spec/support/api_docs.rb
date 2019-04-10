require_relative "api_docs/generator.rb"

module ApiDocs
  def write_docs(request:, response:, options: {})
    ApiDocs::Generator.write!(
      request:  request,
      response: response,
      options:  options
    )
  end
end
