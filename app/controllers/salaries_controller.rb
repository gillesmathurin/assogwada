class SalariesController < ApplicationController
  
  before_filter :find_association
  
  # GET /salaries
  # GET /salaries.xml
  def index
    @salaries = @association.salaries

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @salaries.to_xml }
    end
  end

  # GET /salaries/1
  # GET /salaries/1.xml
  def show
    @salarie = Salarie.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @salarie.to_xml }
    end
  end

  # GET /salaries/new
  def new
    @salarie = Salarie.new
  end

  # GET /salaries/1;edit
  def edit
    @salarie = Salarie.find(params[:id])
  end

  # POST /salaries
  # POST /salaries.xml
  def create
    @salarie = Salarie.new(params[:salarie])
    @salarie.association = @association # Association.find(params[:association_id])

    respond_to do |format|
      if @salarie.save
        flash[:notice] = 'Enregistrement du nouveau salarié réussi.'
        format.html { redirect_to new_association_salarie_url(@salarie.association) }
        format.xml  { head :created, 
          :location => association_salarie_url(@salarie.association, @salarie) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @salarie.errors.to_xml }
      end
    end
  end

  # PUT /salaries/1
  # PUT /salaries/1.xml
  def update
    @salarie = Salarie.find(params[:id])

    respond_to do |format|
      if @salarie.update_attributes(params[:salarie])
        flash[:notice] = 'Modifications apportées au salarié enregistrées.'
        format.html { redirect_to association_salarie_url(@association, @salarie) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @salarie.errors.to_xml }
      end
    end
  end

  # DELETE /salaries/1
  # DELETE /salaries/1.xml
  def destroy
    @salarie = Salarie.find(params[:id])
    @salarie.destroy

    respond_to do |format|
      format.html { redirect_to association_salaries_url(@association) }
      format.xml  { head :ok }
    end
  end
  
  private
  
  def find_association
    @association = Association.find(params[:association_id])
  end
end
