module ApiDocs
  class Generator
    def self.write!(args = {})
      new(args).tap(&:write!)
    end

    def initialize(args = {})
      @request = args[:request]
      @response = args[:response]
    end

    def write!
      make_docs_dir unless Dir.exist? docs_root
    end

    def make_docs_dir
      FileUtils.mkdir_p(docs_root)
    end

    def docs_root
      @docs_root ||= Rails.root.join("docs", controller)
    end

    def controller
      @request.path_parameters[:controller]
    end
  end
end
