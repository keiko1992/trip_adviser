# save tags to DB
$(document).on 'ready page:load', ->
  $('.article-tags').tagit
    fieldName:   'article[tag_list]'
    singleField: true

  if gon.article_tags?
    for tag in gon.article_tags
      $('.article-tags').tagit 'createTag', tag

# autcomplete posted tags
$(document).on 'ready page:load', ->
  $('.article-tags').tagit
    fieldName:     'article[tag_list]'
    singleField:   true
    availableTags: gon.available_tags
