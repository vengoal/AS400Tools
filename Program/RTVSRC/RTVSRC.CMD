/* ***************************************************************** */
/* COMMAND      RtvSrc                                               */
/* ~~~~~~                                                            */
/* FUNCTION     Retrieve ILE Source Code.                            */
/* ~~~~~~~~                                                          */
/* APPLICATION  Retrieve ILE Source Code.                            */
/* ~~~~~~~~~~~                                                       */
/* SPECIAL ATTR *None                                                */
/* ~~~~~~~~~~~~                                                      */
/* AUTHOR       Chris Stead                        DATE : 31/1/97    */
/* ~~~~~~                                          ~~~~              */
/* COPYRIGHT (c) 1997 Chris Stead, All rights reserved.              */
/* ***************************************************************** */
             CMD        PROMPT('Retrieve ILE Source Code')

             PARM       KWD(OBJECT) TYPE(QUAL1) MIN(1) PROMPT('Object')
             PARM       KWD(OBJTYPE) TYPE(*CHAR) LEN(10) RSTD(*YES) +
                          DFT(*ANY) SPCVAL((*ANY) (*PGM) (*SRVPGM)) +
                          PROMPT('Object type')
             PARM       KWD(MODULE) TYPE(*NAME) LEN(10) DFT(*SELECT) +
                          SPCVAL((*SELECT) (*OBJECT)) PROMPT('Module')

 PMTCTL:     PMTCTL     CTL(MODULE) COND((*NE *SELECT))

             PARM       KWD(SRCFILE) TYPE(QUAL2) PMTCTL(PMTCTL) +
                          PROMPT('Source file')
             PARM       KWD(SRCMBR) TYPE(*NAME) LEN(10) DFT(*MODULE) +
                          SPCVAL((*MODULE)) PMTCTL(PMTCTL) +
                          PROMPT('Member')

 QUAL1:      QUAL       TYPE(*NAME) LEN(10) MIN(1)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) PROMPT('Library')

 QUAL2:      QUAL       TYPE(*NAME) LEN(10) DFT(QRPGLESRC)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) PROMPT('Library')
