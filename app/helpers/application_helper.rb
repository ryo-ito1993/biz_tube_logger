module ApplicationHelper
  def default_meta_tags
    {
      site: 'BizTubeLogger',
      title: 'BizTubeLogger',
      # reverse: true,
      charset: 'utf-8',
      description: 'ビジネスYouTubeアウトプット記録・共有サービス',
      keywords: 'ビジネス, YouTube, ビジネス系YouTube, アウトプット, 記録管理, 積み上げ',
      canonical: request.original_url,
      separator: '|',
      og: {
        site_name: :site,
        title: :title,
        description: :description,
        type: 'website',
        url: request.original_url,
        image: image_url('top_ogp.jpg'),
        locale: 'ja_JP'
      }
    }
  end
end
