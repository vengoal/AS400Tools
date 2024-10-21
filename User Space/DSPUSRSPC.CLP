/*-------------------------------------------------------------------*/
/*                                                                   */
/*  Program . . : DSPUSRSPC                                          */
/*  Description : Display User Space Contents                        */
/*  Author  . . : Vengoal Chang                                      */
/*  Published . : AS400ePapar                                        */
/*  Date  . . . : October  21, 2024                                  */
/*                                                                   */
/*  Program function:  DSPUSRSPC  command processing program         */
/*                                                                   */
/*  Compile options:                                                 */
/*    CrtClPgm   Pgm( DSPUSRSPC )                                    */
/*               SrcFile( QCLSRC )                                   */
/*               SrcMbr( *PGM )                                      */
/*                                                                   */
/*-------------------------------------------------------------------*/
Pgm  ( &QualUsrSpc )

             Dcl        &QualUsrSpc       *Char       20

             Dcl        &UsrSpc     Type(*CHAR) Stg(*DEFINED) +
                          Len(10) DefVar( &QualUsrSpc  1 )
             Dcl        &UsrSpcLib  Type(*CHAR) Stg(*DEFINED) +
                          Len(10) DefVar( &QualUsrSpc 11 )
             Dcl        &Path             *Char       64

/* Global MONMSG...                                                          */
             MonMsg     MsgID(CPF0000 CPF9999) Exec( Goto Error )

             ChkObj     Obj( &UsrSpcLib/&UsrSpc )             +
                         ObjType( *USRSPC )

             ChgVar     &Path                                 +
                      ( '/QSYS.LIB/' *Cat                     +
                        &UsrSpcLib   *Tcat  '.LIB/'  *CAT         +
                        &UsrSpc      *Tcat  '.USRSPC' )
             DspF       Stmf( &Path )


             Return

/* --------------------------------------------------------------- */

 Error:      MovDiagMsg
             MonMsg     MsgID(CPF0000 MCH0000)
             RsnEscMsg
             MonMsg     MsgID(CPF0000 MCH0000)

 EndPgm
