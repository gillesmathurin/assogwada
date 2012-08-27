# -*- encoding : utf-8 -*-
class LocalsController < ApplicationController
  
  before_filter :find_association, :load_enumeration_data
  
  # GET /locals
  # GET /locals.xml
  def index
    if @association
      @locals = @association.locals
    else
      @locals = Local.find(:all)
    end

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @locals.to_xml }
    end
  end

  # GET /locals/1
  # GET /locals/1.xml
  def show
    @local = Local.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @local.to_xml }
    end
  end

  # GET /locals/new
  def new
    @local = Local.new
    @inter_plannings = []
    2.times { 
      @inter_planning = InterPlanning.new(:stime_mat => "", :etime_mat => "", :lundi => 0,
       :mardi => 0, :mercredi => 0, :jeudi => 0, :vendredi => 0, :samedi => 0,
        :dimanche => 0, :stime_apm => "", :etime_apm => "")
      @inter_plannings << @inter_planning
     }
  end

  # GET /locals/1;edit
  def edit
    @local = Local.find(params[:id])
  end

  # POST /locals
  # POST /locals.xml
  def create
    @local = Local.new(params[:local])
    @local.association = @association

    respond_to do |format|
      if @local.save
        flash[:notice] = 'Enregistrement des données relatives au local réussi.'
        format.html { redirect_to new_association_local_url(@association) }
        format.xml  { head :created,
           :location => association_local_url(@association, @local) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @local.errors.to_xml }
      end
    end
  end

  # PUT /locals/1
  # PUT /locals/1.xml
  def update
    @local = Local.find(params[:id])

    respond_to do |format|
      if @local.update_attributes(params[:local])
        flash[:notice] = 'Données sur local mis à jour avec succès.'
        format.html { redirect_to association_locals_url(@association) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @local.errors.to_xml }
      end
    end
  end

  # DELETE /locals/1
  # DELETE /locals/1.xml
  def destroy
    @local = Local.find(params[:id])
    @local.destroy

    respond_to do |format|
      format.html { redirect_to association_locals_url(@association) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_association
    @association = Association.find(params[:association_id]) if params[:association_id]
  end
  
  def load_enumeration_data
    @jours = InterPlanning::DAYS 
  end
end
