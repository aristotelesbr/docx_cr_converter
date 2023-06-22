[![Build Status](https://travis-ci.org/aristotelesbr2014/docx_cr_converter.svg?branch=master)](https://travis-ci.org/aristotelesbr2014/docx_cr_converter)

# docx_cr_converter

This tool initially extract text and simple markings from a .DOCX file and convert it to markdow format.

## Instal

Add this to your application's shard.yml:

```yml
development_dependencies:
  docx_cr_converter:
    github: aristotelesbr/docx_cr_converter
```

## Usage

```cr
require "docx_cr_converter"

docx = DocxCrConverter::Parser.new("./spec/fixtures/valid.docx")
docx.parse

puts docx.document
```

Output:

```md
# Lorem ipsum 

# + Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc ac faucibus odio. 

Vestibulum neque massa, scelerisque sit amet ligula eu, congue molestie mi. Praesent ut varius sem. Nullam at portti
tor arcu, nec lacinia nisi. Ut ac dolor vitae odio interdum condimentum. Vivamus dapibus sodales ex, vitae malesuada
 ipsum cursus convallis. Maecenas sed egestas nulla, ac condimentum orci. Mauris diam felis, vulputate ac suscipit e
t, iaculis non est. Curabitur semper arcu ac ligula semper, nec luctus nisl blandit. Integer lacinia ante ac libero 
lobortis imperdiet. Nullam mollis convallis ipsum, ac accumsan nunc vehicula vitae. Nulla eget justo in felis tristi
que fringilla. Morbi sit amet tortor quis risus auctor condimentum. Morbi in ullamcorper elit. Nulla iaculis tellus 
sit amet mauris tempus fringilla.

Maecenas mauris lectus, lobortis et purus mattis, blandit dictum tellus.

+ Maecenas non lorem quis tellus placerat varius. 

+ Nulla facilisi. 

+ Aenean congue fringilla justo ut aliquam. 

+ Nunc vulputate neque vitae justo facilisis, non condimentum ante sagittis. 

+ Morbi viverra semper lorem nec molestie. 

+ Maecenas tincidunt est efficitur ligula euismod, sit amet ornare est vulputate.
```

## TODO

- [x] Converter `.DOCX`
    - [x] `Markdown`
    - [ ] `HTML`

## Contributing

1. Fork it (<https://github.com/your-github-user/docx_cr_converter/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Aristoteles Coutinho](https://github.com/aristotelesbr2014) - creator and maintainer
