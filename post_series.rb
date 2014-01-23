##
# Post Series
#   - Inspired by: http://blog.sleeplessbeastie.eu/2013/06/20/jekyll-how-to-use-post-parameters-as-custom-taxonomy/
#
# Copyright 2011 Matt Reimer 
# 
#    Licensed under the Apache License, Version 2.0 (the "License");
#    you may not use this file except in compliance with the License.
#    You may obtain a copy of the License at
# 
#        http://www.apache.org/licenses/LICENSE-2.0
# 
#    Unless required by applicable law or agreed to in writing, software
#    distributed under the License is distributed on an "AS IS" BASIS,
#    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#    See the License for the specific language governing permissions and
#    limitations under the License.
##

module Jekyll 

  # 
  #  Initializers and declarations
  # --------------------------------------------
  @series_dir = 'series'

  # Here's the series list declaration
  class SeriesList < Page    
    def initialize(site, base, dir)
      @site = site
      @base = base
      @dir = dir
      @name = 'index.html'

      # puts self.data['post_series'].to_yaml
      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'series_list.html')
      # self.data['series_list'] = series_list
      self.data['title'] = "Post Series"
    end
  end

  #  Now the Series index Generator
  class SeriesIndexGenerator < Generator
    safe true
    
    def generate(site)
      if site.layouts.key? 'series_list'

        dir = 'series'

        # Write a main index
        index = SeriesList.new(site, site.source, dir)
        index.render(site.layouts, site.site_payload)
        index.write(site.dest)
        site.pages << index
      end
    end

  end

  # Extending Site Class
  # Note: It must be done this way but maybe not when jekyll 
  # matures
  class Site
    
    # collecting all categories into an array
    def all_series

      series_list = [];
      self.posts.each do |p|
        series_list << p.data['series'] if !series_list.include? p.data['series'] and !p.data['series'].nil?
      end

      # get series' posts
      post_series = []
      series_list.each do |series|
        series_posts = []
        self.posts.each do |p|
          ((series_posts << p) if p.data['series'] == series) if p.data['series']
        end
       post_series << {"name" => series, "posts" => series_posts}
        # series['posts'] = series_posts.reverse
      end

      post_series

   end
    
    # make the new methods accessible via Liquid
    alias orig_site_payload site_payload

    def site_payload
      h = orig_site_payload
      payload = h["site"]
      payload["all_series"] = all_series
      h["site"] = payload
      h
    end
    
  end

end