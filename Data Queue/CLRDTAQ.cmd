/*  ===============================================================  */
/*  = Command....... ClrDtaq                                      =  */
/*  = CPP........... QSYS/QCLRDTAQ                                =  */
/*  = Description... Clear data queue                             =  */
/*  =                                                             =  */
/*  =                                                             =  */
/*  =        CRTCMD     CMD(MYLIB/CLRDTAQ) +                      =  */
/*  =                   PGM(QSYS/QCLRDTAQ) +                      =  */
/*  =                   SRCFILE(MYLIB/MYSRCF) +                   =  */
/*  =                   SRCMBR(CLRDTAQ)                           =  */
/*  ===============================================================  */
/*  = Date  : 2012/06/10                                          =  */
/*  = Author: Vengoal Chang                                       =  */
/*  ===============================================================  */
               CMD        PROMPT('Clear Data Queue')                   
               PARM       KWD(DTAQ) +                                  
                          TYPE(*NAME) +                                
                          LEN(10) +                                    
                          MIN(1) +                                     
                          PROMPT('Data queue')                         
                                                                       
               PARM       KWD(DTAQLIB) +                               
                          TYPE(*NAME) +                                
                          LEN(10) +                                    
                          DFT(*LIBL) +                                 
                          SPCVAL( +                                    
                          (*LIBL ) +                                   
                          (*CURLIB )) +                                
                          PROMPT('Data quque library')                 
