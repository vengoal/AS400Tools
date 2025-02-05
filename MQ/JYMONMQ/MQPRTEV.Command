/**************************************************************/                                            
/* MQ - Print Event list                                      */                                            
/*------------------------------------------------------------*/                                            
/* ©BeppeCostagliola - beppecosta@yahoo.it - 2007             */                                            
/**************************************************************/                                            
                                                                                                            
   CMD        PROMPT('Print MQ event')                                                                      
                                                                                                            
   PARM       KWD(MQMNAME) TYPE(*NAME) LEN(26) DFT(*DFT) +                                                  
                SPCVAL((*DFT)) MIN(0) PROMPT('Message +                                                     
                Queue Manager name')                                                                        
                                                                                                            
   PARM       KWD(QNAME) TYPE(*NAME) LEN(26) RSTD(*YES) +                                                   
                DFT(SYSTEM.ADMIN.CHANNEL.EVENT) +                                                           
                VALUES(SYSTEM.ADMIN.CHANNEL.EVENT +                                                         
                SYSTEM.ADMIN.PERFM.EVENT +                                                                  
                SYSTEM.ADMIN.QMGR.EVENT +                                                                   
                SYSTEM.DEAD.LETTER.QUEUE +                                                                  
                SYSTEM.PENDING.DATA.QUEUE) MIN(0) +                                                         
                CHOICE('System Queue Name') PROMPT('Queue +                                                 
                name')                                                                                      
                                                                                                            
   PARM       KWD(CLEARQ) TYPE(*CHAR) LEN(4) RSTD(*YES) +                                                   
                DFT(*NO) VALUES(*YES *NO) MIN(0) +                                                          
                PROMPT('Clear Queue')                                                                       
                                                                                                            
