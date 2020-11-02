module DocxCrConverter
  class Parser
    getter :xml, :docx_path, :errors, :document

    def initialize(@docx_path : String, @format = "markdown")
      @xml = DocxCrConverter::ExtractFiles.new(@docx_path)
      @errors = [] of String
      @document = ""
      @format
      @changed = false
    end

    def errors?
      @errors.size > 0
    end

    def parse
      return @errors << "Invalid XML::Node parser" unless @xml.xml_document.is_a?(XML::Node)

      @xml.xml_document.as(XML::Node).xpath_nodes("w:document/w:body/w:p/w:pPr").each do |node|
        if @format === "markdown"
          heading "Title", "# #{word} \n\n"
          heading "Subtitle", "## #{word} \n\n"
          heading "Heading1", "# #{word} \n\n"
          heading "Heading2", "## #{word} \n\n"
          heading "Heading3", "### #{word} \n\n"
          heading "Heading4", "#### #{word} \n\n"
          heading "Heading5", "##### #{word} \n\n"
          heading "Heading6", "###### #{word} \n\n"
          heading "Quote", "> \n\n"
          #heading "Normal.0", "\n\n"
        end

        text_node = node.as(XML::Node).xpath_nodes("w:pStyle/@w:val").to_a
        text_node.each do |single_word|
          if single_word.to_s.includes?("TextBody")
            get_text = single_word.parent.as(XML::Node).parent.as(XML::Node).parent

            if @format === "markdown"
              text_style "bCs", "**#{word}** "
              text_style "iCs", "*#{word}* "
              text_style "u", "<ins>#{word}</ins> "
              text_style "strike", "<del>#{word}</del> "
              text_style "numPr", "+ #{word} \n\n"
            end

            if @changed === false
              word = get_text.as(XML::Node).xpath_nodes("w:r/w:t")
              @document += " #{word} ".sub("<w:t>", "").sub("</w:t>", "")
            end
          end
        end
      end
    end
  end
end
