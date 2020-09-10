require "../spec_helper"

Spectator.describe DocxCrConverter::ExtractFiles do
  subject(docx) { DocxCrConverter::ExtractFiles.new(path) }

  describe "When valid data" do
    context "with valid docx value" do
      given path = "./spec/fixtures/file-sample.docx" do
        it { expect(docx).to be_truthy }
        it { expect(docx.xml_document.is_a?(String | XML::Node)).to be_truthy }
        it { expect(docx.errors?).to be_falsey }
      end
    end
  end
end
