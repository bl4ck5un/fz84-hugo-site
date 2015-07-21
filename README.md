# See it [here](http://fanzy.me)!

This repo contains the source code of my personal website and blog hosted 
at github pages accessible from http://fanzy.me.


# Work on

## getting the source code

[Hugo](http://gohugo.io) is the static website generator behind this website,
which chould be installed by `brew install hugo`.

To include all submodules, clone this repo with 

    git clone --recursive https://github.com/bl4ck5un/fz84-hugo-site


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
