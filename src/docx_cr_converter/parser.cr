module DocxCrConverter
  class Parser
    getter :xml, :docx_path, :errors

    def initialize(docx_path : String)
      @docx_path = docx_path
      @xml = DocxCrConverter::ExtractFiles.new(@docx_path)
      @errors = [] of String
    end

    def errors?
      @errors.size > 0
    end

    def parse
      return @errors << "Invalid XML::Node parser" unless @xml.xml_document.is_a?(XML::Node)

      output = ""
      @xml.xml_document.as(XML::Node).xpath_nodes("//*[name()='w:p']").map do |child|
        case child.name
        when "p"
          output += "\n\n"
          child.children.map do |r|
            case r.name
            when "pPr"
              # Get Styles
              r.children.map do |s|
                case s.name
                when "pStyle"
                  case s["val"]
                  when "Title"
                    output += "# \n"
                  when "Heading1"
                    output += "# "
                  when "Heading2"
                    output += "## "
                  when "Quote"
                    output += "> "
                  when "Normal.0"
                    output += "\n\n"
                  end
                when "numPr"
                  output += "+ "
                when "rPr"
                  # Get Bold style
                end
              end
            else
              # Get text
              r.children.map do |x|
                case x.name
                when "t"
                  return (output += x.text).as(String)
                end
              end
            end
          end
        end
      end
    end
  end
end
