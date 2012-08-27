# -*- encoding : utf-8 -*-
class ConvPlurisController < ApplicationController
  
  before_filter :find_association, :orgahab_list
  
  # GET /conv_pluris
  # GET /conv_pluris.xml
  def index
    if @association
      @conv_pluris = @association.conv_pluris
    else
      @conv_pluris = ConvPluri.find(:all)
    end

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @conv_pluris.to_xml }
    end
  end

  # GET /conv_pluris/1
  # GET /conv_pluris/1.xml
  def show
    @conv_pluri = ConvPluri.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @conv_pluri.to_xml }
    end
  end

  # GET /conv_pluris/new
  def new
    @conv_pluri = ConvPluri.new
    @orgahab = Orgahab.new
  end

  # GET /conv_pluris/1;edit
  def edit
    @conv_pluri = ConvPluri.find(params[:id])
    @orgahab = Orgahab.new
  end

  # POST /conv_pluris
  # POST /conv_pluris.xml
  def create
    begin
      @conv_pluri = ConvPluri.new(params[:conv_pluri])
      @orgahab = Orgahab.new(params[:orgahab])
    rescue Exception => e
      flash[:notice] = "#{e}"
    else
      @conv_pluri.association = @association
      unless @orgahab.nom == ""
        @orgahab.save!
        @conv_pluri.orgahab = @orgahab
      end
    end

    respond_to do |format|
      if @conv_pluri.save
        flash[:notice] = 'La convention pluriannuelle a bien été enregistré.'
        format.html { redirect_to new_association_conv_pluri_url(@association) }
        format.xml  { head :created,
           :location => association_conv_pluri_url(@association,
            @conv_pluri) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @conv_pluri.errors.to_xml }
      end
    end
  end

  # PUT /conv_pluris/1
  # PUT /conv_pluris/1.xml
  def update
    @conv_pluri = ConvPluri.find(params[:id])
    @orgahab = Orgahab.new(params[:orgahab])
    unless @orgahab.nom == ""
      @orgahab.save!
      @conv_pluri.orgahab = @orgahab
    end

    respond_to do |format|
      if @conv_pluri.update_attributes(params[:conv_pluri])
        flash[:notice] = 'La convention pluriannuelle a bien été modifié.'
        format.html { redirect_to association_conv_pluris_url(@conv_pluri.association_id) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @conv_pluri.errors.to_xml }
      end
    end
  end

  # DELETE /conv_pluris/1
  # DELETE /conv_pluris/1.xml
  def destroy
    @conv_pluri = ConvPluri.find(params[:id])
    @conv_pluri.destroy

    respond_to do |format|
      format.html { redirect_to association_conv_pluris_url(@association) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def orgahab_list
    @organisme_list = Orgahab.select_array()
  end
end
