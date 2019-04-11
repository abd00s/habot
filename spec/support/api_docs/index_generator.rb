module ApiDocs
  class IndexGenerator
    def self.run
      new.tap(&:run)
    end

    def run
      File.open(index_file, "w") do |f|
        f << "# API Docs\n\n"
        f.write(index)
      end
    end

    def index
      files.map { |file| line_item(file) }.join("\n")
    end

    def chomp_local_path(path)
      path.gsub("#{docs_dir}/", "")
    end

    def line_item(file)
      "* [#{chomp_local_path(file)}](#{chomp_local_path(file)})"
    end

    def files
      Dir["#{docs_dir}/**/*.md"].sort.reject { |f| f == index_file.to_s }
    end

    def docs_dir
      @docs_dir ||= Rails.root.join("docs")
    end

    def index_file
      @index_file ||= docs_dir.join("index.md")
    end
  end
end
