macro heading(header, document)
  {% begin %}
  if node.as(XML::Node).xpath_nodes("w:pStyle/@w:val").to_s.includes?({{header}})
    main_node = node.parent.as(XML::Node).xpath_nodes("w:r/w:t")
    word = main_node.to_s[5 .. -7]
    @document += {{document}}
  end
  {% end %}
end

macro text_style(style, document)
  {% begin %}
  style = {{style}}
  if get_text.as(XML::Node).xpath_nodes("w:r/w:rPr/w:#{style}")
    unless get_text.as(XML::Node).xpath_nodes("w:r/w:rPr/w:#{style}").to_s.includes("false") || get_text.as(XML::Node).xpath_nodes("w:r/w:rPr/w:#{style}").to_s.includes?("none")
      if get_text.to_s.includes?("#{style}")
        word = get_text.as(XML::Node).xpath_nodes("w:r/w:t")
        unless word.to_s.empty?
          @document += {{document}}.sub("<w:t>", "").sub("</w:t>", "")
          @changed = true
        end
      end
    end
  end
  {% end %}
end
