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
