/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( ENDJOBQJOB )                                       */
/*           Pgm( ENDJOBQJOB )                                       */
/*           AlwLmtUsr( *NO )                                        */
/*                                                                   */
/*-------------------------------------------------------------------*/
             Cmd        Prompt( 'END Job Queue Jobs' )                 
                                                                       
             Parm       JOBQ        Q0001                            + 
                        Min( 1 )                                     + 
                        Prompt( 'Job queue' )                          
                                                                       
             Parm       Days                                         + 
                        Type( *UInt2 )                               +
                        Dft( 90 )                                    +
                        Prompt( 'Number of days to keep' )            
                                                                      
             Parm       Action                                       +
                        Type( *Char )                                +
                        Len( 10 )                                    +
                        Rstd( *Yes )                                 +
                        Values('*PREVIEW' '*END')                    +
                        Dft( *PREVIEW )                              +
                        Prompt( 'Preview or EndJob' )                 
                                                                      
 Q0001:      Qual                   *Name                            +
                        Expr( *YES )                                  
                                                                      
             Qual                   *Name                            +
                        Dft( *LIBL )                                 +
                        SpcVal(( *LIBL ) ( *CURLIB ))                +
                        Expr( *YES )                                 +
                        Prompt( 'Library' )                           
                                                                      
