require "../spec_helper"

Spectator.describe DocxCrConverter::Parser do
  context "when valid data" do
    subject(docx) { DocxCrConverter::Parser.new(path) }
    let(path) { "./spec/fixtures/valid.docx" }

    it "expects docx.xml to be truthy" do
      expect(docx.xml).to be_truthy
    end

    it "expects docx.xml to respond to errors?" do
      expect(docx.xml).to respond_to(:errors?)
    end

    it "expects docx.errors? to not be truthy" do
      expect(docx.errors?).not_to be_truthy
    end

    it "expects docx.xml.xml_document to be XML::Node or String" do
      expect(docx.xml.xml_document).to be_a(XML::Node | String)
    end
  end

  context "#parser" do
    let(docx) { DocxCrConverter::Parser.new("./spec/fixtures/valid.docx") }

    before_each { docx.parse }

    it "expects parse_docx to be truthy" do
      expect(docx).to be_truthy
    end

    it "expects parse_docx.document to be a String" do
      expect(docx.document).to be_a(String)
    end

    it "expects parse_docx.document to match /Lorem ipsum/" do
      expect(docx.document).to match(/Lorem ipsum/)
    end
  end
end

