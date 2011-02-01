class ZorgVoorJeugdAliasesController < ApplicationController
  # GET /zorg_voor_jeugd_aliases
  # GET /zorg_voor_jeugd_aliases.xml
  def index
    a = Antorcha.instance
    @zorg_voor_jeugd_aliases = ZorgVoorJeugdAlias.all if a and ZorgVoorJeugdAlias.first.organization
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @zorg_voor_jeugd_aliases }
    end
  end

  # GET /zorg_voor_jeugd_aliases/1
  # GET /zorg_voor_jeugd_aliases/1.xml
  def show
    @zorg_voor_jeugd_alias = ZorgVoorJeugdAlias.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @zorg_voor_jeugd_alias }
    end
  end

  # GET /zorg_voor_jeugd_aliases/new
  # GET /zorg_voor_jeugd_aliases/new.xml
  def new
    @zorg_voor_jeugd_alias = ZorgVoorJeugdAlias.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @zorg_voor_jeugd_alias }
    end
  end

  # GET /zorg_voor_jeugd_aliases/1/edit
  def edit
    @zorg_voor_jeugd_alias = ZorgVoorJeugdAlias.find(params[:id])
  end

  # POST /zorg_voor_jeugd_aliases
  # POST /zorg_voor_jeugd_aliases.xml
  def create
    @zorg_voor_jeugd_alias = ZorgVoorJeugdAlias.new(params[:zorg_voor_jeugd_alias])

    respond_to do |format|
      if @zorg_voor_jeugd_alias.save
        format.html { redirect_to(@zorg_voor_jeugd_alias, :notice => "De Zorg voor Jeugd-alias voor de Antorcha-gebruiker #{@zorg_voor_jeugd_alias.organization_username} is aangemaakt.") }
        format.xml  { render :xml => @zorg_voor_jeugd_alias, :status => :created, :location => @zorg_voor_jeugd_alias }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @zorg_voor_jeugd_alias.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /zorg_voor_jeugd_aliases/1
  # PUT /zorg_voor_jeugd_aliases/1.xml
  def update
    @zorg_voor_jeugd_alias = ZorgVoorJeugdAlias.find(params[:id])

    respond_to do |format|
      if @zorg_voor_jeugd_alias.update_attributes(params[:zorg_voor_jeugd_alias])
        format.html { redirect_to(@zorg_voor_jeugd_alias, :notice => 'De Zorg voor Jeugd-alias is aangepast.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @zorg_voor_jeugd_alias.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /zorg_voor_jeugd_aliases/1
  # DELETE /zorg_voor_jeugd_aliases/1.xml
  def destroy
    @zorg_voor_jeugd_alias = ZorgVoorJeugdAlias.find(params[:id])
    naam = @zorg_voor_jeugd_alias.organization_username
    @zorg_voor_jeugd_alias.destroy

    respond_to do |format|
      format.html { redirect_to(zorg_voor_jeugd_aliases_url, :notice => "De Zorg voor Jeugd-alias voor #{naam} is verwijderd.") }
      format.xml  { head :ok }
    end
  end
end
