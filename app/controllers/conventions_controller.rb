class ConventionsController < ApplicationController
  # GET /conventions
  # GET /conventions.xml
  def index
    @conventions = Convention.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @conventions.to_xml }
    end
  end

  # GET /conventions/1
  # GET /conventions/1.xml
  def show
    @convention = Convention.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @convention.to_xml }
    end
  end

  # GET /conventions/new
  def new
    @convention = Convention.new
  end

  # GET /conventions/1;edit
  def edit
    @convention = Convention.find(params[:id])
  end

  # POST /conventions
  # POST /conventions.xml
  def create
    @convention = Convention.new(params[:convention])

    respond_to do |format|
      if @convention.save
        flash[:notice] = 'Convention was successfully created.'
        format.html { redirect_to convention_url(@convention) }
        format.xml  { head :created, :location => convention_url(@convention) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @convention.errors.to_xml }
      end
    end
  end

  # PUT /conventions/1
  # PUT /conventions/1.xml
  def update
    @convention = Convention.find(params[:id])

    respond_to do |format|
      if @convention.update_attributes(params[:convention])
        flash[:notice] = 'Convention was successfully updated.'
        format.html { redirect_to convention_url(@convention) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @convention.errors.to_xml }
      end
    end
  end

  # DELETE /conventions/1
  # DELETE /conventions/1.xml
  def destroy
    @convention = Convention.find(params[:id])
    @convention.destroy

    respond_to do |format|
      format.html { redirect_to conventions_url }
      format.xml  { head :ok }
    end
  end
end
