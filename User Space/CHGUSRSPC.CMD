/*-------------------------------------------------------------------*/
/*                                                                   */
/*  COMPILE OPTIONS:                                                 */
/*                                                                   */
/*    CRTCMD CMD( CHGUSRSPC )                                        */
/*           PGM( QUSCHGUS )                                         */
/*           SRCMBR( CHGUSRSPC )                                     */
/*                                                                   */
/*-------------------------------------------------------------------*/
        CMD        PROMPT( 'Change User Space' )                +
                   ALWLMTUSR( *Yes )                            +
                   AUT( *USE )

        PARM       USRSPC     Q0001                             +
                   MIN( 1 )                                     +
                   PROMPT( 'User space' )

        PARM       STRPOS     *INT4                             +
                   DFT( *START )                                +
                   REL( *GT 0 )                                 +
                   SPCVAL(( *START  1 ))                        +
                   PROMPT( 'Start position' )

        PARM       DTALEN     *INT4                             +
                   DFT( *CALC )                                 +
                   RANGE( 1 5000 )                              +
                   SPCVAL(( *CALC   0 ))                        +
                   PROMPT( 'Data length' )

        PARM       DATA       *CHAR   5000                      +
                   CASE( *MIXED )                               +
                   PROMPT( 'Data' )

        PARM       FORCE      *CHAR      1                      +
                   RSTD( *YES )                                 +
                   DFT( *NO )                                   +
                   SPCVAL(( *NO 0 ) ( *ASYNCH 1 ) ( *SYNCH 2 )) +
                   PROMPT( 'Force to auxillary storage' )

        PARM       ERRORCODE  *CHAR      4                      +
                   CONSTANT( X'00000000' )

Q0001:  QUAL       *NAME      10

        QUAL       *NAME      10                                +
                   DFT( *LIBL )                                 +
                   SPCVAL(( *LIBL ) ( *CURLIB *CURLIB ))        +
                   PROMPT( 'Library' )
