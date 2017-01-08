module Jekyll
  module TagHelpersFilter
    def sort_tags_by_posts_count(tags, language)
      return tags.map     { |k,v| [k, v.select {|a| a.data['lang'] == language}] }
                 .reject  { |k,v| v.empty? }                # Filter out empty tags
                 .map     { |k,v| [ k, v.size ] }           # Count of posts for a tag
                 .sort_by { |x| [ -x[1], x[0].downcase ] }  # Sort finally descending
    end
  end
end

Liquid::Template.register_filter(Jekyll::TagHelpersFilter)
