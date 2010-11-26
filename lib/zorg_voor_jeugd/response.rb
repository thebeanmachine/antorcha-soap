module ZorgVoorJeugd
 class Response < Struct.new(:response)
     
     def status_code
       response[:status_code]
     end
     
     def status_omschrijving
       response[:status_omschrijving]
     end  
     
     def success?
       status_code == '0'
     end
     def warning?
       !/^(2|27|39)$/.match(status_code).nil?
     end
     def failure?
       not (success? || warning?)
     end
 end
end