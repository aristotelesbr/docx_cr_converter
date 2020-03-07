# docx_cr_converter

This tool initially extract text and simple markings from a .DOCX file and convert it to markdow format.

## Installation

```yml
Add this to your application's shard.yml:

development_dependencies:
  docx_cr_converter:
    github: aristotelesbr2014/docx_cr_converter
```

## Usage

```crystal
DocxCrConverter.parse("./my-doc.docx")
# =>  # My Awesome document
#
#     ## First
#
#     This tool initially extract text and simple markings from a .DOCX file and convert it to markdow format.
```

## Feature

TODO: Write development instructions here

- [ ] Converter `.DOCX`
  - [x] `Markdown`
  - [ ] `HTML`
  - [ ] `Latex`

## Contributing

1. Fork it (<https://github.com/your-github-user/docx_cr_converter/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Aristoteles Coutinho](https://github.com/aristotelesbr2014) - creator and maintainer
