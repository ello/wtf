# Ello WTF Site

## Staging Server Info

* URL: [***REMOVED***](***REMOVED***)
* user: `ellowtf`
* password: `***REMOVED***`

## Content Workflow

All posts go in the `_posts` folder and inside their respective category folder for the sake of keeping things organized (Jekyll doesn’t actually care).

### Filename:
Files must end in the `.md` extension and begin with a date (the date itself doesn’t matter).

The words (and dashes) after the date make up the slug (end of the URL) for the post. For example, a filename of **2015-01-23-contact-us.md** will result in a slug of **contact-us**. If you place this post in _Help_, the full URL will be: **/wtf/help/contact-us**.

### Post Meta Data:
Each Markdown post file contains meta data at the top of the file. This helps Jekyll know where to place the article on the site and when to publish it.
```
---
layout: post
title:  "I am a title"
date:   2015-01-23 01:23:45
categories: about
position: 3
video: http://vimeo.com/30619461
---
```

* `layout:` this should _always_ be set to `post`
* `title:` The title of your article, inside of quote marks: `"I am a title"`
* `date:` The publish date of an article (or its last updated date): `2015-01-23 01:23:45`
* `categories:` Pick the single category for the article (see the list in the section below): `policies`
* `position:` This determines the position of the article in the category list. Lower numbers are at the top of the list.
* `video:` Include a Vimeo or Youtube link to feature a video at the very top of the post page (**optional**)

**Other Notes:** Posts with future dates are ignored and not published. Keep in mind that updating the post position may require updates to other articles in the list to get the ordering you desire.

### Post Categories:
Available categories (anything else will be ignored and not appear on the category lists)

* `about`
* `help`
* `policies`
* `resources`

### Post Content:
All content goes below the _Post Meta Data_ and is formatted with Markdown.

[Markdown Docs](http://daringfireball.net/projects/markdown/syntax)

## Installing & Running Jekyll

### Installing Jekyll:

This [Jekyll](http://jekyllrb.com/) install relies on a few different gems (in addition to Jekyll), so be sure to run bundle install:

* $ `bundle install`

### Running Jekyll Locally:

* $ `jekyll serve`
* Point your browser at: [http://localhost:4000/wtf/](http://localhost:4000/wtf/) (the trailing slash is important)
* Content/design changes should update locally as you make them
