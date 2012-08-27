# -*- encoding : utf-8 -*-
class MembresController < ApplicationController
  # GET /membres
  # GET /membres.xml
  def index
    @membres = Membre.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @membres.to_xml }
    end
  end

  # GET /membres/1
  # GET /membres/1.xml
  def show
    @membre = Membre.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @membre.to_xml }
    end
  end

  # GET /membres/new
  def new
    @membre = Membre.new
  end

  # GET /membres/1;edit
  def edit
    @membre = Membre.find(params[:id])
  end

  # POST /membres
  # POST /membres.xml
  def create
    @membre = Membre.new(params[:membre])

    respond_to do |format|
      if @membre.save
        flash[:notice] = 'Enregistrement du nouveau membre réussi.'
        format.html { redirect_to membre_url(@membre) }
        format.xml  { head :created, :location => membre_url(@membre) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @membre.errors.to_xml }
      end
    end
  end

  # PUT /membres/1
  # PUT /membres/1.xml
  def update
    @membre = Membre.find(params[:id])

    respond_to do |format|
      if @membre.update_attributes(params[:membre])
        flash[:notice] = 'Modification du membre enregistré.'
        format.html { redirect_to membre_url(@membre) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @membre.errors.to_xml }
      end
    end
  end

  # DELETE /membres/1
  # DELETE /membres/1.xml
  def destroy
    @membre = Membre.find(params[:id])
    @membre.destroy

    respond_to do |format|
      format.html { redirect_to membres_url }
      format.xml  { head :ok }
    end
  end
end
