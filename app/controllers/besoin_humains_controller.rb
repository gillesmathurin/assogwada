# -*- encoding : utf-8 -*-
class BesoinHumainsController < ApplicationController
  
  before_filter :find_association
  
  # GET /besoin_humains
  # GET /besoin_humains.xml
  def index
    @besoin_humains = @association.besoin_humains

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @besoin_humains.to_xml }
    end
  end

  # GET /besoin_humains/1
  # GET /besoin_humains/1.xml
  def show
    @besoin_humain = BesoinHumain.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @besoin_humain.to_xml }
    end
  end

  # GET /besoin_humains/new
  def new
    @besoin_humain = BesoinHumain.new
  end

  # GET /besoin_humains/1;edit
  def edit
    @besoin_humain = BesoinHumain.find(params[:id])
  end

  # POST /besoin_humains
  # POST /besoin_humains.xml
  def create
    @besoin_humain = BesoinHumain.new(params[:besoin_humain])
    @besoin_humain.association = @association

    respond_to do |format|
      if @besoin_humain.save!
        flash[:notice] = 'Ce besoin en ressource humaine à bien été enregistré.'
        format.html { redirect_to new_association_besoin_humain_url(@association) }
        format.xml  { head :created, 
          :location => association_besoin_humain_url(@association, @besoin_humain) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @besoin_humain.errors.to_xml }
      end
    end
  end

  # PUT /besoin_humains/1
  # PUT /besoin_humains/1.xml
  def update
    @besoin_humain = BesoinHumain.find(params[:id])

    respond_to do |format|
      if @besoin_humain.update_attributes(params[:besoin_humain])
        flash[:notice] = 'Ce besoin en ressource humaine a bien été mis à jour.'
        format.html { redirect_to association_besoin_humain_url(@association, @besoin_humain) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @besoin_humain.errors.to_xml }
      end
    end
  end

  # DELETE /besoin_humains/1
  # DELETE /besoin_humains/1.xml
  def destroy
    @besoin_humain = BesoinHumain.find(params[:id])
    @besoin_humain.destroy

    respond_to do |format|
      format.html { redirect_to association_besoin_humains_url(@association) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_association
    @association = Association.find(params[:association_id])
  end
end
