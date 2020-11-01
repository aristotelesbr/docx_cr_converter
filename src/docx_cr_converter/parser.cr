module DocxCrConverter
  class Parser
    getter :xml, :docx_path, :errors, :document

    def initialize(@docx_path : String)
      @xml = DocxCrConverter::ExtractFiles.new(@docx_path)
      @errors = [] of String
      @document = ""
    end

    def errors?
      @errors.size > 0
    end

    def parse
      return @errors << "Invalid XML::Node parser" unless @xml.xml_document.is_a?(XML::Node)

      @xml.xml_document.as(XML::Node).xpath_nodes("w:document/w:body/w:p/w:pPr").each do |x|
        if x.as(XML::Node).xpath_nodes("w:pStyle/@w:val").to_s.includes?("Title")
          a = x.parent
          b = a.as(XML::Node).xpath_nodes("w:r/w:t")
          c = b.to_s[5..-1].sub("</w:t>", "")
          @document += " # #{c} <br />"
        end

        if x.as(XML::Node).xpath_nodes("w:pStyle/@w:val").to_s.includes?("Subtitle")
          a = x.parent
          b = a.as(XML::Node).xpath_nodes("w:r/w:t")
          c = b.to_s[5..-1].sub("</w:t>", "")
          @document += " ## #{c} <br />"
        end

        if x.as(XML::Node).xpath_nodes("w:pStyle/@w:val").to_s.includes?("Heading1")
          a = x.parent
          b = a.as(XML::Node).xpath_nodes("w:r/w:t")
          c = b.to_s[5..-1].sub("</w:t>", "")
          @document += " # #{c} <br />"
        end

        if x.as(XML::Node).xpath_nodes("w:pStyle/@w:val").to_s.includes?("Heading2")
          a = x.parent
          b = a.as(XML::Node).xpath_nodes("w:r/w:t")
          c = b.to_s[5..-1].sub("</w:t>", "")
          @document += " ## #{c} <br />"
        end

        if x.as(XML::Node).xpath_nodes("w:pStyle/@w:val").to_s.includes?("Heading3")
          a = x.parent
          b = a.as(XML::Node).xpath_nodes("w:r/w:t")
          c = b.to_s[5..-1].sub("</w:t>", "")
          @document += " ### #{c} <br />"
        end

        if x.as(XML::Node).xpath_nodes("w:pStyle/@w:val").to_s.includes?("Heading4")
          a = x.parent
          b = a.as(XML::Node).xpath_nodes("w:r/w:t")
          c = b.to_s[5..-1].sub("</w:t>", "")
          @document += " #### #{c} <br />"
        end

        if x.as(XML::Node).xpath_nodes("w:pStyle/@w:val").to_s.includes?("Heading5")
          a = x.parent
          b = a.as(XML::Node).xpath_nodes("w:r/w:t")
          c = b.to_s[5..-1].sub("</w:t>", "")
          @document += " ##### #{c} <br />"
        end

        if x.as(XML::Node).xpath_nodes("w:pStyle/@w:val").to_s.includes?("Heading6")
          a = x.parent
          b = a.as(XML::Node).xpath_nodes("w:r/w:t")
          c = b.to_s[5..-1].sub("</w:t>", "")
          @document += " ###### #{c} <br />"
        end

        n = x.as(XML::Node).xpath_nodes("w:pStyle/@w:val").to_a
        n.each do |g|
          if g.to_s.includes?("TextBody")
            n = g.parent
            b = n.as(XML::Node).parent
            c = b.as(XML::Node).parent

            if c.as(XML::Node).xpath_nodes("w:r/w:rPr/w:bCs")
              unless c.as(XML::Node).xpath_nodes("w:r/w:rPr/w:bCs").to_s.includes?("false")
                if c.to_s.includes?("bCs")
                  d = c.as(XML::Node).xpath_nodes("w:r/w:t").to_s.sub("</w:t>", "").sub("<w:t>", "")
                  unless d.empty?
                    @document += " **#{d}** <br />"
                  end
                end
              end
            end

            if c.as(XML::Node).xpath_nodes("w:r/w:rPr/w:u")
              unless c.as(XML::Node).xpath_nodes("w:r/w:rPr/w:u").to_s.includes?("none")
                if c.to_s.includes?("w:u")
                  d = c.as(XML::Node).xpath_nodes("w:r/w:t").to_s.sub("</w:t>", "").sub("<w:t>", "")
                  unless d.empty?
                    @document += " <ins>#{d}</ins> <br />"
                  end
                end
              end
            end

            if c.as(XML::Node).xpath_nodes("w:r/w:rPr/w:strike")
              unless c.as(XML::Node).xpath_nodes("w:r/w:rPr/w:strike").to_s.includes?("false") ||
                     c.as(XML::Node).xpath_nodes("w:r/w:rPr/w:dstrike").to_s.includes?("false")
                if c.to_s.includes?("w:strike")
                  d = c.as(XML::Node).xpath_nodes("w:r/w:t").to_s.sub("</w:t>", "").sub("<w:t>", "")
                  unless d.empty?
                    @document += " <del>#{d}</del> <br />"
                  end
                end
              end
            end

            if c.as(XML::Node).xpath_nodes("w:p/w:pPr/w:numPr")
                if c.to_s.includes?("numId")
                  d = c.as(XML::Node).xpath_nodes("w:r/w:t").to_s.sub("</w:t>", "").sub("<w:t>", "")
                  unless d.empty?
                    @document += " + #{d}"
                  end
                end
              end

            if c.as(XML::Node).xpath_nodes("w:r/w:rPr/w:iCs")
              unless c.as(XML::Node).xpath_nodes("w:r/w:rPr/w:iCs").to_s.includes?("false")
                if c.to_s.includes?("iCs")
                  d = c.as(XML::Node).xpath_nodes("w:r/w:t").to_s.sub("</w:t>", "").sub("<w:t>", "")
                  unless d.empty?
                    @document += " *#{d}* <br />"
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
