# se2jekyll.rb

Fetch Stack Exchange posts for publishing on a Jekyll-powered blog.

## Synopsis

```
Usage: ./se2jekyll.rb -s SITE post_id ...
    -s, --site SITE                  Site name
    -t, --tags TAG(S)                Space-delimited lowercase tags
    -h, --help                       Display this screen
```

Example (http://meta.puzzling.stackexchange.com/a/3020):

    se2jekyll.rb Meta.Puzzling 3020 > site_evaluations.md
   
## Description

All posts to Stack Exchange acquire a
[Creative Commons license](http://creativecommons.org/licenses/by-sa/3.0/)
that allows republication with
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
  link at the bottom of a post. You can find your post_ids by
  [your display name](http://data.stackexchange.com/stackoverflow/query/316319/all-my-posts?Name=)
  or
  [via the API](https://api.stackexchange.com/docs/me-posts#pagesize=100&order=desc&sort=creation&filter=!-.5dQYOim_ef&site=stackoverflow&run=true).

* `tags`

  If you want to
  [customize tags](https://github.com/pattex/jekyll-tagging), this is
  the option for you. Pass it any number of space-delimited strings
  like this:

   ```
   se2jekyll.rb -s stackoverflow 55885729 -t "libcurl curl locked" 
   ```

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

I've tried to fill in sensible values to the front matter. A few quirks to note:

* I use the question title as the post title, which is often a
  reasonable choice. Not everyone has the titling skill, however.

* If a title includes a `#`, I encode it `&num;` since that usually
  begins a comment in the
  [YAML fron matter block](https://jekyllrb.com/docs/front-matter/).

* I also titles with multiple colons as `&colon` for
  [a similar reason](https://github.com/jekyll/jekyll/issues/549). **But**
  I interpret titles with one colon as being a title and a
  subtitle. This might not work for your blog, but it works for
  [mine](https://github.com/jericson/jericson.github.io). I suspect
  this should be optional behavior if anyone besides me uses this
  script.

* Currently, the default tag is`meta-post` tag, which works for my
  blog's tagging system but might not for yours. 

* The date is set to the creation date of the post on Stack Exchange, not the current date.

* I include two custom variables:

  * `license: http://creativecommons.org/licenses/by-sa/3.0/`
  * `comments: no`

  These should not cause problems unless your blog layout has
  conflicting definitions of these variables.

Feel free to fork my code if these choices don't make sense for your purposes.

## Bugs

[![Build Status](https://travis-ci.org/jericson/se2jekyll.rb.svg?branch=master)](https://travis-ci.org/jericson/se2jekyll.rb)

* Not really a bug of this script but rather of, um, the current
  paradigm of font usage on the web: some pages might not render
  properly if your site doesn't set use a font family with the needed
  glyphs. See
  [The Tony the Pony problem](https://jericson.github.io/2018/12/17/tony_the_pony.html). 

## License

[Artistic License 2.0](https://github.com/jericson/se2jekyll.rb/blob/master/LICENSE)

## Todo

* There are several things we could look up with an extra API call or two. In particular:

  * Question tags
  * Actual site name
  * List of editors to credit and not just the owner

* Obtain multiple posts based on some criteria such as author.

* Error checking.

* Tests.

* Maybe make use of [OAuth identification](https://api.stackexchange.com/docs/authentication) somehow.
  <!-- http://stackapps.com/apps/oauth/view/4850 -->

* There's a
  [Ruby library for the Stack Exchange API](https://github.com/raysrashmi/ruby-stackoverflow). Should
  I use it?

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
<!--  LocalWords:  creativecommons stackoverflow
 -->
