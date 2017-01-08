module Jekyll

  class TagPage < Page
    def initialize(site, base, dir, tag, name, lang)
      @site = site
      @base = base
      @dir = dir
      @name = name

      self.process(@name)
      self.read_yaml(File.join(base, '_layouts'), 'tag_page.html')
      self.data['tag'] = tag
      self.data['lang'] = lang
      self.data['ref'] = "tag_#{tag}"

      tag_title_prefix = site.config['tag_title_prefix'] || 'Tag: '
      self.data['title'] = "#{tag_title_prefix}#{tag}"
    end
  end

  class TagPageGenerator < Generator
    safe true

    def generate(site)
      if site.layouts.key? 'tag_page'
        dir = site.config['tag_dir'] || 'tags'
        site.tags.each_key do |tag|
          site.pages << TagPage.new(site, site.source, dir, tag, "#{tag}.html", 'en')
          site.pages << TagPage.new(site, site.source, dir, tag, "#{tag}.uk.html", 'uk')
        end
      end
    end
  end

end
