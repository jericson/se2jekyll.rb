# se2jekyll.rb

Fetch Stack Exchange posts for publishing on a Jekyll-powered blog.

## Synopsis

    se2jekyll.rb site post_id

Example (http://meta.puzzling.stackexchange.com/a/3020):

    se2jekyll.rb Meta.Puzzling 3020 > site_evaluations.md
   
## Description

All posts to Stack Exchange are licensed under
[Creative Commons](http://creativecommons.org/licenses/by-sa/3.0/),
which means they can be republished with
[attribution](http://blog.stackoverflow.com/2009/06/attribution-required/). This
script uses the
[Stack Exchange API](http://api.stackexchange.com/docs) to get a copy
of a post for publication via [Jekyll](http://jekyllrb.com/docs/home/)
with the primary benefit being added
[front matter](http://jekyllrb.com/docs/frontmatter/). It's intended
to be mostly automatic, but you might want to put it in the `_drafts`
folder for revision before publishing.

## Options

* `site`

  The API site parameter can be extracted from the
  [API itself](http://api.stackexchange.com/docs/sites#filter=!.UDMsw.ggx2QiCOe&run=true)
  or you can make a guess based on URL of the site. For instance,
  Movies & TV's URL is `http://movies.stackexchange.com/` so its site
  parameter is just `movies`. The meta site is `Meta.Movies`. Note
  that capitalization does not matter to the API, but the string will be used
  in the attribution text as-is.

* `post_id`

  Every
  [question and answer](http://meta.stackexchange.com/a/36716/1438)
  has a unique (to the site) ID. The second parameter<sup>*</sup> is
  that number, which may be found in the URL or by examining the share
  link at the bottom of a post.

## Output

If all goes well, a converted version of the post will be sent to
`STDOUT`. It will included some Jekyll front matter (tuned to
[my blog's configuration](https://github.com/jericson/jericson.github.io)),
a short attribution notice, and the body of the post. It's your
responsibility to redirect the output to an appropriate file.

Depending on which
[Markdown renderer](http://jekyllrb.com/docs/configuration/) you use,
you might find some strangenesses in the HTML output. For instance,
Stack Exchange parses
[two block quotes separated by a blank line as a single block](http://spec.commonmark.org/0.19/#example-154)
and
[GitHub Flavored Markdown](https://help.github.com/articles/github-flavored-markdown/)
as two blocks. Many other quirks won't matter too much, but that one
is pretty visible to me. The moral of the story is to leave room for
edits.

## Todo

* There are several things we could look up with an extra API call or two. In particular:

  * Question tags
  * Actual site name
  * List of editors to credit and not just the owner

* Obtain multiple posts based on some criteria such as author.

* Error checking.

---

\* Technically, you can pass multiple `post_id`s. Currently, only
      one is really supported since the output is sent to `STDOUT`
      rather than individual files. It's not terrible hard to break
      the posts out based on front matter, however, so I left this as
      a
      [hidden option](http://www.in-n-out.com/menu/not-so-secret-menu.aspx).

<!--  LocalWords:  jekyll rb LocalWords sa se md frontmatter Todo io
 -->
<!--  LocalWords:  STDOUT aspx renderer strangenesses GitHub
 -->
