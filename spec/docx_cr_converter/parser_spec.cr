require "../spec_helper"

Spectator.describe DocxCrConverter::Parser do
  subject(docx) { DocxCrConverter::Parser.new(path) }

  describe "When valid data" do
    context "with the docx value" do
      given path = "./spec/fixtures/file-sample.docx" do
        it { expect(docx.xml).to be_truthy }
        it { expect(docx.xml).to respond_to(:errors?) }
        it { expect(docx.errors?).not_to be_truthy }
      end
    end
  end
end
