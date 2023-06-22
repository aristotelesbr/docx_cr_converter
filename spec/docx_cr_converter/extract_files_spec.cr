require "../spec_helper"

Spectator.describe DocxCrConverter::ExtractFiles do
  subject(docx) { DocxCrConverter::ExtractFiles.new(path) }

  context "with valid docx value" do
    let(path) { "./spec/fixtures/valid.docx" }
    it "expects docx to be truthy" do
      expect(docx).to be_truthy
    end

     it "expects docx.xml_document to be a String or XML::Node" do
      expect(docx.xml_document).to be_a(String | XML::Node)
    end

    it "expects docx.errors? to be falsey" do
      expect(docx.errors?).to be_falsey
    end
  end
end
