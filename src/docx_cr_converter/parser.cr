module DocxCrConverter
  class Parser
    getter :xml, :docx_path, :errors, :document

    # @param docx_path [String] path to docx file
    # @return [DocxCrConverter::Parser]
    # @example
    #   parser = DocxCrConverter::Parser.new("path/to/docx/file")
    #   parser.parse
    def initialize(@docx_path : String)
      @xml = DocxCrConverter::ExtractFiles.new(@docx_path)
      @errors = [] of String
      @document = ""
    end

    # @return [Bool] true if errors are present
    # @example
    #   parser = DocxCrConverter::Parser.new("path/to/docx/file")
    #   parser.parse
    def errors?
      @errors.size > 0
    end

    # @return [String] parsed document
    # @example
    #   parser = DocxCrConverter::Parser.new("path/to/docx/file")
    #   parser.parse
    def parse
      return @errors << "Invalid XML::Node parser" unless @xml.xml_document.is_a?(XML::Node)
      @xml.xml_document.as(XML::Node).xpath_nodes("//*[name()='w:p']").map do |child|
        case child.name
        when "p"
          @document += "\n\n"
          child.children.map do |r|
            case r.name
            when "pPr"
              # Get Styles
              r.children.map do |s|
                case s.name
                when "pStyle"
                  case s["val"]
                  when "Title"
                    @document += "# \n"
                  when "Heading1"
                    @document += "# "
                  when "Heading2"
                    @document += "## "
                  when "Quote"
                    @document += "> "
                  when "Normal.0"
                    @document += "\n\n"
                  end
                when "numPr"
                  @document += "+ "
                when "rPr"
                  # Get Bold style
                end
              end
            else
              # Get text
              r.children.map do |x|
                case x.name
                when "t"
                  @document += x.text
                end
              end
            end
          end
        end
      end
    end
  end
end
