class AgrementsController < ApplicationController
  
  before_filter :find_association, :find_orgahab
  
  # GET /agrements
  # GET /agrements.xml
  def index
    if @association
      @agrements = @association.agrements
    else
      @agrements = Agrement.find(:all)
    end

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @agrements.to_xml }
    end
  end

  # GET /agrements/1
  # GET /agrements/1.xml
  def show
    @agrement = Agrement.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @agrement.to_xml }
    end
  end

  # GET /agrements/new
  def new
    @agrement = Agrement.new
    @orgahab = Orgahab.new
  end

  # GET /agrements/1;edit
  def edit
    @agrement = Agrement.find(params[:id])
    @orgahab = Orgahab.new()
  end

  # POST /agrements
  # POST /agrements.xml
  def create
      begin
        @agrement = Agrement.new(params[:agrement])
        @orgahab = Orgahab.new(params[:orgahab])
      rescue Exception => e
        flash[:notice] = "#{e}"
      else
        @agrement.association = @association
        unless @orgahab.nom == ""
          @orgahab.save!
          @agrement.orgahab = @orgahab
        end
      end
      
      respond_to do |format|
        if @agrement.save!
          flash[:notice] = 'Agrement enregistré avec succès.'
          format.html { 
            redirect_to new_association_agrement_url(@agrement.association_id) }
          format.xml  { head :created, 
            :location => association_agrement_url(@agrement.association_id,
              @agrement) }
        else
          format.html { render :action => "new" }
          format.xml  { render :xml => @agrement.errors.to_xml }
        end
      end
  end

  # PUT /agrements/1
  # PUT /agrements/1.xml
  def update
    @agrement = Agrement.find(params[:id])
    @orgahab = Orgahab.new(params[:orgahab])
    unless @orgahab.nom == ""
      @orgahab.save!
      @agrement.orgahab = @orgahab
    end

    respond_to do |format|
      if @agrement.update_attributes(params[:agrement])
        flash[:notice] = 'Agrement was successfully updated.'
        format.html { redirect_to association_agrement_url(@agrement.association_id,
          @agrement) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @agrement.errors.to_xml }
      end
    end
  end

  # DELETE /agrements/1
  # DELETE /agrements/1.xml
  def destroy
    @agrement = Agrement.find(params[:id])
    @agrement.destroy

    respond_to do |format|
      format.html { redirect_to association_agrements_url(@association) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_association
    @association = Association.find(params[:association_id])
  end
  
  def find_orgahab
    @organisme_list = Orgahab.select_array    
  end
end
