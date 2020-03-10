module DocxCrConverter
  class ExtractFiles
    getter :xml_document, :docx_path, :errors

    def initialize(@docx_path : String)
      @xml_document = XML.build(&.to_s)
      @errors = [] of String
      perform
    end

    def errors?
      @errors.size > 0
    end

    private def perform
      Zip::File.open(@docx_path) do |file|
        file.entries.each do |entry|
          entry.open do |io|
            @xml_document = XML.parse(io.gets_to_end) if entry.filename == "word/document.xml"
          end
        end
      end
    rescue err
      puts "#{err}"
      @errors << err.to_s
      err
    end
  end
end
