/*           CRTCMD     CMD(MYLIB/SNDDTAQE) +                      */
/*                      PGM(QSYS/QSNDDTAQ) +                       */
/*                      SRCFILE(MYLIB/MYSRCF) +                    */
/*                      SRCMBR(SNDDTAQE)                           */
                                                                      
             CMD        PROMPT('SEND DTAQ ENTRY')                     
             PARM       KWD(SNDQ) +                                   
                        TYPE(*NAME) +                                 
                        LEN(10) +                                     
                        MIN(1) +                                      
                        PROMPT('DTAQ TO SEND TO')                     
              PARM       KWD(SNDQLIB) +                               
                         TYPE(*NAME) +                                
                         LEN(10) +                                    
                         DFT(*LIBL) +                                 
                         SPCVAL( +                                    
                           (*LIBL ) +                                  
                           (*CURLIB )) +                               
                         PROMPT('DTAQ LIBRARY')                        
              PARM       KWD(SNDQFLDLEN) +                             
                         TYPE(*DEC) +                                  
                         LEN(5 0) +                                    
                         PROMPT('ENTRY LENGTH')                        
              PARM       KWD(SNDQFLD) +                                
                         TYPE(*CHAR) +                                 
                         LEN(5000) +                                   
                         EXPR(*YES) +                                  
                         PROMPT('ENTRY VARIABLE')                                     
