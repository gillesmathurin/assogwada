# -*- encoding : utf-8 -*-
class ConseiladminsController < ApplicationController
  
  before_filter :find_association
  
  # GET /conseiladmins
  # GET /conseiladmins.xml
  def index
    @conseiladmins = @association.conseiladmin

    respond_to do |format|
      format.html # index.rhtml
      format.xml  { render :xml => @conseiladmins.to_xml }
    end
  end

  # GET /conseiladmins/1
  # GET /conseiladmins/1.xml
  def show
    @conseiladmin = Conseiladmin.find(params[:id])

    respond_to do |format|
      format.html # show.rhtml
      format.xml  { render :xml => @conseiladmin.to_xml }
    end
  end

  # GET /conseiladmins/new
  def new
    @conseiladmin = Conseiladmin.new
    @president = President.new
    @vice_president = PremierVicepresident.new
    @sec_vp = SecondVicepresident.new
    @secretaire = Secretaire.new
    @secretaire_adjoint = SecretaireAdjoint.new
    @tresorier = Tresorier.new
    @tre_adjoint = TresorierAdjoint.new
    3.times { @conseiladmin.membres.build }
  end

  # GET /conseiladmins/1;edit
  def edit
    @conseiladmin = Conseiladmin.find(params[:id])
    @president = @conseiladmin.president
    @vice_president = @conseiladmin.premier_vicepresident
    @sec_vp = @conseiladmin.second_vicepresident
    @secretaire = @conseiladmin.secretaire
    @secretaire_adjoint = @conseiladmin.secretaire_adjoint
    @tresorier = @conseiladmin.tresorier
    @tre_adjoint = @conseiladmin.tresorier_adjoint
    @membres = @conseiladmin.membres.only_membres
  end

  # POST /conseiladmins
  # POST /conseiladmins.xml
  def create
    @conseiladmin = Conseiladmin.new(params[:conseiladmin])
    @conseiladmin.build_president(params[:president])
    @conseiladmin.build_premier_vicepresident(params[:vice_president])
    @conseiladmin.build_second_vicepresident(params[:sec_vp])
    @conseiladmin.build_secretaire(params[:secretaire])
    @conseiladmin.build_secretaire_adjoint(params[:secretaire_adjoint])
    @conseiladmin.build_tresorier(params[:tresorier])    
    @conseiladmin.build_tresorier_adjoint(params[:tre_adjoint])
    @conseiladmin.association = @association

    respond_to do |format|
      if @conseiladmin.save!
        flash[:notice] = 'Conseiladmin was successfully created.'
        format.html { redirect_to association_conseiladmins_url(@conseiladmin.association) }
        format.xml  { head :created, 
          :location => association_conseiladmin_url(@conseiladmin.association,
                       @conseiladmin) }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @conseiladmin.errors.to_xml }
      end
    end
  end

  # PUT /conseiladmins/1
  # PUT /conseiladmins/1.xml
  def update
    @conseiladmin = Conseiladmin.find(params[:id])
    @conseiladmin.build_president(params[:president])
    @conseiladmin.build_premier_vicepresident(params[:vice_president])
    @conseiladmin.build_second_vicepresident(params[:sec_vp])
    @conseiladmin.build_secretaire(params[:secretaire])
    @conseiladmin.build_secretaire_adjoint(params[:secretaire_adjoint])
    @conseiladmin.build_tresorier(params[:tresorier])    
    @conseiladmin.build_tresorier_adjoint(params[:tre_adjoint])

    respond_to do |format|
      if @conseiladmin.update_attributes(params[:conseiladmin])
        flash[:notice] = 'Conseiladmin was successfully updated.'
        format.html { redirect_to association_conseiladmin_url(@conseiladmin.association,
          @conseiladmin) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @conseiladmin.errors.to_xml }
      end
    end
  end

  # DELETE /conseiladmins/1
  # DELETE /conseiladmins/1.xml
  def destroy
    @conseiladmin = Conseiladmin.find(params[:id])
    @conseiladmin.destroy

    respond_to do |format|
      format.html { redirect_to association_conseiladmins_url(@association) }
      format.xml  { head :ok }
    end
  end
  
  private
  
end
