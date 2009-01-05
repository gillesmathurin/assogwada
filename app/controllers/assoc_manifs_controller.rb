class AssocManifsController < ApplicationController
  
  before_filter :find_association, :find_manifestation
  
  # GET /assoc_manifs
  # GET /assoc_manifs.xml
  def index
    @assoc_manifs = AssocManif.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @assoc_manifs.to_xml }
    end
  end

  # GET /assoc_manifs/1
  # GET /assoc_manifs/1.xml
  def show
    @assoc_manif = AssocManif.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @assoc_manif.to_xml }
    end
  end

  # GET /assoc_manifs/new
  def new
    @assoc_manif = AssocManif.new
  end

  # GET /assoc_manifs/1;edit
  def edit
    @assoc_manif = AssocManif.find(params[:id])
  end

  # POST /assoc_manifs
  # POST /assoc_manifs.xml
  def create
    @assoc_manif = AssocManif.new(:association_id => @association,
                                  :manifestation_id => @manifestation)

    respond_to do |format|
      if @assoc_manif.save
        flash[:notice] = 'AssocManif was successfully created.'
        format.html { redirect_to assoc_manif_url(@assoc_manif) }
        format.xml  { head :created, :location => assoc_manif_url(@assoc_manif) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @assoc_manif.errors.to_xml }
      end
    end
  end

  # PUT /assoc_manifs/1
  # PUT /assoc_manifs/1.xml
  def update
    @assoc_manif = AssocManif.find(params[:id])

    respond_to do |format|
      if @assoc_manif.update_attributes(params[:assoc_manif])
        flash[:notice] = 'AssocManif was successfully updated.'
        format.html { redirect_to assoc_manif_url(@assoc_manif) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @assoc_manif.errors.to_xml }
      end
    end
  end

  # DELETE /assoc_manifs/1
  # DELETE /assoc_manifs/1.xml
  def destroy
    @assoc_manif = AssocManif.find(params[:id])
    @assoc_manif.destroy

    respond_to do |format|
      format.html { redirect_to assoc_manifs_url }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_association
    @association = Association.find(params[:association_id])
  end
  
  def find_manifestation
    @manifestation = Manifestation.find(params[:manifestation_id])
  end
end
