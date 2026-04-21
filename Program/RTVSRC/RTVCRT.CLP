/* ***************************************************************** */
/* PROGRAM      RtvCrt                                               */
/* ~~~~~~~                                                           */
/* FUNCTION     Retrieve ILE Source Code utility creator.            */
/* ~~~~~~~~                                                          */
/* APPLICATION  Retrieve ILE Source Code.                            */
/* ~~~~~~~~~~~                                                       */
/* SPECIAL ATTR *None                                                */
/* ~~~~~~~~~~~~                                                      */
/* AUTHOR       Chris Stead                        DATE : 31/1/97    */
/* ~~~~~~                                          ~~~~              */
/* COPYRIGHT (c) 1997 Chris Stead, All rights reserved.              */
/* ***************************************************************** */
             PGM        PARM(&OBJLIB &SRCLIB)

             DCL        VAR(&OBJLIB) TYPE(*CHAR) LEN(10)
             DCL        VAR(&SRCLIB) TYPE(*CHAR) LEN(10)

             CRTCLMOD   MODULE(&OBJLIB/RTVSRCL) +
                          SRCFILE(&SRCLIB/QCLSRC)

             CRTSRCPF   FILE(QTEMP/QSOURCE) RCDLEN(240)
             MONMSG     MSGID(CPF5813 CPF7302)
             CRTRPGMOD  MODULE(&OBJLIB/RTVSRC1) +
                          SRCFILE(&SRCLIB/QRPGLESRC)
             CRTRPGMOD  MODULE(&OBJLIB/RTVSRC2) +
                          SRCFILE(&SRCLIB/QRPGLESRC)
             CRTRPGMOD  MODULE(&OBJLIB/RTVSRC3) +
                          SRCFILE(&SRCLIB/QRPGLESRC)

             CRTPGM     PGM(&OBJLIB/RTVSRC) +
                          MODULE(&OBJLIB/RTVSRCL +
                          &OBJLIB/RTVSRC1 &OBJLIB/RTVSRC2 +
                          &OBJLIB/RTVSRC3) +
                          ENTMOD(&OBJLIB/RTVSRCL) +
                      BNDSRVPGM(QTEDBGS) ACTGRP(*CALLER) +
                          DETAIL(*EXTENDED)

             CRTPNLGRP  PNLGRP(&OBJLIB/RTVSRCP) +
                          SRCFILE(&SRCLIB/QPNLSRC)

             CRTCMD     CMD(&OBJLIB/RTVSRC) PGM(RTVSRC) +
                          SRCFILE(&SRCLIB/QCMDSRC) +
                          HLPPNLGRP(RTVSRCP) HLPID(RTVSRC)

             CRTMSGF    MSGF(&OBJLIB/RTVSRC)
             ADDMSGD    MSGID(RTV0001) MSGF(&OBJLIB/RTVSRC) MSG('No +
                          modules available for source code retrieval')

             ENDPGM
   --------------------------------------------------------------------
