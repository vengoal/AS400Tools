<h4>TCP/IP Management APIs<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/comm8.htm</h4>
<h4>RTVTCPSTS - Retrieve TCP Status</h4>
<ul><li>Retrieve TCP/IP Attributes (QtocRtvTCPA) API<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/qtocrtvtcpa.htm
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
</li></ul>
<h4>CHKTCPIFC - Check TCP Interface</h4>
<ul><li>List Network Interfaces (QtocLstNetIfc) API<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/qtoclstnetifc.htm<code>
                    Check TCP/IP Interface Status (CHKTCPIFC)                  
                                                                               
 Type choices, press Enter.                                                    
                                                                               
 Network interface address  . . . NETIFC                                       
                                                                               

</code>
CHKTCPIFC Usage:
<code>
PGM                                                                             
                                                                                
             DCL        VAR(&NETIFC) TYPE(*CHAR) LEN(15)                        
                                                                                
             CHGVAR     VAR(&NETIFC) VALUE('192.16.18.27')                      
             CHKTCPIFC  NETIFC(&NETIFC)                                         
             MONMSG CPF9898 EXEC(DO)                                            
             SNDPGMMSG  MSG('Interface' *BCAT &NETIFC *BCAT 'is not +           
                          active or defined')                                   
             ENDDO                                                              

ENDPGM                                                                          
</code></li>
</ul>

