/*===============================================================*/ 
/* To compile:                                                   */ 
/*                                                               */ 
/* CRTCMD CMD(XXX/WRKSAVFOBJ) PGM(XXX/SAV001CL) +                */ 
/* SRCFILE(XXX/QCMDSRC)                                          */ 
/*                                                               */ 
/*===============================================================*/ 
CMD PROMPT('Work with Save File Objects') 

PARM KWD(SAVF) TYPE(QUAL) MIN(1) PROMPT('Save file') 

PARM KWD(OBJ) TYPE(*GENERIC) DFT(*ALL) + 
       SPCVAL((*ALL)) PROMPT('Object') 

PARM KWD(OBJTYP)                                + 
       TYPE(*CHAR)                              +
       LEN(10)                                  +
       RSTD(*YES)                               + 
       DFT(*ALL)                                +
       VALUES(*ALRTBL *BNDDIR *CFGL             + 
      *CHTFMT *CLD *CLS *CMD *CRQD *CSI *CSPMAP + 
       *CSPTBL *DTAARA *DTAQ *EDTD *EXITRG *FCT + 
       *FILE *FNTRSC *FORMDF *FTR *GSS *JOBD    + 
       *JOBQ *JOBSCD *JRN *JRNRCV *MENU *MODULE + 
       *MSGF *MSGQ *NODL *OUTQ *OVL *PAGDFN     + 
       *PAGSEG *PDG *PGM *PNLGRP *PRDAVL *PRDDFN + 
       *PRDLOD *QMFORM *QMQRY *QRYDFN *RCT *SBSD + 
       *SCHIDX *SPADCT *SQLPKG *SRVPGM *SSND    + 
       *SVRSTG *S36 *TBL *USRIDX *USRQ *USRSPC  + 
       *WSCST)                                  + 
       SPCVAL((*ALL))                           +
       PROMPT('Object type') 

QUAL: QUAL TYPE(*NAME)                          + 
           LEN(10) 

      QUAL TYPE(*NAME)                          +
           LEN(10)                              +
           DFT(*LIBL)                           +
           SPCVAL((*LIBL))                      +
           PROMPT('Library') 
