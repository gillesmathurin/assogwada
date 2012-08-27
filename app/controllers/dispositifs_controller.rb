# -*- encoding : utf-8 -*-
class DispositifsController < ApplicationController
  
  before_filter :find_association, :dispositif_list
  
  # GET /dispositifs
  # GET /dispositifs.xml
  def index
    if @association
      @dispositifs = @association.dispositifs
    else
      @dispositifs = Dispositif.find(:all)
    end

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @dispositifs.to_xml }
    end
  end

  # GET /dispositifs/1
  # GET /dispositifs/1.xml
  def show
    @dispositif = Dispositif.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @dispositif.to_xml }
    end
  end

  # GET /dispositifs/new
  def new
    @dispositif = Dispositif.new
  end

  # GET /dispositifs/1;edit
  def edit
    @dispositif = Dispositif.find(params[:id])
  end

  # POST /dispositifs
  # POST /dispositifs.xml
  def create
    if @association
        @dispositif = Dispositif.new(params[:dispositif])
      
      respond_to do |format|
        if @dispositif.save
          @dispositif.associations << @association
          flash[:notice] = 'Le dispositif a été correctement ajouté à cette association'
          format.html { redirect_to association_dispositif_url(@association,@dispositif) }
          format.xml  { head :created, :location => dispositif_url(@dispositif) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @dispositif.errors.to_xml }
        end
      end
    else  
      @dispositif = Dispositif.new(params[:dispositif])

      respond_to do |format|
        if @dispositif.save
          flash[:notice] = 'Enregistrement du dispositif effectué.'
          format.html { redirect_to dispositif_url(@dispositif) }
          format.xml  { head :created, :location => dispositif_url(@dispositif) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @dispositif.errors.to_xml }
        end
      end
    end
  end

  # PUT /dispositifs/1
  # PUT /dispositifs/1.xml
  def update
    @dispositif = Dispositif.find(params[:id])

    respond_to do |format|
      if @dispositif.update_attributes(params[:dispositif])
        flash[:notice] = 'Dispositif was successfully updated.'
        format.html { redirect_to dispositif_url(@dispositif) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @dispositif.errors.to_xml }
      end
    end
  end

  # DELETE /dispositifs/1
  # DELETE /dispositifs/1.xml
  def destroy
    @dispositif = Dispositif.find(params[:id])
    @dispositif.destroy

    respond_to do |format|
      format.html { redirect_to dispositifs_url }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_association
    @association = Association.find(params[:association_id]) if params[:association_id]
  end
  
  def dispositif_list
    @dispositif_list = Dispositif.select_array()
  end
end
