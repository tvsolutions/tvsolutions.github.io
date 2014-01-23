# Translate one kind of address into another
#
# I'm using this so I can have a shorthand for image urls
# that are hosted on amazon S3.
#
# Returns the formatted String.

module Jekyll
  class S3URLTag < Liquid::Tag

    def initialize(tag_name, text, tokens)
      super
      @text = text
    end

    def render(context)
      "https://s3.amazonaws.com/lifeoutthewindow.jekyll/uploads/"
    end
  end
end

Liquid::Template.register_tag('s3', Jekyll::S3URLTag)