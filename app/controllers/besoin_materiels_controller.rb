# -*- encoding : utf-8 -*-
class BesoinMaterielsController < ApplicationController
  
  before_filter :find_association
  
  # GET /besoin_materiels
  # GET /besoin_materiels.xml
  def index
    @besoin_materiels = @association.besoin_materiels

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @besoin_materiels.to_xml }
    end
  end

  # GET /besoin_materiels/1
  # GET /besoin_materiels/1.xml
  def show
    @besoin_materiel = BesoinMateriel.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @besoin_materiel.to_xml }
    end
  end

  # GET /besoin_materiels/new
  def new
    @besoin_materiel = BesoinMateriel.new
  end

  # GET /besoin_materiels/1;edit
  def edit
    @besoin_materiel = BesoinMateriel.find(params[:id])
  end

  # POST /besoin_materiels
  # POST /besoin_materiels.xml
  def create
    @besoin_materiel = BesoinMateriel.new(params[:besoin_materiel])
    @besoin_materiel.association = @association

    respond_to do |format|
      if @besoin_materiel.save
        flash[:notice] = 'Ce besoin matériel a  été enregistré correctement.'
        format.html { redirect_to new_association_besoin_materiel_url(@association) }
        format.xml  { head :created, 
          :location => association_besoin_materiel_url(@besoin_materiel.association,
                       @besoin_materiel) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @besoin_materiel.errors.to_xml }
      end
    end
  end

  # PUT /besoin_materiels/1
  # PUT /besoin_materiels/1.xml
  def update
    @besoin_materiel = BesoinMateriel.find(params[:id])

    respond_to do |format|
      if @besoin_materiel.update_attributes(params[:besoin_materiel])
        flash[:notice] = 'Modification du besoin matériel correctement enregistrée.'
        format.html { redirect_to association_besoin_materiel_url(@association, 
          @besoin_materiel) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @besoin_materiel.errors.to_xml }
      end
    end
  end

  # DELETE /besoin_materiels/1
  # DELETE /besoin_materiels/1.xml
  def destroy
    @besoin_materiel = BesoinMateriel.find(params[:id])
    @besoin_materiel.destroy

    respond_to do |format|
      format.html { redirect_to association_besoin_materiels_url(@association) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_association
    @association = Association.find(params[:association_id])
  end
end
