[![Build Status](https://travis-ci.org/aristotelesbr2014/docx_cr_converter.svg?branch=master)](https://travis-ci.org/aristotelesbr2014/docx_cr_converter)

# docx_cr_converter

This tool initially extract text and simple markings from a .DOCX file and convert it to markdow format.

## Installation

Add this to your application's shard.yml:

```yml
development_dependencies:
  docx_cr_converter:
    github: aristotelesbr2014/docx_cr_converter
```

## Usage

```crystal
require "docx_cr_converter"

docx = DocxCrConverter::Parser.new("./file-sample.docx")
docx.parse
puts docx.errors?
# => false
puts docx.document

# =>  # My Awesome document
#
#   ## Spectator
#
#     Spectator is a fully-featured spec-based test framework for Crystal.
#   It mimics features from RSpec.
#   Developers coming from Ruby and RSpec will feel right at home.
#   Spectator provides additional functionality to make testing easier and more fluent.
#
#   Goal:
#
#   * Spectator is designed to:
#   * Reduce complexity of test code.
#   * Remove boilerplate from tests.
#   * Lower the difficulty of writing non-trivial tests.
#   * Provide an elegant syntax that is easy to read and understand.
#   * Provide common utilities that the end-user would otherwise need to write.
#
#  ....
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
