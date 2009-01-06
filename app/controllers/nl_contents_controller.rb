class NlContentsController < ApplicationController
  # GET /nl_contents
  # GET /nl_contents.xml
  def index
    @nl_contents = NlContent.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @nl_contents }
    end
  end

  # GET /nl_contents/1
  # GET /nl_contents/1.xml
  def show
    @nl_content = NlContent.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @nl_content }
    end
  end

  # GET /nl_contents/new
  # GET /nl_contents/new.xml
  def new
    @nl_content = NlContent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @nl_content }
    end
  end

  # GET /nl_contents/1/edit
  def edit
    @nl_content = NlContent.find(params[:id])
  end

  # POST /nl_contents
  # POST /nl_contents.xml
  def create
    @nl_content = NlContent.new(params[:nl_content])

    respond_to do |format|
      if @nl_content.save
        flash[:notice] = 'NlContent was successfully created.'
        format.html { redirect_to(@nl_content) }
        format.xml  { render :xml => @nl_content, :status => :created, :location => @nl_content }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @nl_content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /nl_contents/1
  # PUT /nl_contents/1.xml
  def update
    @nl_content = NlContent.find(params[:id])

    respond_to do |format|
      if @nl_content.update_attributes(params[:nl_content])
        flash[:notice] = 'NlContent was successfully updated.'
        format.html { redirect_to(@nl_content) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @nl_content.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /nl_contents/1
  # DELETE /nl_contents/1.xml
  def destroy
    @nl_content = NlContent.find(params[:id])
    @nl_content.destroy

    respond_to do |format|
      format.html { redirect_to(nl_contents_url) }
      format.xml  { head :ok }
    end
  end
end
