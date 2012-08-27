# -*- encoding : utf-8 -*-
class ManifestationsController < ApplicationController
  
  before_filter :find_association
  
  # GET /manifestations
  # GET /manifestations.xml
  def index
    if @association
      @manifestations = @association.manifestations
    else
      @manifestations = Manifestation.find(:all)
    end
    
    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @manifestations.to_xml }
    end
  end

  # GET /manifestations/1
  # GET /manifestations/1.xml
  def show
    @manifestation = Manifestation.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @manifestation.to_xml }
    end
  end

  # GET /manifestations/new
  def new
    @manifestation = Manifestation.new
    @manifestation.planning_manifs.build
  end

  # GET /manifestations/1;edit
  def edit
    @manifestation = Manifestation.find(params[:id])
    @manifestation.planning_manifs.delete_all
  end

  # POST /manifestations
  # POST /manifestations.xml
  def create
    if @association
      @manifestation = Manifestation.new(params[:manifestation])
      @manifestation.spectateur = params[:spectateurs].join(", ")
      @manifestation.spectage = params[:spectages].join(", ")
      
      respond_to do |format|
        if @manifestation.save!
          @manifestation.associations << @association
          flash[:notice] = 'Manifestation was successfully created.'
          format.html { redirect_to association_url(@association) }
          format.xml  { head :created,
             :location => association_url(@association) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @manifestation.errors.to_xml }
        end
      end    
      
    else
      @manifestation = Manifestation.new(params[:manifestation])

      respond_to do |format|
        if @manifestation.save
          flash[:notice] = 'Manifestation was successfully created.'
          format.html { redirect_to manifestation_url(@manifestation) }
          format.xml  { head :created, :location => manifestation_url(@manifestation) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @manifestation.errors.to_xml }
        end
      end
   
    end
  end

  # PUT /manifestations/1
  # PUT /manifestations/1.xml
  def update    
    if @association
      # params[:manifestation][:existing_planning_attributes] ||= {}
            
      @manifestation = Manifestation.find(params[:id])

      respond_to do |format|
        if @manifestation.update_attributes(params[:manifestation])
          @manifestation.spectateur = params[:spectateurs].join(", ")
          @manifestation.spectage = params[:spectages].join(", ")
          @manifestation.save
          flash[:notice] = 'Modifications enregistrées pour cette manifestation.'
          format.html { redirect_to association_url(@association) }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @manifestation.errors.to_xml }
        end
      end
    end
  end

  # DELETE /manifestations/1
  # DELETE /manifestations/1.xml
  def destroy
    @manifestation = Manifestation.find(params[:id])
    @manifestation.destroy

    respond_to do |format|
      format.html { redirect_to association_manifestations_url(@association) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  # def find_association
  #   @association = Association.find(params[:association_id]) if params[:association_id]
  # end
end
