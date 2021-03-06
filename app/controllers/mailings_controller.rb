class MailingsController < ApplicationController
  
  before_filter :login_required
  
  # GET /mailings
  # GET /mailings.xml
  def index
    @mailings = Mailing.paginate(:page => params[:page], :per_page => 20,
     :order => "created_at DESC")

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @mailings }
    end
  end

  # GET /mailings/1
  # GET /mailings/1.xml
  def show
    @mailing = Mailing.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @mailing }
    end
  end

  # GET /mailings/new
  # GET /mailings/new.xml
  def new
    @mailing = Mailing.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @mailing }
    end
  end
  
  # GET /mailings/1/edit
  def edit
    @mailing = Mailing.find(params[:id])
  end

  # POST /mailings
  # POST /mailings.xml
  def create
    @mailing = Mailing.new(params[:mailing])
    resultats = []
 
    if session[:resultats].nil?
      associations = Association.find(:all, :select => "id, nom, permalink")
      associations.each do |association|
        resultats << association.id
      end
    else
      session[:resultats].each do |id_nom|
        resultats << id_nom[0]
      end
    end
    
    respond_to do |format|
      if @mailing.save
        @mailing.send_later(:deliver)
        flash[:notice] = "Mailing en cours d'envoi …"
         session[:resultats] = nil
        format.html { redirect_to(mailings_url) }
        format.xml  { render :xml => @mailing, :status => :created, :location => @mailing }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @mailing.errors, :status => :unprocessable_entity }
      end
    end
  end
  
  def reexpedition
    @mailing = Mailing.find(params[:id])
    call_rake(:send_mailing, :mailing_id => @mailing.id.to_i)
    
    respond_to do |format|
      flash[:notice] = "Mailing en cours d'envoi …"
      format.html { redirect_to mailings_url }
    end
  end
  
  # PUT /mailings/1
  # PUT /mailings/1.xml
  def update
    @mailing = Mailing.find(params[:id])

    respond_to do |format|
      if @mailing.update_attributes(params[:mailing])
        flash[:notice] = 'Mailing was successfully updated.'
        format.html { redirect_to(@mailing) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @mailing.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /mailings/1
  # DELETE /mailings/1.xml
  def destroy
    @mailing = Mailing.find(params[:id])
    @mailing.destroy

    respond_to do |format|
      format.html { redirect_to(mailings_url) }
      format.xml  { head :ok }
    end
  end
end
