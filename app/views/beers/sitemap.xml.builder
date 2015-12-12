xml.instruct! :xml, :version => "1.0", :encoding => "UTF-8"
xml.urlset "xmlns" => "http://www.sitemaps.org/schemas/sitemap/0.9", 
		   "xmlns:xsi" => "http://www.w3.org/2001/XMLSchema-instance",
		   "xsi:schemaLocation" => "http://www.sitemaps.org/schemas/sitemap/0.9 http://www.sitemaps.org/schemas/sitemap/0.9/sitemap.xsd" do
  


  xml.url do
      xml.loc root_url
      xml.lastmod "2015-12-11"
      xml.changefreq "monthly"
      xml.priority "0.1"
    end

  for beer in @beers do
    xml.url do
      xml.loc beer_url(beer)
      xml.lastmod beer.updated_at.to_date
      xml.changefreq "monthly"
      xml.priority "0.5"
    end
  end

  for page in @pages do
    xml.url do
      xml.loc page_url(page)
      xml.lastmod page.updated_at.to_date
      xml.changefreq "monthly"
      xml.priority "0.2"
    end
  end
end