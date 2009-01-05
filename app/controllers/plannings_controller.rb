class PlanningsController < ApplicationController
  # GET /plannings
  # GET /plannings.xml
  def index
    @plannings = Planning.find(:all)

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @plannings.to_xml }
    end
  end

  # GET /plannings/1
  # GET /plannings/1.xml
  def show
    @planning = Planning.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @planning.to_xml }
    end
  end

  # GET /plannings/new
  def new
    @planning = Planning.new
  end

  # GET /plannings/1;edit
  def edit
    @planning = Planning.find(params[:id])
  end

  # POST /plannings
  # POST /plannings.xml
  def create
    @planning = Planning.new(params[:planning])

    respond_to do |format|
      if @planning.save
        flash[:notice] = 'Planning was successfully created.'
        format.html { redirect_to planning_url(@planning) }
        format.xml  { head :created, :location => planning_url(@planning) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @planning.errors.to_xml }
      end
    end
  end

  # PUT /plannings/1
  # PUT /plannings/1.xml
  def update
    @planning = Planning.find(params[:id])

    respond_to do |format|
      if @planning.update_attributes(params[:planning])
        flash[:notice] = 'Planning was successfully updated.'
        format.html { redirect_to planning_url(@planning) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @planning.errors.to_xml }
      end
    end
  end

  # DELETE /plannings/1
  # DELETE /plannings/1.xml
  def destroy
    @planning = Planning.find(params[:id])
    @planning.destroy

    respond_to do |format|
      format.html { redirect_to plannings_url }
      format.xml  { head :ok }
    end
  end
end
