# -*- encoding : utf-8 -*-
class AssociationsChampInterventionsController < ApplicationController
  # GET /associations_champ_interventions
  # GET /associations_champ_interventions.xml
  def index
    @associations_champ_interventions = AssociationsChampIntervention.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @associations_champ_interventions.to_xml }
    end
  end

  # GET /associations_champ_interventions/1
  # GET /associations_champ_interventions/1.xml
  def show
    @associations_champ_intervention = AssociationsChampIntervention.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @associations_champ_intervention.to_xml }
    end
  end

  # GET /associations_champ_interventions/new
  def new
    @associations_champ_intervention = AssociationsChampIntervention.new
  end

  # GET /associations_champ_interventions/1;edit
  def edit
    @associations_champ_intervention = AssociationsChampIntervention.find(params[:id])
  end

  # POST /associations_champ_interventions
  # POST /associations_champ_interventions.xml
  def create
    @associations_champ_intervention = AssociationsChampIntervention.new(params[:associations_champ_intervention])

    respond_to do |format|
      if @associations_champ_intervention.save
        flash[:notice] = 'AssociationsChampIntervention was successfully created.'
        format.html { redirect_to associations_champ_intervention_url(@associations_champ_intervention) }
        format.xml  { head :created, :location => associations_champ_intervention_url(@associations_champ_intervention) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @associations_champ_intervention.errors.to_xml }
      end
    end
  end

  # PUT /associations_champ_interventions/1
  # PUT /associations_champ_interventions/1.xml
  def update
    @associations_champ_intervention = AssociationsChampIntervention.find(params[:id])

    respond_to do |format|
      if @associations_champ_intervention.update_attributes(params[:associations_champ_intervention])
        flash[:notice] = 'AssociationsChampIntervention was successfully updated.'
        format.html { redirect_to associations_champ_intervention_url(@associations_champ_intervention) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @associations_champ_intervention.errors.to_xml }
      end
    end
  end

  # DELETE /associations_champ_interventions/1
  # DELETE /associations_champ_interventions/1.xml
  def destroy
    @associations_champ_intervention = AssociationsChampIntervention.find(params[:id])
    @associations_champ_intervention.destroy

    respond_to do |format|
      format.html { redirect_to associations_champ_interventions_url }
      format.xml  { head :ok }
    end
  end
end
