# Make a string safe for CSS
#
# CSS selectors are pretty particular what they use
# This is useful for things like element IDs etc.
#
# Examples
#
#   {{ "Hi ho, what the F%$&@ is this?!?" | css_safe }}
#   # => "hi_ho_what_the_f_is_this"
#
# Returns the formatted String.

module Jekyll
  module Filters
    def css_safe(input)
      input.downcase.gsub(/[^a-z\s]/, '').gsub(/[\s]/, '_')
    end
  end
end
