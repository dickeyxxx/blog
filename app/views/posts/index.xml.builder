xml.instruct! :xml, version: "1.0", encoding: 'utf-8'
xml.feed xmlns: 'http://www.w3.org/2005/Atom' do
  xml.title "dickey.xxx"
  xml.link href: posts_url(format: :xml), rel: :self
  xml.link href: root_url
  xml.id root_url
  xml.updated @posts.first.post_date.strftime "%Y-%m-%dT%H:%M:%SZ"
  xml.author do
    xml.name "Jeff Dickey"
    xml.email "me@jeffdickey.info"
  end

  @posts.each do |post|
    xml.entry do
      xml.title post
      xml.link rel: 'alternate', href: post.permalink
      xml.id post.permalink
      xml.updated post.post_date.strftime "%Y-%m-%dT%H:%M:%SZ"
      xml.author do
        xml.name "Jeff Dickey"
        xml.email "jeff@dickey.xxx"
      end
      xml.content type: :html do
        xml.text! "<h1>#{post}</h1>"
        xml.text! "<img src='#{post.image.url}' />"
        xml.text! markdown(post.body)
      end
      split_body = markdown(post.body).split(/<\/p>/)
      if strip_tags(split_body.first).length < 120
        xml.summary strip_tags(split_body.first + split_body.second)
      else
        xml.summary strip_tags(split_body.first)
      end
    end
  end
end
