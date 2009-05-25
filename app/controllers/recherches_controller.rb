class RecherchesController < ApplicationController
  layout 'application', :except => :export_excel
  # caches_page :new
      
  before_filter :find_champintervention, :last_recorded     
  
  def index
  end

  def liste(associations)
    @associations = associations
  end
  
  # Affiche la fiche descriptive-visiteur de l'association sélectionnée parmis les résultats
  def show
    @association = Association.find(params[:id])
    @resultats = session[:resultats] unless session[:resultats].nil?
  end

  def new
    @rechercher = Recherch.new()
  end
  
  def create
    session[:resultats] = nil
    session[:commune] = nil
    @rechercher = Recherch.new(params[:rechercher])
    @associations = @rechercher.associations
  
    resultats = []
    unless @associations.nil?
      @associations.each do |a|
        resultats << [a.id, a.nom]
      end
      session[:resultats] = resultats
    end

    # Si Javascript est désactivé afficher liste.rhtml
    unless request.xhr?
      respond_to do |format|
       format.html {render :template => "recherches/liste"}
     end
    end
  end
  
  # POST
  def commune
    session[:resultats] = nil
    session[:commune] = nil
    @commune = params[:id]
    @associations = Association.find_by_commune(@commune)
    resultats = []
    @associations.each do |a|
      resultats << [a.id, a.nom]
    end
    session[:resultats] = resultats
    session[:commune] = @commune
    
    # Si Javascript est désactivé afficher liste.rhtml
    unless request.xhr?
       render :template => "recherches/liste"
    end
  end
  
  def export_result
    @associations = []
    
    unless session[:commune].nil?
      ville = session[:commune]
      filename = 'export_resultat_' + ville.to_s + '.csv'
    else
      filename = 'resultats_recherche.csv' 
    end
    
    @resultats = session[:resultats]
    @resultats.each do |array|
      association = Association.find(array[0])
      formatted_name(association)
      @associations << association
    end
        
    respond_to do |format|
      format.csv { send_data @associations.to_csv(:only => [:nom, :adresse_siegesocial, :cp_ville, :email]), :filename => filename }
    end
  end
  
  def export_excel
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="excel-export.xls"'
    headers['Cache-Control'] = ''
    @associations = []
      
    @resultats = session[:resultats]
    @resultats.each do |array|
      association = Association.find(array[0])
      formatted_name(association)
      @associations << association
    end
  end
    
  private
  
  def find_champintervention
    @ci_liste = ChampIntervention.select_array_nom    
  end
  
  def formatted_name(association)
    association.nom = ActiveSupport::Multibyte::Handlers::UTF8Handler.normalize(association.nom,:d).split(//u).reject { |e| e.length > 1 }.join
    association.adresse_siegesocial = ActiveSupport::Multibyte::Handlers::UTF8Handler.normalize(association.adresse_siegesocial,:d).split(//u).reject { |e| e.length > 1 }.join
    association.ville = ActiveSupport::Multibyte::Handlers::UTF8Handler.normalize(association.ville,:d).split(//u).reject { |e| e.length > 1 }.join
    return association
  end

end
