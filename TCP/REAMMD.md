<h4>RTVTCPSTS - Retrieve TCP Status</h4>
<code>
                       Retrieve TCP/TP Status (RTVTCPSTS)                      
                                                                               
 Type choices, press Enter.                                                    
                                                                               
 TCP/IP status  . . . . . . . . .                 Character value              
 Limit mode . . . . . . . . . . .                 Character value              
 Last start date  . . . . . . . .                 Character value              
 Last start time  . . . . . . . .                 Character value              
 Last End date  . . . . . . . . .                 Character value              
 Last End date  . . . . . . . . .                 Character value              
 Last started job . . . . . . . .                 Character value              
 Last started job user  . . . . .                 Character value              
 Last started job number  . . . .                 Character value              
 Last ended job . . . . . . . . .                 Character value              
 Last ended job user  . . . . . .                 Character value              
 Last ended job number  . . . . .                 Character value              
                                                                               
</code>
<h4>CHKTCPIFC - Check TCP Interface</h4>
<code>
                    Check TCP/IP Interface Status (CHKTCPIFC)                  
                                                                               
 Type choices, press Enter.                                                    
                                                                               
 Network interface address  . . . NETIFC                                       
                                                                               

</code>
<code>
<p>CHKTCPIFC Usage:</p>
<code>
PGM                                                                             
                                                                                
             DCL        VAR(&NETIFC) TYPE(*CHAR) LEN(15)                        
                                                                                
             CHGVAR     VAR(&NETIFC) VALUE('172.16.15.27')                      
             CHKTCPIFC  NETIFC(&NETIFC)                                         
             MONMSG CPF9898 EXEC(DO)                                            
             SNDPGMMSG  MSG('Interface' *BCAT &NETIFC *BCAT 'is not +           
                          active or defined')                                   
             ENDDO                                                              
                                                                                                                                                                
ENDPGM                                                                          
</code>
</code>
