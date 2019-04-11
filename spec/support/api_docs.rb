require_relative "api_docs/generator.rb"

module ApiDocs
  GEN_DOCS = ENV["DOCS"].to_s == "true"

  def write_docs(request:, response:, options: {})
    return unless GEN_DOCS

    ApiDocs::Generator.write!(
      request:  request,
      response: response,
      options:  options
    )
  end
end
