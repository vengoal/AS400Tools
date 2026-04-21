/* ** Start of specifications ************************************************/
/*PARMS PGM(STRCLRDRC) ALLOW(*INTERACT *IPGM *IMOD *IREXX)                   */
/*                                                                           */
/* Command name  . . . . . . : STRCLRDR                                      */
/*                                                                           */
/* Descriptive name  . . . . : Start CL Reader                               */
/*                                                                           */
/* Function  . . . . . . . . : To interpret a CL source member.              */
/*                                                                           */
/* Copyright:                                                                */
/*   (C) Copyright S.H. Coulter 1987, 2002. All rights reserved.             */
/*   (C) Copyright FlyByNight Software. 1987, 2002. All rights reserved.     */
/*                                                                           */
/* External references:                                                      */
/*   Command processor . . . : STRCLRDRC                                     */
/*                                                                           */
/*   Messages  . . . . . . . :                                               */
/*                                                                           */
/*   Help panel group  . . . :                                               */
/*                                                                           */
/*   Programs  . . . . . . . :                                               */
/*                                                                           */
/*   Files . . . . . . . . . :                                               */
/*                                                                           */
/*   Data areas  . . . . . . :                                               */
/*                                                                           */
/* Notes:                                                                    */
/*   Dependencies  . . . . . :                                               */
/*                                                                           */
/*   Restrictions  . . . . . :                                               */
/*                                                                           */
/*   Support . . . . . . . . : shc@flybynight.com.au                         */
/*                                                                           */
/* Change activity:                                                          */
/*               Rlse &                                                      */
/* Flag Reason   Level  Date   Pgmr       Comments                           */
/* ---- -------- ------ ------ ---------- -----------------------------------*/
/* $A0= D               870228 SHC:       Initial coding of command.         */
/* $A1= D               920107 SHC:       Support both S/38 and AS/400 syntax*/
/* $A2= D               020926 SHC:       Remove dumb defaults and make more */
/*                                          like an IBM command.             */
/*                                                                           */
/* ** End of specifications **************************************************/

 STRCLRDR:   CMD        PROMPT('Start CL Reader')

             PARM       KWD(SRCFILE) TYPE(Q1) MIN(1) PROMPT('Source +
                          file')

             PARM       KWD(SRCMBR) TYPE(*NAME) LEN(10) MIN(1) +
                          EXPR(*YES) PROMPT('Member')

 Q1:         QUAL       TYPE(*NAME) LEN(10) MIN(1) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB *CURLIB)) +
                          EXPR(*YES) PROMPT('Library')
