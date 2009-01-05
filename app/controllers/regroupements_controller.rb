class RegroupementsController < ApplicationController
  
  before_filter :find_association, :dispositif_list
  
  # GET /regroupements
  # GET /regroupements.xml
  def index
    if @association
      @regroupements = @association.regroupements
    else
      @regroupements = Regroupement.find(:all)
    end

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @regroupements.to_xml }
    end
  end

  # GET /regroupements/1
  # GET /regroupements/1.xml
  def show
    @regroupement = Regroupement.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @regroupement.to_xml }
    end
  end

  # GET /regroupements/new
  def new
    @regroupement = Regroupement.new
    @dispositif = @regroupement.build_dispositif
  end

  # GET /regroupements/1;edit
  def edit
    @regroupement = Regroupement.find(params[:id])
  end

  # POST /regroupements
  # POST /regroupements.xml
  def create
    if @association
      @regroupement = Regroupement.new(params[:regroupement])
      @dispositif = Dispositif.new(params[:dispositif])
      @regroupement.association = @association
      unless @dispositif.nom == ""
        @dispositif.save!
        @regroupement.dispositif = @dispositif
      end    

      respond_to do |format|
        if @regroupement.save
          flash[:notice] = 'Dispositif enregistré pour cette association.'
          format.html { redirect_to association_regroupement_url(@association, 
            @regroupement) }
          format.xml  { head :created,
             :location => association_regroupement_url(@association, @regroupement) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @regroupement.errors.to_xml }
        end
      end
    else
      @regroupement = Regroupement.new(params[:regroupement])
      
      respond_to do |format|
        if @regroupement.save
          flash[:notice] = 'Dispositif enregistré pour cet association.'
          format.html { redirect_to regroupement_url(@regroupement) }
          format.xml  { head :created, :location => regroupement_url(@regroupement) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @regroupement.errors.to_xml }
        end
      end
    end
  end

  # PUT /regroupements/1
  # PUT /regroupements/1.xml
  def update
    @regroupement = Regroupement.find(params[:id])

    respond_to do |format|
      if @regroupement.update_attributes(params[:regroupement])
        flash[:notice] = 'Modifications enregistrées.'
        format.html { redirect_to association_regroupement_url(@association, @regroupement) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @regroupement.errors.to_xml }
      end
    end
  end

  # DELETE /regroupements/1
  # DELETE /regroupements/1.xml
  def destroy
    @regroupement = Regroupement.find(params[:id])
    @regroupement.destroy

    respond_to do |format|
      format.html { redirect_to association_regroupements_url(@association) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def dispositif_list
    @dispositif_list = Dispositif.select_array()
  end
end
