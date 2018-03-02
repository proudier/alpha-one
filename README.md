# Alpha-One

A Jekyll theme designed for enhanced readability of (long) blog posts.

## Features 

- Responsive layout (based on Bootstrap)
- Syntax highlighting
- Social links (IN PROGRESS)
- Gem-based (ie. easy updates!)

TODO: 
- Tags listing page
- Categories listing page
- Google Analytics integration

### Layouts

Alpha-One offers a `default` layout and a `post` layout. The `page` layout is a redirection to the `default` layout.

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

Maybe you will be interested in copying the following files from the sample website to your site:
- favicon.png
- posts.html

## Configuration

The following variable can/must be set in `_config.yml`:
- title: text shown in the navbar and the footer
- motto: a maxim shown in the footer, under the title
- description: used by search engine
- twitter_username
- github_username  
- linkedin_username
- baseurl (optional): path to the root of your website; useful if it is hosted on a subpath
- png_favicon: name of the png file to be used as favicon; must reside bellow $baseurl
- header_link_1_label, header_link_1_href (both optional): used to add links in the navbar


## A note on table

To prettify your tables, use kramdown and add
`{: class="table table-striped"}`
right bellow the table in the markdown file

## Contributing

Bug reports and pull requests are welcome on [GitHub](https://github.com/proudier/alpha-one).

## License

The theme is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

