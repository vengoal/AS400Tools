/*********************************************************************/
/* ALL SOFTWARE IS PROVIDED "AS IS" WITHOUT ANY WARRANTY OF ANY      */
/* NATURE WHATSOEVER. THE PROVIDER OF THIS SOFTWARE HEREBY DISCLAIMS */
/* ALL WARRANTIES, REPRESENTATIONS, AND CONDITIONS, STATUATORY OR    */
/* OTHERWISE, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO       */
/* WARRANTY OF TITLE AND THE IMPLIED WARRANTY OF MERCHANTABILITY AND */
/* FITNESS FOR A PARTICULAR PURPOSE. THE PROVIDER SHALL NOT BE       */
/* LIABLE FOR ANY DAMAGES ARISING FROM OR AS A RESULT OF YOUR USE OF */
/* THIS SOFTWARE. USE IT AS YOUR OWN RISK.                           */
/*********************************************************************/
/*-------------------------------------------------------------------*/
             CMD        PROMPT('Dump Journal Data')
/*-------------------------------------------------------------------*/
             PARM       KWD(JRN) TYPE(FILE) MIN(1) PROMPT('Journal')
             PARM       KWD(RCVRNG) TYPE(RCVR) MIN(1) PROMPT('Range +
                          of journal receivers')
 RCVR:       ELEM       TYPE(FILE) SNGVAL((*CURRENT *N) (*CURCHAIN +
                          *N)) MIN(1) PROMPT('Starting journal +
                          receiver')
             ELEM       TYPE(FILE) SNGVAL((*CURRENT *N)) +
                          PROMPT('Ending journal receiver')
/*-------------------------------------------------------------------*/
             PARM       KWD(FILE) TYPE(FILEMBR) MIN(1) +
                         PROMPT('Journaled file')
 FILEMBR:    ELEM       TYPE(FILE) MIN(1)
             ELEM       TYPE(*CHAR) LEN(10) DFT(*ALL) SPCVAL((*FIRST +
                          *N) (*ALL *N)) EXPR(*YES) PROMPT('Member')
/*-------------------------------------------------------------------*/
             PARM       KWD(CVTOUTF) TYPE(FILE) MIN(1) +
                          PROMPT('Converted Output file')
             PARM       KWD(OUTOPT) TYPE(*CHAR) LEN(8) RSTD(*YES) +
                          DFT(*REPLACE) VALUES(*NONE *REPLACE *ADD) +
                          EXPR(*YES) PROMPT('Replace or add records')
/*-------------------------------------------------------------------*/
             PARM       KWD(JRNFILE) TYPE(FILE) DFT(*AUTO) +
                          SNGVAL((*AUTO *N)) PMTCTL(*PMTRQS) +
                          PROMPT('Journaled physical file')
/*-------------------------------------------------------------------*/
 FILE:       QUAL       TYPE(*NAME) LEN(10) MIN(1) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')
/*-------------------------------------------------------------------*/
