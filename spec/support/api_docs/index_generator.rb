module ApiDocs
  class IndexGenerator
    def self.run
      new.tap(&:run)
    end

    def run
      update_index_file
      update_readme
    end

    def update_index_file
      File.open(index_file, "w") do |f|
        f << "# API Docs\n\n"
        f.write(docs_index)
      end
    end

    def update_readme
      File.open(readme_file, "w") do |f|
        f << static_readme_text
        f.write(readme_index)
      end
    end

    def static_readme_text
      <<~DOC
        # Habot\n
        Habot is a habit tracking, enforcement and reminder tool.\n
        ## API Docs\n\n
      DOC
    end

    def docs_index
      files.map { |file| line_item(file).gsub("docs/", "") }.join("\n")
    end

    def readme_index
      files.map { |file| line_item(file) }.join("\n")
    end

    def chomp_local_path(path)
      path.gsub("#{docs_dir}/", "")
    end

    def line_item(file)
      "* [#{endpoint(file)}](#{path_to_doc(file)})"
    end

    def endpoint(file)
      chomp_local_path(file).chomp(".md")
    end

    def path_to_doc(file)
      "docs/#{chomp_local_path(file)}"
    end

    def files
      Dir["#{docs_dir}/**/*.md"].sort.reject { |f| f == index_file.to_s }
    end

    def docs_dir
      @docs_dir ||= Rails.root.join("docs")
    end

    def readme_file
      Rails.root.join("README.md")
    end

    def index_file
      @index_file ||= docs_dir.join("index.md")
    end
  end
end
