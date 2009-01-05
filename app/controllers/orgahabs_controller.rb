class OrgahabsController < ApplicationController
  
  before_filter :find_association
  
  # GET /orgahabs
  # GET /orgahabs.xml
  def index
    @orgahabs = Orgahab.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @orgahabs.to_xml }
    end
  end

  # GET /orgahabs/1
  # GET /orgahabs/1.xml
  def show
    @orgahab = Orgahab.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @orgahab.to_xml }
    end
  end

  # GET /orgahabs/new
  def new
    if @association
      @orgahab = Orgahab.new
      @agrement = Agrement.new
    else
      @orgahab = Orgahab.new
    end
  end

  # GET /orgahabs/1;edit
  def edit
    @orgahab = Orgahab.find(params[:id])
  end

  # POST /orgahabs
  # POST /orgahabs.xml
  def create  
    if @association
      @orgahab = Orgahab.new(params[:orgahab])
      @agrement = Agrement.new(params[:agrement])

      respond_to do |format|
        Orgahab.transaction do 
          @agrement.association = @association
          @agrement.orgahab = @orgahab
          @orgahab.save!
          @agrement.save!
        end
        flash[:notice] = "Orgahab was successfully created."
        format.html { redirect_to association_agrements_url(@association) }
        format.xml { head :created,
          :location => association_orgahab_url(@association, @orgahab) }
      end
    else
        @orgahab = Orgahab.new(params[:orgahab])

        respond_to do |format|
          if @orgahab.save
            flash[:notice] = "Orgahab was successfully created."
            format.html { redirect_to orgahab_url(@orgahab) }
            format.xml { head :created, :location => orgahab_url(@orgahab) }
          else
            format.html { render :action => "new" }
            format.xml { render :xml => @orgahab.errors.to_xml}
          end
        end
    end
  end

  # PUT /orgahabs/1
  # PUT /orgahabs/1.xml
  def update
    @orgahab = Orgahab.find(params[:id])

    respond_to do |format|
      if @orgahab.update_attributes(params[:orgahab])
        flash[:notice] = "L'organisme habilitant a été correctement mis à jour."
        format.html { redirect_to orgahab_url(@orgahab) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @orgahab.errors.to_xml }
      end
    end
  end

  # DELETE /orgahabs/1
  # DELETE /orgahabs/1.xml
  def destroy
    @orgahab = Orgahab.find(params[:id])
    @orgahab.destroy

    respond_to do |format|
      format.html { redirect_to orgahabs_url }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_association
    @association = Association.find(params[:association_id]) if params[:association_id]
  end
end
