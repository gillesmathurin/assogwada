class NewslettersController < ApplicationController
  
  before_filter :login_required
  
  # def deliver
  #   call_rake(:send_newsletter, :newsletter_id => params[:id].to_i)
  #   flash[:notice] = "En cours d'envoi"
  #   redirect_to newsletters_url
  # end
  
  def deliver
    @newsletter = Newsletter.find(params[:id])
    @newsletter.send_later(:deliver)
    flash[:notice] = "Newsletter en cours d'envoi …"
    redirect_to(newsletters_url)
  end
  
  def desabonnement
  end
  
  def delete_abonne
    @abonne = Abonne.find_by_email_abonne(params[:email])
    respond_to do |format|
      if !@abonne.nil?
        @abonne.destroy
        flash[:notice] = "Vous n'êtes plus abonnés à la lettre d'information"
        format.html { redirect_to desabonnement_newsletters_url }
      else
        flash[:notice] = "Cette adresse email n'existe pas dans notre base"
        format.html { redirect_to desabonnement_newsletters_url }
      end
    end
  end
  
  # GET /newsletters
  # GET /newsletters.xml
  def index
    @newsletters = Newsletter.paginate(:page => params[:page], :per_page => 20,
     :order => "created_at DESC, date_pub DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @newsletters }
    end
  end

  # GET /newsletters/1
  # GET /newsletters/1.xml
  def show
    @newsletter = Newsletter.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @newsletter }
    end
  end

  # GET /newsletters/new
  # GET /newsletters/new.xml
  def new
    @newsletter = Newsletter.new
    @contenu_nls = []
    2.times { @contenu_nls << NlContent.new }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @newsletter }
    end
  end

  # GET /newsletters/1/edit
  def edit
    @newsletter = Newsletter.find(params[:id])
    @contenu_nls = @newsletter.nl_contents
  end

  # POST /newsletters
  # POST /newsletters.xml
  def create
    @newsletter = Newsletter.new(params[:newsletter])

    respond_to do |format|
      if @newsletter.save
        flash[:notice] = 'Newsletter créée avec succès.'
        format.html { redirect_to(@newsletter) }
        format.xml  { render :xml => @newsletter, :status => :created, :location => @newsletter }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @newsletter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /newsletters/1
  # PUT /newsletters/1.xml
  def update
    @newsletter = Newsletter.find(params[:id])

    respond_to do |format|
      if @newsletter.update_attributes(params[:newsletter])
        flash[:notice] = 'Newsletter was successfully updated.'
        format.html { redirect_to(@newsletter) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @newsletter.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /newsletters/1
  # DELETE /newsletters/1.xml
  def destroy
    @newsletter = Newsletter.find(params[:id])
    @newsletter.destroy

    respond_to do |format|
      format.html { redirect_to(newsletters_url) }
      format.xml  { head :ok }
    end
  end
end
