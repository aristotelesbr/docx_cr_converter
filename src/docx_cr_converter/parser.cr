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
  end
end
