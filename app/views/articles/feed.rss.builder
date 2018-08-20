#encoding: utf-8

xml.instruct! :xml, :version => "1.0" 
xml.rss :version => "2.0" do
  xml.channel do
    xml.title 'Simple blog'
    xml.description "A simple blog!"
    xml.link root_url
    
    for article in @articles
      xml.item do
        xml.title article.title
        xml.description article.body_html
        xml.pubDate article.published_at.to_s(:rfc822)
        xml.link article_url(article)
        xml.guid article_url(article)
      end
    end
  end
end
