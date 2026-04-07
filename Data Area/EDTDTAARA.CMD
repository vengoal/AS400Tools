/*==================================================================*/
/* To compile:                                                      */
/*                                                                  */
/*           CRTCMD     CMD(XXXLIB/EDTDTAARA) PGM(XXXLIB/EDT101RG)  */
/*                                                                  */
/*==================================================================*/

             CMD        PROMPT('Edit Data Area')

             PARM       KWD(DTAARA) TYPE(QUAL) MIN(1) DTAARA(*YES) +
                          PROMPT('Data Area')

 QUAL:       QUAL       TYPE(*NAME) LEN(10)
             QUAL       TYPE(*NAME) LEN(10) DFT(*LIBL) +
                          SPCVAL((*LIBL)) PROMPT('Library')
