# -*- encoding : utf-8 -*-
class AdhesionsController < ApplicationController
  # GET /adhesions
  # GET /adhesions.xml
  def index
    @adhesions = Adhesion.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @adhesions.to_xml }
    end
  end

  # GET /adhesions/1
  # GET /adhesions/1.xml
  def show
    @adhesion = Adhesion.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @adhesion.to_xml }
    end
  end

  # GET /adhesions/new
  def new
    @adhesion = Adhesion.new
  end

  # GET /adhesions/1;edit
  def edit
    @adhesion = Adhesion.find(params[:id])
  end

  # POST /adhesions
  # POST /adhesions.xml
  def create
    @adhesion = Adhesion.new(params[:adhesion])

    respond_to do |format|
      if @adhesion.save
        flash[:notice] = 'Adhesion was successfully created.'
        format.html { redirect_to adhesion_url(@adhesion) }
        format.xml  { head :created, :location => adhesion_url(@adhesion) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @adhesion.errors.to_xml }
      end
    end
  end

  # PUT /adhesions/1
  # PUT /adhesions/1.xml
  def update
    @adhesion = Adhesion.find(params[:id])

    respond_to do |format|
      if @adhesion.update_attributes(params[:adhesion])
        flash[:notice] = 'Adhesion was successfully updated.'
        format.html { redirect_to adhesion_url(@adhesion) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @adhesion.errors.to_xml }
      end
    end
  end

  # DELETE /adhesions/1
  # DELETE /adhesions/1.xml
  def destroy
    @adhesion = Adhesion.find(params[:id])
    @adhesion.destroy

    respond_to do |format|
      format.html { redirect_to adhesions_url }
      format.xml  { head :ok }
    end
  end
end
