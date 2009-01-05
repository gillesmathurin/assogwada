module ConseiladminsHelper
  def lien_ajout_membre(nom)
    link_to_function nom do |page|
			page.insert_html :bottom, :membres, :partial => 'membre', :object => Membre.new
		end
  end
end
