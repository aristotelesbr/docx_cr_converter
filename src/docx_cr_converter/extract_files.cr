module DocxCrConverter
  class ExtractFiles
    getter :xml_document, :docx_path, :errors

    # @param docx_path [String] path to docx filename
    # @return [XML::Document] XML document
    # @return [Array] errors
    # @example
    #   DocxCrConverter::ExtractFiles.new("path/to/file.docx")
    #   # => #<XML::Document:0x00007f8b9c0a1b00>
    #   # => []
    # @example
    #   DocxCrConverter::ExtractFiles.new("path/to/file.docx")
    #   # => nil
    #   # => ["No such file or directory @ rb_sysopen - path/to/file"]
    # @example
    #   DocxCrConverter::ExtractFiles.new("path/to/file.docx")
    #   # => nil
    #   # => ["File is not a zip file"]
    def initialize(@docx_path : String)
      @xml_document = XML.build(&.to_s)
      @errors = [] of String
      perform
    end

    # @return [Boolean] true if errors are present
    # @example
    #   DocxCrConverter::ExtractFiles.new("path/to/file.docx").errors?
    #   # => false
    # @example
    #   DocxCrConverter::ExtractFiles.new("path/to/file.docx").errors?
    #   # => true
    def errors?
      @errors.size > 0
    end

    # @return [XML::Document] XML document
    # @return [errors] errors
    private def perform
      Compress::Zip::File.open(@docx_path) do |file|
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
