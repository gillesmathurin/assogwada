class AssociationsController < ApplicationController
  layout 'application', :except => :export_xls_csv
  
  before_filter :login_required, :except => [:accueil, :inscription, :envoi, :download_quest,
     :add_ci, :remove_ci, :envoi_inscription, :test_exception, :show, :edit, :form_abonnement, :envoi_formabonnement, :newsletter]
  before_filter :find_ci, :find_conventions, :last_recorded
  # after_filter :after_validation
  
  # GET /accueil
  def accueil
    @abonne = Abonne.new
    @count = Association.count
    # render(:layout => false)
  end
  
  # GET /associations
  # GET /associations.xml
  def index
    # @association_pages, @associations = paginate(:association,
    #     { :order => "created_at DESC", :per_page => 20 })
     
    @associations = Association.paginate(:page => params[:page], 
                                         :conditions => ['nom like ?', "%#{params[:search]}%"],
                                         :per_page => 20,
                                         :order => "created_at DESC")
    @nb_to_verify = Association.to_verify.size
    @asso_incomplete = Association.incomplete.size
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml { render :xml => @associations.to_xml }
      format.csv { send_data @associations.to_csv(:columns => ["nom", "adresse_siegesocial", "code_postal", "ville", "email"]), :type => "text/csv" }
    end
  end
  
  def verify
    @associations = Association.to_verify
    
    respond_to do |format|
      format.html { }
      format.xml { render :xml => @associations.to_xml }
    end
  end
  
  def incomplete
    @associations = Association.incomplete
    
    respond_to do |format|
      format.html {  }
    end
  end
  
  def export_xls_csv
    headers['Content-Type'] = "application/vnd.ms-excel"
    headers['Content-Disposition'] = 'attachment; filename="excel-export.xls"'
    headers['Cache-Control'] = ''
    @associations = Association.find(:all, :order => "nom asc")
    
    respond_to do |format|
      format.xls #{ render :layout => false }
      format.csv { send_data @associations.to_csv(:columns => ["nom", "adresse_siegesocial", "code_postal", "ville", "email"]), :type => "text/csv" }
    end
  end  
  
  def newsletter
    @abonne = Abonne.new(params[:abonne])
    
    respond_to do |format|
      if @abonne.save
        # QuestMailer.deliver_confirm_abonewsletter(@abonne)
        # format.js {}
        format.html { render :action => "accueil" }
      end
    end
    
  end
  
  # GET /associations/1
  # GET /associations/1.xml
  def show
    @association = Association.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @association.to_xml }
    end
  end

  # GET /associations/new
  def new
    @association = Association.new
    @ci = ChampIntervention.new
    @convention = Convention.new
    @conv_co = ""
    @index = 0
  end

  # GET /associations/1;edit
  def edit
    @association = Association.find(params[:id])
    unless @association.champ_interventions.size == 0
      @index = @association.champ_interventions.size
    else
      @index = 0
      @ci = ChampIntervention.new
    end
  end

  # POST /associations
  # POST /associations.xml
  def create
    # uri = session[:original_uri]
    # session[:original_uri] = nil
    @association = Association.new(params[:association])
    if params[:association][:date_creation] = Date.today
      @association.date_creation = nil
    end
    @cis = []
    params[:champ_interventions].each_value do |ci|
        ci.each_value do |c|
           @ci = ChampIntervention.find(c)
           @cis << @ci
        end
     end
    if (params[:association][:convention_id] == "" && !params[:conv_co].blank?)
      @association.create_convention(:nom => params[:conv_co])
    end
       
    respond_to do |format|
      if @association.save
        @association.champ_interventions << @cis
        flash[:notice] = "Enregistrement de l'association réussi."
        # if uri == inscription_associations_path
        #   format.html { redirect_to uri }
        # else
        format.html { redirect_to association_url(@association) }
        format.xml  { head :created, :location => association_url(@association) }
        # end
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @association.errors.to_xml }
      end
    end
  end

  # PUT /associations/1
  # PUT /associations/1.xml
  def update
    @association = Association.find(params[:id])
    # si un Hash de champ d'intervention est transmis
    if params[:champ_interventions]
      # recuperer la valeur de chaque sous-hash de params[:champ_interventions]
      params[:champ_interventions].each_value do |ci|
         ci.each_value do |c|
          # retrouver le champ d'intervention correspondant 
          ci = ChampIntervention.find(c) 
          # l'ajouter au tableau des champ_interventions de l'association s'il n'est pas déjà
          # inclus
          unless @association.champ_interventions.include?(ci)
            @association.champ_interventions << ci
          end
         end
      end
    end
    
    if params[:association][:app_conv] == "0" || params[:association][:est_employeur] == "0"
      params[:association][:convention_id] = nil
    elsif params[:association][:convention_id] == "" && !params[:conv_co].blank?
      @association.create_convention(:nom => params[:conv_co])
    end
    
    respond_to do |format|
      if @association.update_attributes(params[:association])
        flash[:notice] = "Modifications enregistrées avec succès."
        format.html { redirect_to association_url(@association) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @association.errors.to_xml }
      end
    end
  end

  # DELETE /associations/1
  # DELETE /associations/1.xml
  def destroy
    @association = Association.find(params[:id])
    @association.destroy

    respond_to do |format|
      format.html { redirect_to associations_url }
      format.xml  { head :ok }
    end
  end
  
  def add_ci
    @ci = ChampIntervention.new
  end
  
  def remove_ci
    if params[:asso_id] and params[:ci_id]
      @association = Association.find(params[:asso_id])
      @ci = ChampIntervention.find(params[:ci_id])
      AssociationsChampIntervention.find(:first,
        :conditions => {:association_id => @association,
        :champ_intervention_id => @ci}).destroy
    end
  end
  
  # GET /associations/inscription
  # retourne la page d'inscription avec le formulaire d'envoi par mail
  def inscription
    @association = Association.new
    @ci = ChampIntervention.new
    @convention = Convention.new
    @conv_co = ""
    @index = 0
    @questionnaire = Quest.new()
    session[:original_uri] = request.request_uri
    session[:token] = nil
    @token = make_token()
    session[:token] = @token
  end
  
  # GET /associations/download_quest
  # lance le download du questionnaire
  def download_quest
    send_file("#{RAILS_ROOT}/public/questionnaire.doc") 
  end
  
  # POST /associations/envoi_inscription
  # gère l'envoi de la demande d'inscription par email
  def envoi_inscription
    @association = Association.new(params[:association])
    cis = []
    params[:champ_interventions].each_value do |ci|
        ci.each_value do |c|
           @ci = ChampIntervention.find(c)
           cis << @ci
        end
    end
    @association.inscription_cis = cis
    
    if (params[:association][:convention_id] == "" && !params[:conv_co].blank?)
      @association.create_convention(:nom => params[:conv_co])
    end

    respond_to do |format|
      if params[:token].to_i == session[:token].result && @association.save!        
        @association.champ_interventions << cis
        QuestMailer.deliver_sent_inscription(@association)
        flash[:notice] = "Votre inscription a bien été enregistré, elle sera traitée très rapidement. Nous vous invitons à remplir les autres informations concernant votre association en cliquant sur les liens de la colonne de gauche"
        format.html { redirect_to association_path(@association) }
      else
        flash[:notice] = "Vérifiez que vous avez saisis toutes les informations correctement."
        format.html { redirect_to inscription_associations_url() }
      end
    end
  end
  
  def suite_inscription
    @association = Association.find(params[:id])
    
  end
  
  # POST /associations/envoi
  # gère la récupération du questionnaire rempli et son envoi par email à un administrateur
  def envoi
    # récupération des données du formulaire
    @questionnaire = Quest.new(params[:questionnaire]) 
    
    respond_to do |format|
      if @questionnaire.save
        # email = QuestMailer.create_sent(@questionnaire)
        QuestMailer.deliver_sent(@questionnaire)
        flash[:notice] = "Votre questionnaire a bien été envoyé."
        format.html { redirect_to inscription_associations_path() }
        # format.html { render(:text => "<pre>" + email.encoded + "</pre>") }
        # format.xml  { head :created, :location => association_url(@association) }
      else
        format.html { render :action => "inscription" }
        # format.xml  { render :xml => @association.errors.to_xml }
      end
    end      
  end
  
  def accept
    @association = Association.find(params[:id])
    @association.accept!
    redirect_to associations_path
  end
  
  def reject
    @association = Association.find(params[:id])
    @association.reject!
    redirect_to associations_path
  end
  
  def suspend
    @association = Association.find(params[:id])
    @association.suspend!
    redirect_to associations_path
  end
  
  def unsuspend
    @association = Association.find(params[:id])
    @association.unsuspend!
    redirect_to associations_path
  end
  
  # GET /souscription
  # affiche le formulaire de contact pour le service de création de site web
  def form_abonnement
    @status = %w(President Tresorier Secretaire Membre)
  end
  
  # POST /associations/envoi_formabonnement
  # envoi le formulaire d'abonnement
  def envoi_formabonnement
    @contacts = params[:contact]
    
    respond_to do |format|
      unless params[:contact][:accepted] == "0"
        QuestMailer.deliver_sent_formabonnement(@contacts)
        flash[:notice] = "Votre demande d'abonnement a bien été enregistré. Elle sera traitée rapidement et un conseiller entrera très bientôt en contact avec vous."
        if !params[:contact][:email].blank?
          QuestMailer.deliver_confirmation_abo(@contacts)
        end
        format.html { redirect_to new_recherch_path }
      else
        flash[:notice] = "Vous n'avez pas accepté les conditions générales de service"
        format.html {redirect_to demande_abonnement_path}
      end
    end
  end
  
  # GET /associations/test_exception
  # déclenche volontairement une exception (erreur) pour tester l'envoi d'une notification d'erreur
  def test_exception
    puts 3/0
  end
  
  private
  
  def find_ci
    @ci_liste = ChampIntervention.select_array    
  end
  
  def find_conventions
    @conventions = Convention.select_array
  end

  TokenStruct = Struct.new(:operand1, :operand2, :result)

  def make_token
    operand1 = rand(10)
    operand2 = rand(10)
    result = operand1 + operand2
    token = TokenStruct.new(operand1, operand2, result)
  end
end
