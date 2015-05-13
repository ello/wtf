# Ello WTF Site

## Staging Server Info

* URL: [***REMOVED***](***REMOVED***)
* user: `ellowtf`
* password: `***REMOVED***`

## Content Workflow

All posts go in the `_posts` folder and inside their respective category folder to keep things organized.

### Filename:
Files must end in the `.md` extension and begin with a date (use the date the article was first created).

The words (and dashes) after the date make up the slug (end of the URL) for the post. For example, a filename of **2015-01-23-contact-us.md** will result in a slug of **contact-us**. If you place this post in _Help_, the full URL will be: **/wtf/help/contact-us**.

### Post Meta Data:
Each Markdown post file contains meta data at the top of the file. This helps Jekyll know where to place the article on the site and when to publish it.
```
---
layout: post
title: "I am a title"
title_alternate: "I am a title for the title bar"
date: 2015-01-23 01:23:45 MDT
categories: about
position: 3
video: http://vimeo.com/30619461
---
```

* `layout:` this should _always_ be set to `post`
* `title:` The title of your article, inside of quote marks: `"I am a title"`
* `title_alternate:` The title you wish to appear in the `<title>` tag of the site: `"I am a title for the title bar"` **(optional)**
* `date:` The publish date of an article (or its last updated date): `2015-01-23 01:23:45 MDT` (remember to include your time zone at the end: i.e. `EST` or `MDT`)
* `categories:` Pick the single category for the article (see the list in the section below): `policies`
* `position:` This determines the position of the article in the category list. Lower numbers are at the top of the list. Other posts in the category are not auto-matically re-numbered, so if you want to place a new post at the top of the category, you will need to edit the `position` in the other posts as well.
* `video:` Include a Vimeo or Youtube link to feature a video at the very top of the post page **(optional)**

**Other Notes:**
* Posts with future dates are ignored and not published until their publish date is reached _(remember to set you time zone AND remember that times are in 24-hour format: i.e. 2pm is 14:00)_.
* Keep in mind that updating the post position may require updates to other articles in the list to get the ordering you desire.
* The `title_alternate` is optional. If not provided, the normal `title` will be used in the `<title>` tag. The Post category, main site title, and site subtitle line will still be appended. These are all configurable in the `_config.yml` file.

### Post Categories:
Available categories (anything else will be ignored and not appear on the category lists)

* `about`
* `help`
* `policies`
* `resources`

### Post Content:
All content goes below the _Post Meta Data_ and is formatted with Markdown.

[Markdown Docs](http://daringfireball.net/projects/markdown/syntax)

You do not need to repeat the title of your post—it will be automatically add from the Post Meta Data. The most common sub-title or sub-section format option is the `<h2>` which, in Markdown, is represented by using: `##`.

Lists (ordered, with numbers, or unordered, with bullet points) will be formatted. Code and blockquote formatting is also available.

#### Emoji Support

Emoji Support is baked in, just like the main site. Use colons to wrap [the emoji you want](http://www.emoji-cheat-sheet.com) to use: `:bread:` or `:ello:` :bread: :+1:

## Installing & Running Jekyll

### Installing Jekyll:

This [Jekyll](http://jekyllrb.com/) install relies on a few different gems (in addition to Jekyll), so be sure to run bundle install:

* $ `bundle install`

### Running Jekyll Locally:

* $ `jekyll serve`
* Point your browser at: [http://localhost:4000/wtf/](http://localhost:4000/wtf/) (the trailing slash is important)
* Content/design changes should update locally as you make them
