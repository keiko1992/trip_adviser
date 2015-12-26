module ArticlesHelper
  def summarize_content(content, letters)
    simple_format(strip_tags(content.truncate(50)))
  end
end
