class ChampInterventionsController < ApplicationController
  cache_sweeper :cis_sweeper, :only => [:create, :destroy, :update]
  before_filter :find_association
  
  # GET /champ_interventions
  # GET /champ_interventions.xml
  def index
    if @association
      @champ_interventions = @association.champ_interventions
    else
      @champ_interventions = ChampIntervention.find(:all, :order => "nom asc")
    end

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @champ_interventions.to_xml }
    end
  end

  # GET /champ_interventions/1
  # GET /champ_interventions/1.xml
  def show
    @champ_intervention = ChampIntervention.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @champ_intervention.to_xml }
    end
  end

  # GET /champ_interventions/new
  def new
    @champ_intervention = ChampIntervention.new
  end

  # GET /champ_interventions/1;edit
  def edit
    @champ_intervention = ChampIntervention.find(params[:id])
  end

  # POST /champ_interventions
  # POST /champ_interventions.xml
  def create
    if @association
      @champ_intervention = ChampIntervention.new(params[:champ_intervention])
      
      respond_to do |format|
        if @champ_intervention.save
          @champ_intervention.associations << @associations
          flash[:notice] = 'ChampIntervention was successfully created.'
          format.html {
             redirect_to association_champ_intervention_url(@association, @champ_intervention) }
          format.xml  { head :created,
             :location => association_champ_intervention_url(@association, @champ_intervention) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @champ_intervention.errors.to_xml }
        end
      end
    else
      @champ_intervention = ChampIntervention.new(params[:champ_intervention])

      respond_to do |format|
        if @champ_intervention.save
          flash[:notice] = 'ChampIntervention was successfully created.'
          format.html { redirect_to new_champ_intervention_url() }
          format.xml  { head :created, :location => champ_intervention_url(@champ_intervention) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @champ_intervention.errors.to_xml }
        end
      end
    end
  end

  # PUT /champ_interventions/1
  # PUT /champ_interventions/1.xml
  def update
    @champ_intervention = ChampIntervention.find(params[:id])

    respond_to do |format|
      if @champ_intervention.update_attributes(params[:champ_intervention])
        flash[:notice] = 'ChampIntervention was successfully updated.'
        format.html { redirect_to champ_intervention_url(@champ_intervention) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @champ_intervention.errors.to_xml }
      end
    end
  end

  # DELETE /champ_interventions/1
  # DELETE /champ_interventions/1.xml
  def destroy
    @champ_intervention = ChampIntervention.find(params[:id])
    @champ_intervention.destroy

    respond_to do |format|
      format.html { redirect_to champ_interventions_url }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_association
    @association = Association.find(params[:association_id]) if params[:association_id]
  end
end
