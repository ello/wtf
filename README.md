<img src="http://d324imu86q1bqn.cloudfront.net/uploads/user/avatar/641/large_Ello.1000x1000.png" width="200px" height="200px" />

# WTF — Static content for Ello
WTF is a [Jekyll](https://jekyllrb.com/) app that builds static content to be served up at https://ello.co/wtf, including help, FAQs, and about pages. It is patterned on [Github's documentation workflow](https://github.com/blog/1939-how-github-uses-github-to-document-github).

[![Circle CI](https://circleci.com/gh/ello/wtf.svg?style=svg)](https://circleci.com/gh/ello/wtf)
[![Code Climate](https://codeclimate.com/github/ello/wtf/badges/gpa.svg)](https://codeclimate.com/github/ello/wtf)
[![Hakiri](https://hakiri.io/github/ello/wtf/master.svg)](https://hakiri.io/github/ello/wtf)
[![Dependency Status](https://gemnasium.com/ello/wtf.svg)](https://gemnasium.com/ello/wtf)
[Docker Hub](https://hub.docker.com/r/ello/wtf/)

## Getting Started

There are two options for running WTF for local development:

## Making changes & previewing them locally with Docker

This is an easier alternative to the Jekyll install option below.

1. Download and install [Github for Mac](https://desktop.github.com/)
2. Download and install the [Atom Editor](https://atom.io/)
3. Download and install the [Docker Toolbox](https://www.docker.com/docker-toolbox)
4. Create a [Docker Hub account](https://hub.docker.com/) and ping ops@ello.co to get added to the Ello account
5. From Github for Mac, sign into your Github account. Click the `+` button in the upper left, switch to the `Clone` tab, and clone the `wtf` repository.
6. Make changes to your local copy of WTF using Atom, then preview them in browser, restarting the container with Kitematic as needed. When you're done, commit your changes in Github for Mac and sync them to Github.

## Installing & running Jekyll natively

### Installing Jekyll:

This [Jekyll](http://jekyllrb.com/) install relies on a few different gems (in addition to Jekyll), so be sure to run bundle install:

* $ `bundle install`

### Running Jekyll Locally:

* $ `jekyll serve`
* Point your browser at: [http://localhost:4000/wtf/](http://localhost:4000/wtf/) (the trailing slash is important)
* Content/design changes should update locally as you make them



## Content Workflow (for Ello staff)

1. Edit the master branch in Github. Make sure no one else is editing so you don't collide.
2. Commit changes, check CircleCI to see if changes pass.
3. See how changes look on the [staging server](http://ello-wtf-staging.herokuapp.com/wtf/).
3. Deploy master branch on Heroku.


## Authoring Posts & Pages

### Filename:

All posts go in the `_posts` folder and inside their respective category folder to keep things organized.

Files must end in the `.md` extension and begin with a date (use the date the article was first created).

The words (and dashes) after the date make up the slug (end of the URL) for the post. For example, a filename of **2015-01-23-contact-us.md** will result in a slug of **contact-us**. If you place this post in _Help_, the full URL will be: **/wtf/help/contact-us**.

### Post Metadata:
Each Markdown post file contains meta data at the top of the file. This helps Jekyll know where to place the article on the site and when to publish it.
```
---
layout: post
title: "I am a title"
title_alternate: "I am a title for the title bar"
date: 2015-01-23 01:23:45 MDT
categories: about
position: 3
excerpt: "I am an (optional) SEO-friendly excerpt. Filling me out will place me in the <meta> description and as the summary for the search results page. The length can be a few sentences, but don’t make it too long!"
video: http://vimeo.com/30619461
---
```

* `layout:` this should _always_ be set to `post`
* `title:` The title of your article, inside of quote marks: `"I am a title"`
* `title_alternate:` The title you wish to appear in the `<title>` tag of the site: `"I am a title for the title bar"` **(optional)**
* `date:` The publish date of an article (or its last updated date): `2015-01-23 01:23:45 MDT` (remember to include your time zone at the end: i.e. `EST` or `MDT`)
* `categories:` Pick the single category for the article (see the list in the section below): `policies`
* `position:` This determines the position of the article in the category list. Lower numbers are at the top of the list. Other posts in the category are not auto-matically re-numbered, so if you want to place a new post at the top of the category, you will need to edit the `position` in the other posts as well.
* `excerpt:` If filled out with a couple sentences, it will get used in the description `<meta>` tag for the page and also in the search results display. **(optional)**
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
All content goes below the _Post Metadata_ and is formatted with Markdown.

[Markdown Docs](http://daringfireball.net/projects/markdown/syntax)

You do not need to repeat the title of your post — it will be automatically add from the Post Meta Data. The most common sub-title or sub-section format option is the `<h2>` which, in Markdown, is represented by using: `##`.

Lists (ordered, with numbers, or unordered, with bullet points) will be formatted. Code and blockquote formatting is also available.

### Emoji

Emoji support is baked in, just like the main site. Use colons to wrap [the emoji you want](http://www.emoji-cheat-sheet.com) to use: `:bread:` or `:ello:` :bread: :+1:

## License
WTF is released under the [MIT License](blob/master/LICENSE)

## Code of Conduct
Ello was created by idealists who believe that the essential nature of all human beings is to be kind, considerate, helpful, intelligent, responsible, and respectful of others. To that end, we enforce [the Ello rules](https://ello.co/wtf/policies/rules/) within all of our open source projects. If you don’t follow the rules, you risk being ignored, banned, or reported for abuse.

