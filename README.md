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

### Markd

```crystal
require "docx_cr_converter"
require "markd"

docx = DocxCrConverter::Parser.new("./files/document.docx")
docx.parse
html = Markd.to_html(docx.document)
p html.gsub("\n", "")

#<h1>Title</h1>
#<h2>Subtitle</h2>
#<h1>Header1</h1>
#<h2>Header2</h2>
#<h3>Header3</h3>
#<p>Normal txt 
#<strong>Bold txt</strong>
#<em>Italics txt</em>
#<ins>Underscore txt</ins>
#<del>Strike txt</del>
#</p>
#<ul>
#<li>
#<p>Unordered</p>
#</li><li>
#<p>List</p>
#</li><li>
#<p>Numbered</p>
#</li><li>
#<p>List</p>
#</li>
#</ul>
```

### Plain Markdown

```crystal
require "docx_cr_converter"

docx = DocxCrConverter::Parser.new("./files/document.docx")
docx.parse
puts docx.errors?
# => false
puts docx.document

# # Title 
#
# ## Subtitle 
#
# # Header1 
#
# ## Header2 
#
# ### Header3 
#
#  Normal txt **Bold txt** *Italics txt* <ins>Underscore txt</ins> <del>Strike txt</del> 
#
#+ Unordered 
#
# + List 
#
# + Numbered 
#
# + List 
#
#
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
- [Rafael Pszenny](https://github.com/onliniak/) - Fixed markdown
