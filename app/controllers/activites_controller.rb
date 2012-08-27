# -*- encoding : utf-8 -*-
class ActivitesController < ApplicationController
  
  before_filter :find_association, :load_enumeration_data
  
  # GET /activites
  # GET /activites.xml
  def index
    @activites = @association.activites

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @activites.to_xml }
    end
  end

  # GET /activites/1
  # GET /activites/1.xml
  def show
    @activite = Activite.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @activite.to_xml }
    end
  end

  # GET /activites/new
  def new
    @activite = Activite.new
    @inter_plannings = []
    2.times { 
      @inter_planning = InterPlanning.new(:stime_mat => "", :etime_mat => "",
       :stime_apm => "", :etime_apm => "", :lundi => 0, :mardi => 0,
        :mercredi => 0, :jeudi => 0, :vendredi => 0, :samedi => 0, :dimanche => 0)
      @inter_plannings << @inter_planning
     }
     # breakpoint
  end

  # GET /activites/1;edit
  def edit
    @activite = Activite.find(params[:id])
  end

  # POST /activites
  # POST /activites.xml
  def create
    if @association
      @activite = Activite.new(params[:activite])
      @activite.spectateur = params[:spectateurs].join(", ")
      @activite.spectage = params[:spectages].join(", ")
      @activite.association = @association

      respond_to do |format|
        if @activite.save!
          flash[:notice] = "Enregistrement de l'activité réussi."
          format.html { redirect_to association_activite_url(@association, @activite) }
          format.xml  { head :created,
             :location => association_activite_url(@association,@activite) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @activite.errors.to_xml }
        end
      end
    end
  end

  # PUT /activites/1
  # PUT /activites/1.xml
  def update
    @activite = Activite.find(params[:id])

    respond_to do |format|
      if @activite.update_attributes(params[:activite])
        @activite.spectateur = params[:spectateurs].join(", ")
        @activite.spectage = params[:spectages].join(", ")
        @activite.save
        flash[:notice] = "Modifications des données sur l'activité enregistrées."
        format.html { redirect_to association_activite_url(@association, @activite) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @activite.errors.to_xml }
      end
    end
  end

  # DELETE /activites/1
  # DELETE /activites/1.xml
  def destroy
    @activite = Activite.find(params[:id])
    @activite.destroy

    respond_to do |format|
      format.html { redirect_to association_activites_url(@association) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_association
    @association = Association.find(params[:association_id])
  end
  
  def load_enumeration_data
    @jours = InterPlanning::DAYS
  end
end
