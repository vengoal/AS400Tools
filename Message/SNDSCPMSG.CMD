/*           CRTCMD     CMD(mylib/SNDSCPMSG) +                     */
/*                      PGM(QSYS/QMHSNDSM) +                       */
/*                      SRCFILE(mylib/mysrc) +                     */
/*                      SRCMBR(SNDSCPMSG)  +                       */
/*                      ALLOW( +                                   */
/*                        *IREXX +                                 */
/*                        *BREXX +                                 */
/*                        *BPGM +                                  */
/*                        *IPGM)                                   */
                                                                     
             Cmd        Prompt('Send Scope Message')                 
                                                                     
             Parm       Kwd( Type ) +                                
                        Type( *Char ) +                              
                        Len( 10 ) +                                  
                        Rstd(*YES)    +                              
                        Values( *EXT *PGM *CSE ) +                   
                        Prompt( 'Type' )                             
                                                                     
             PARM       KWD(ExtPgm) +                                 
                        TYPE( Q0001 ) +                               
                        Min( 1 )                                     +
                        Prompt( 'Exit program' )                      
                                                                      
             PARM       KWD( Data ) +                                 
                        TYPE(*Char) +                                 
                        Len( 10 )   +                                 
                        Min( 1 )    +                                 
                        Prompt( 'Exit data' )                         
                                                                      
             PARM       KWD( DataLen ) +                              
                        TYPE(*INT4) +                                 
                        CONSTANT(10)                                  
                                                                      
             PARM       KWD( MSGKey ) +                               
                        TYPE( *CHAR ) +                               
                        LEN( 4 ) +                                    
                        CONSTANT('    ')                              
                                                                      
             PARM       KWD(ERRCOD) +                                 
                        TYPE(*INT4) +                                 
                        CONSTANT(0)                                   
                                                                      
 Q0001:      Qual                     *Name     10                   +
                        Min( 1 )                                     +
                        Expr( *YES )                                  
                                                                      
             Qual                     *NAME     10                   +
                        Dft( *CURLIB )                               +
                        SpcVal(( *CURLIB ))                          +
                        Expr( *YES )                                 +
                        Prompt( 'Library' )                           
