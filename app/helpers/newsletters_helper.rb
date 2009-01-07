module NewslettersHelper
  
  def lien_ajout_article(nom)
    link_to_function nom do |page|
			page.insert_html :bottom, :articles, :partial => 'contenu_nl',
			 :object => NlContent.new()
		end
  end
  
end
