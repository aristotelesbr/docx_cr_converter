module DocxCrConverter
  class Parser
    getter :xml, :docx_path, :errors, :document

    def initialize(@docx_path : String)
      @xml = DocxCrConverter::ExtractFiles.new(@docx_path)
      @errors = [] of String
      @document = ""
      @bold = 0
      @italics = 0
      @strike = 0
      @insert = 0
    end

    def errors?
      @errors.size > 0
    end

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
                  when "Heading3"
                    @document += "### "
                  when "Heading4"
                    @document += "#### "
                  when "Heading5"
                    @document += "##### "
                  when "Quote"
                    @document += "> "
                  when "Normal.0"
                    @document += "\n\n"
                  when "TextBody"
                    if r.to_s.includes?("iCs")
                      # || r.to_s.includes?("i")
                      @italics = 1
                      if @italics == 1
                        @document += "*"
                        @italics == 0
                      end
                    end

                    if r.to_s.includes?("bCs")
                      # || r.to_s.includes?("b")
                      @bold = 1
                      if @bold == 1
                        @document += "**"
                        @bold == 0
                      end
                    end

                    if r.to_s.includes?("dstrike")
                      # || r.to_s.includes?("strike")
                      @strike = 1
                      if r.to_s.includes?("false")
                        @strike = 2
                      end
                      if @strike == 1
                        @document += "<del>"
                        @strike == 0
                      end
                    end
                  end
                when "numPr"
                  @document += "+ "

                  if r.to_s.includes?("iCs") &&
                     r.to_s.includes?("false")
                    @italics = 2
                  end

                  if r.to_s.includes?("bCs") &&
                     r.to_s.includes?("false")
                    @bold = 2
                  end
                when "u"
                  @insert == 1
                  @document += "<ins>"
                  @insert == 0
                end
              end
            else
              # Get text
              r.children.map do |x|
                case x.name
                when "t"
                  @document += x.text

                  if @bold == 1
                    @document += "**"
                  end
                  if @italics == 1
                    @document += "*"
                  end
                  if @strike == 1
                    @document += "</del>"
                  end
                  if @insert == 1
                    @document += "</ins>"
                  end
                end
              end
            end
          end
        end
      end
    end
  end
end
