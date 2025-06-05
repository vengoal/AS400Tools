/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Compile options:                                                 */
/*                                                                   */
/*    CrtCmd Cmd( CHKMQM )                                           */
/*           Pgm( CHKMQM )                                           */
/*           SrcMbr( CHKMQM )                                        */
/*           Allow( *IPGM *BPGM )                                    */
/*                                                                   */
/*-------------------------------------------------------------------*/
          Cmd      Prompt( 'Check MQ Queue Manager')

          Parm     Kwd(MQMNAME) Type(*CHAR) Len(48) Min(1) +
                   Prompt('Message Queue Manager name')

          Parm     Kwd(RC) Type(*CHAR) Len(10)  +
                   RtnVal(*Yes)                 +
                   Prompt('Return code')
