class AntorchasController < ApplicationController
  def index
    if Antorcha.count == 0
      @antorcha = Antorcha.new
    else
      @antorcha = Antorcha.first
    end
  end
  
  def show
    @antorcha = Antorcha.find(params[:id])
  end
  
  def new
    @antorcha = Antorcha.new
  end
  
  def create
    @antorcha = Antorcha.new(params[:antorcha])
    if @antorcha.save
      flash[:notice] = "Successfully created antorcha."
      redirect_to @antorcha
    else
      render :action => 'new'
    end
  end
  
  def edit
    @antorcha = Antorcha.find(params[:id])
  end
  
  def update
    @antorcha = Antorcha.find(params[:id])
    if @antorcha.update_attributes(params[:antorcha])
      flash[:notice] = "Successfully updated antorcha."
      redirect_to @antorcha
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @antorcha = Antorcha.find(params[:id])
    @antorcha.destroy
    flash[:notice] = "Successfully destroyed antorcha."
    redirect_to antorchas_url
  end
end
