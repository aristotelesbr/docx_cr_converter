require "../spec_helper"

Spectator.describe DocxCrConverter::Parser do
  subject(docx) { DocxCrConverter::Parser.new(path) }

  describe "When valid data" do
    context "with the docx value" do
      given path = "./spec/fixtures/file-sample.docx" do
        it { expect(docx.xml).to be_truthy }
        it { expect(docx.xml).to respond_to(:errors?) }
        it { expect(docx.errors?).not_to be_truthy }
        it { expect(docx.xml.xml_document.is_a?(XML::Node | String)).to be_truthy }
      end
    end

    context "#parser" do
      let(parse_docx) { DocxCrConverter::Parser.new("./spec/fixtures/file-sample.docx") }
      before_each do
        parse_docx.parse
      end
      given path = "./spec/fixtures/file-sample.docx" do
        it { expect(parse_docx).to be_truthy }
        it { expect(parse_docx.document.is_a?(String)).to be_truthy }
        it { expect(parse_docx.document).to match(/Lorem ipsum/) }
      end
    end
  end

  describe "When invalid data" do
    context "with invalid docx" do
      given path = "./spec/fixtures/file-sample.docx" do
        it "with errors messages" do
        end
      end
    end
  end
end
