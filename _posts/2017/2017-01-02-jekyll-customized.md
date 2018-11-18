---
layout: post
title:  "Jekyll customizations for sakhnik.com"
ref:    jekyll-customized
lang:   en
date:   2017-01-02 14:11:38 +02:00
tags:   web
---

Two features has been added to the site recently: language change flag
in the header and pagination of posts. To achieve this, I had to learn
some basics of [Jekyll](https://jekyllrb.com/),
[liquid](http://shopify.github.io/liquid/) and
[Ruby](https://www.ruby-lang.org/en/). Let's summarize how it was done.

Pagination required a custom generator plugin. Starting from an
[existing](https://divshot.com/blog/web-development/advanced-jekyll-features/#pagination-with-category)
one, it was trivial to hack off excessive parts, adopt to my requirements.
The resulting plugin is available in
[github](https://github.com/sakhnik/sakhnik.com/blob/20d6e297366b8415438d4ef19c8fc867333134ae/_plugins/pagination.rb).
The pagination links are generated with
[pagination.html](https://github.com/sakhnik/sakhnik.com/blob/20d6e297366b8415438d4ef19c8fc867333134ae/_includes/pagination.html).

With lots of pages, previous way of language switching became broken, because
there would be many pages with given `ref` now. So we select only the first
link now for the opposite language. The result is pleasant.

Given the possibility, I refactored few bits of code to avoid duplication
of code, for instance, in page layouts. If there were different just in localized
strings, I just moved the definitions to
[`_config.yml`](https://github.com/sakhnik/sakhnik.com/commit/ecc62ac95bf95e6de2578576d3db7b7ce6b1cebd#diff-aeb42283af8ef8e9da40ededd3ae2ab2R15). Perhaps, it'd be better to keep them in the local
front matter.
