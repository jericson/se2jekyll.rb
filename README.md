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



<!--  LocalWords:  jekyll rb LocalWords sa se md frontmatter
 -->
