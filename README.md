# Alpha-One

A Jekyl theme based on Bootstrap.

## Features 

- Resposive layout
- Syntax highlighting
- Social links (IN PROGRESS)

TODO: 
- Tags listing page
- Categories listing page
- Google Analytics integration

### Layouts

Alpha-One offers a default layout and a post layout. The page layout is a redirection to the default layout.

## Installation

Add this line to your Jekyll site's Gemfile:

```ruby
gem "alpha-one"
```

And add this line to your Jekyll site (_config.yml):

```yaml
theme: alpha-one
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install alpha-one


## Configuration

The following variable can/must be set in _config.yml
- title: text shown in the navbar and the footer
- motto: a maxim shown in the footer, under the title
- header_link_1_label, header_link_1_href (both optional): used to add links in the header bar
- twitter_username
- github_username  
- linkedin_username
- baseurl (optional): path to the root of your website; useful if it is hosted on a subpath
- png_favicon: name of the png file to be used as favicon; must reside bellow $baseurl


## A note on table

To prettify your tables, use kramdown and add
`{: class="table table-striped"}`
right bellow the table in the markdown file

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/proudier/alpha-one).

## License

The theme is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

