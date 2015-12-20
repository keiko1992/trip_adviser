module ApplicationHelper
  def default_meta_tags
    {
      site: Settings.site[:name],
      reverse: true,
      description: Settings.site[:page_description],
      og: {
        title: Settings.site[:name],
        type: Settings.site[:meta][:og][:type],
        url: root_url,
        image: image_url(Settings.site[:meta][:og][:image]),
        site_name: :site,
        description: :description,
        locale: 'ja_JP'
      },
      twitter: {
        card: Settings.site[:meta][:twitter][:card],
        site: Settings.site[:meta][:twitter][:site],
        title: Settings.site[:name],
        description: Settings.site[:page_description],
        image: {_: image_url(Settings.site[:meta][:og][:image])}
        }
      }
  end
end
