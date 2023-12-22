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
             CMD        PROMPT('Convert Journal Data')
/*-------------------------------------------------------------------*/
             PARM       KWD(DSPJRNOUTF) TYPE(FILE) MIN(1) +
                          PROMPT('DSPJRN Output file')
             PARM       KWD(CVTOUTF) TYPE(FILE) MIN(1) +
                          PROMPT('Converted Output file')
             PARM       KWD(OUTOPT) TYPE(*CHAR) LEN(8) RSTD(*YES) +
                          DFT(*NONE) VALUES(*NONE *REPLACE *ADD) +
                          EXPR(*YES) PROMPT('Replace or add records')
             PARM       KWD(JRNFILE) TYPE(FILE) DFT(*AUTO) +
                          SNGVAL((*AUTO *N)) PMTCTL(*PMTRQS) +
                          PROMPT('Journaled physical file')
 FILE:       QUAL       TYPE(*NAME) LEN(10) MIN(1) EXPR(*YES)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL) (*CURLIB)) EXPR(*YES) +
                          PROMPT('Library')
/*-------------------------------------------------------------------*/
