module BeersHelper


  def embed(youtube_url)
  	if !@beer.youtube_url.blank?
    	youtube_id = @beer.youtube_url.split("=").last
    	content_tag(:iframe, nil, src: "//www.youtube.com/embed/#{youtube_id}")
	end
  end

end
