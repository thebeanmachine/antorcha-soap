# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  rescue_from "AntorchaConfigurationMissing" do
    redirect_to new_antorcha_url, :notice => "Configureer eerst een Antorcha locatie."
  end
  
  rescue_from "ActiveResource::UnauthorizedAccess" do
    redirect_to edit_antorcha_url(Antorcha.instance), :notice => "Er kon geen verbinding gemaakt worden met de Antorcha omdat de opgegeven naam en wachtwoord geen toegang heeft tot het systeem."
  end
  
  rescue_from "ActiveResource::Redirection" do
    redirect_to edit_antorcha_url(Antorcha.instance), :notice => "Er kon geen verbinding gemaakt worden met de Antorcha omdat er geen inloggegevens zijn opgegeven."
  end
  
  rescue_from "Errno::ECONNREFUSED" do
    redirect_to edit_antorcha_url(Antorcha.instance), :notice => "Er kon geen verbinding gemaakt worden met de Antorcha omdat de connectie werd geweigerd."
  end
end
