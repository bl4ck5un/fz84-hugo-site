# See it!

This repo contains the source code of my personal website and blog hosted 
at github pages (http://fanzy.me)


# Work on it!

## Obtain tools

- [Hugo](http://gohugo.io) is the static website generator spawning this site. 
    please install it by `brew install hugo` (assume Mac OS w/ `brew`)
- [Compass](http://compass-style.org) is a style framework. You can install
    it through `gem`:

        sudo gem update --system
        sudo gem install compass

## getting the source code

To include all submodules, clone this repo with 

    git clone --recursive https://github.com/bl4ck5un/fz84-hugo-site

## build

First make sure you have cloned all of the submodules (preferably by `--recursive` flag).
If not, it's highly suggested that you start from the very beginning. Then,
following steps to build the Hugo website as well as its dependencies:

    pushd theme/hyde/compass 
    compass compile
    popd
    hugo

Verify the result and correct any errors to make sure everything is setup.

## create new blog

At the root directory of source tree, issue the following:

    hugo new post/article-title.md

A prepopulated markdown file will be created at `content/post`.


## notes

### Type-specific rendering

#### homepage (type `index`)

According to Hugo [doc](http://gohugo.io/templates/homepage/), homepage will 
be rendered by the following templates (only relevances are listed, see doc 
for a comprehensive list): `/themes/THEME/layouts/index.html`, which contains

    {{ range .Data.Pages }}
        {{ if eq .Type "index" }}
            {{ .Content }}
        {{ end }}
    {{ end }}

So only contents with type `index` would be rendered here.

#### static (type `static`)

Static pages refer to non-blog contents such as `about.md`. Here parameter
`Data` makes no sense because as the type suggests, these contents are static.
So in `themes/hyde/layouts/partials/_default/single.html`, a `<hr>` (horizontal
bar) is inserted instead of `Date`. 

    {{ if eq .Type "static" }}
    <!-- static type refers to non-blog content, such as about.md -->
    <hr>
    {{ else }} 
    <span class="post-date">{{ .Date.Format "Mon, Jan 2, 2006" }}</span>
    {{ end }}


> All rights reserved.
