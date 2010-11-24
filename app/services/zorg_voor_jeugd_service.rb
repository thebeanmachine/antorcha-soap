class ZorgVoorJeugdService < ActionAntorcha::Base
  
  
  def nieuwe_signalering
    signalering = ZorgVoorJeugd.new :postcode => '3800AD', :naam => 'Thorax', :username => 'thebeanmachine'
    response = signalering.create params[:jongere], params[:signalering]
    
    if response.success?
      puts "geweldig het heeft gewerkt."
      reply :gesignaleerd do |msg|
        msg.title = "gesignaleerd!"
        msg.body = response
      end
    elsif response.warning?
      puts "het werkte wel maar het ging niet helemaal goed"
      reply :gesignaleerd_maar do |msg|
        msg.title = "gesignaleerd met een waarschuwing"
        msg.body = "<error><status_code></"
      end
    else
      puts "dikke failure stuur een failure bericht"
      reply :dikke_vette_pech_stap do |msg|
        msg.title = 
        msg.body = "<error><status_code></"
      end
    end

  end
  
  def wijzig_signalering
  end
  
end