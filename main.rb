class ADF
  # pega apenas um caracter
  def proximo
    puts "Entre com o próximo estado:"
    gets.chomp 
  end

  def iniciar
    estado = "CLOSED"

    puts "Máquina iniciou no estado: " + estado
    
    loop do
      case [estado, proximo]

      in ["CLOSED", "connect"]
          puts "SYN\n\n"
          estado = "SYN_SENT"
           
      in ["CLOSED", "bind"]
          estado = "LISTEN"
    
      in ["LISTEN", "connect"]
          puts "SYN\n\n"
          estado = "SYN_SENT"
          
      in ["SYN_SENT", "close"]
          estado = "CLOSED"
          
      in ["SYN_SENT", "SYN_ACK"]
          puts "ACK\n\n"
          estado = "ESTABLISHED"
          
      in ["SYN_SENT", "SYN"]
          puts "SYN_ACK\n\n"
          estado = "SYN_RCVD"
          
      in ["SYN_RCVD", "timeout"]
          puts "RST\n\n" 
          estado = "CLOSED"
          
      in ["SYN_RCVD", "RST"]
          estado = "LISTEN"
          
      in ["SYN_RCVD", "ACK"]
          estado = "ESTABLISHED"
          
      in ["SYN_RCVD", "close"]
          puts "FIN\n\n"
          estado = "FIN_WAIT_1"
           
      in ["ESTABLISHED", "FIN"]
          puts "ACK\n\n"
          estado = "CLOSE_WAIT"
          
      in ["ESTABLISHED", "close"]
          puts "FIN\n\n"
          estado = "FIN_WAIT_1"
        
      in ["CLOSE_WAIT_1", "close"]
          puts "FIN\n\n"
          estado = "LAST_ACK"

      in ["LAST_ACK", "ACK"]
          estado = "CLOSED"      
          
      in ["FIN_WAIT_1", "ACK"]
          estado = "FIN_WAIT_2" 

      in ["FIN_WAIT_1", "FIN_ACK"]
          puts "ACK\n\n"
          estado = "TIME_WAIT" 

      in ["FIN_WAIT_1", "FIN"]
          puts "ACK\n\n"
          estado = "CLOSING"    

      in ["FIN_WAIT_2", "FIN"]
          puts "ACK\n\n"
          estado = "TIME_WAIT"

      in ["CLOSING", "ACK"]
          estado = "TIME_WAIT"

      in ["TIME_WAIT", "timeout"]
          estado = "CLOSED"

      in ["CLOSED", "exit"]
          break
          
      in ["CLOSED", ""]
          puts "exit"
          break          
          
      else
        puts "Erro"
        break
    
      end
      puts "Estado: " + estado
    end
  end
end

adf = ADF.new()
adf.iniciar()