module ApiDocs
  class Generator
    def self.write!(args = {})
      new(args).tap(&:write!)
    end

    def initialize(args = {})
      @request  = args[:request]
      @response = args[:response]
    end

    def write!
      make_docs_dir unless Dir.exist? docs_root
      write_doc
    end

    private

    def make_docs_dir
      FileUtils.mkdir_p(docs_root)
    end

    def write_doc
      File.open(doc_path, "w") do |f|
        f.puts doc_body
      end
    end

    def doc_body
      <<~BODY
        ### URL\n
        ```
        #{@request.path}
        ```\n
        ### Method\n
        ```
        #{@request.method}
        ```\n
        ### Parameters\n
        ```\n
        #{parameters}
        ```\n
        ### Success Response\n
        #### Status\n
        #{@response.status}\n
        #### Body\n
        ```
        #{response_body}
        ```
      BODY
    end

    def docs_root
      @docs_root ||= Rails.root.join("docs", controller)
    end

    def doc_path
      File.join("#{docs_root}/#{file_name}")
    end

    def file_name
      "#{action}.md"
    end

    def action
      @request.path_parameters[:action]
    end

    def controller
      @request.path_parameters[:controller]
    end

    def parameters
      params = @request.params.except(:controller, :action)
      return "NONE" if params.empty?

      JSON.pretty_generate(params)
    end

    def response_body
      return "NONE" if @response.body.empty?

      JSON.pretty_generate(JSON.parse(@response.body))
    end
  end
end
