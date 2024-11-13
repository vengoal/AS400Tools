/**********************************************************/
/*                                                        */
/*  NAME:   PWDEXITPGM1 - Password validation exit 1      */
/*                                                        */
/*  Validates passwords when *REGFAC is specified for     */
/*  QPWDVLDPGM. Program is registered using the ADDEXITPGM*/
/*  CL command for the QIBM_QSY_VLD_PASSWRD exit point,   */
/*  format VLDP0100.                                      */
/*                                                        */
/*                                                        */
/*  ASSUMPTIONS: If CHGPWD command was used, password     */
/*  CCSID will be job default (assumed to be CCSID 37).   */
/*  If QSYCHGPW API was used, password CCSID will be      */
/*  UNICODE CCSID 13488.                                  */
/**********************************************************/

PGM   PARM(&EXINPUT &RTN)
DCL &EXINPUT    *CHAR 1000  
DCL &RTN        *CHAR 1

DCL &UNAME      *CHAR 10
DCL &NEWPW      *CHAR 256 
DCL &NPOFF      *DEC 5 0
DCL &NPLEN      *DEC 5 0
DCL &INDX       *DEC 5 0
DCL &INDX2      *DEC 5 0
DCL &INDX3      *DEC 5 0
DCL &UNLEN      *DEC 5 0

DCL &XLTCHR2    *CHAR 2 VALUE(X'0000')
DCL &XLTCHR     *DEC 5 0
DCL &XLATEU     *CHAR 255 VALUE('............................... + 
                                !"#$%&''()*+,-./0123456789:;<=>?+ 
                                @ABCDEFGHIJKLMNOPQRSTUVWXYZ[\]^_+ 
                                `ABCDEFGHIJKLMNOPQRSTUVWXYZ{|}~.+ 
                                ................................+ 
                                ................................+ 
                                ................................+ 
                                ...............................')

DCL &XLATEC     *CHAR 255 VALUE('...............................+
                                ................................+
                                ................................+
                                ................................+
                                .ABCDEFGHI.......JKLMNOPQR......+
                                ..STUVWXYZ......................+
                                ................................+
                                ................................')

/*********************************************************************/
/* FORMAT OF EXINPUT IS:                                             */
/*                                                                   */
/* POSITION   DESCRIPTION                                            */
/* 001 - 020  EXIT POINT NAME                                        */
/* 021 - 028  EXIT POINT FORMAT NAME                                 */
/* 029 - 032  PASSWORD LEVEL (binary)                                */
/* 033 - 042  USER PROFILE NAME                                      */
/* 043 - 044  RESERVED                                               */
/* 045 - 048  OFFSET TO OLD PASSWORD (binary)                        */
/* 049 - 052  LENGTH OF OLD PASSWORD (binary)                        */
/* 053 - 056  CCSID OF OLD PASSWORD  (binary)                        */
/* 057 - 060  OFFSET TO NEW PASSWORD (binary)                        */
/* 061 - 064  LENGTH OF NEW PASSWORD (binary)                        */
/* 065 - 068  CCSID OF NEW PASSWORD  (binary)                        */
/* ??? - ???  OLD PASSWORD                                           */
/* ??? - ???  NEW PASSWORD                                           */
/*                                                                   */
/*********************************************************************/


/*********************************************************************/
/*  Establish a generic monitor for the program.                     */
/*********************************************************************/

MONMSG     CPF0000                                                     
/* Assume new password is valid */                                     
CHGVAR &RTN  VALUE('0') /* accept */                                
/* Get new password length, offset and value. Also get user name */    
CHGVAR &NPLEN VALUE(%BIN(&EXINPUT 61 4))                
CHGVAR &NPOFF VALUE(%BIN(&EXINPUT 57 4) + 1)            
CHGVAR &UNAME VALUE(%SST(&EXINPUT 33 10))               
CHGVAR &NEWPW VALUE(%SST(&EXINPUT &NPOFF &NPLEN))       
/* If CCSID is 13488, probably used the QSYCHGPW API which converts */ 
/* the passwords to UNICODE CCSID 13488. So convert to CCSID 37, if */ 
/* possible, else give an error */                                     
IF COND(%BIN(&EXINPUT 65 4) = 13488) THEN(DO)                          
    CHGVAR &INDX2 VALUE(1)                                              
    CHGVAR &INDX3 VALUE(1)
   CVT1:                                                                
    CHGVAR &XLTCHR VALUE(%BIN(&NEWPW &INDX2 2))                         
    IF COND( (&XLTCHR *LT 1) *OR (&XLTCHR *GT 255) ) THEN(DO)           
       CHGVAR &RTN  VALUE('3') /* reject */                              
       SNDPGMMSG MSG('INVALID CHARACTER IN NEW PASSWORD')    
       GOTO DONE                                                 
    ENDDO                                                       
    CHGVAR %SST(&NEWPW &INDX3 1) VALUE(%SST(&XLATEU &XLTCHR 1))
    CHGVAR &INDX2  VALUE(&INDX2 + 2)                            
    CHGVAR &INDX3  VALUE(&INDX3 + 1)                            
    IF COND(&INDX2 *GT &NPLEN) THEN(GOTO ECVT1)                   
    GOTO CVT1                          
   ECVT1:                                                                 
    CHGVAR &NPLEN VALUE(&INDX3 - 1)                                     
    CHGVAR %SST(&EXINPUT 65 4) VALUE(X'00000025')                       
 ENDDO                                                                  

 /* Check the CCSID of the new password value - must be 37     */       
 IF COND(%BIN(&EXINPUT 65 4) *NE 37) THEN(DO)                           
   CHGVAR &RTN  VALUE('3') /* reject */                                 
   SNDPGMMSG MSG('CCSID OF NEW PASSWORD MUST BE 37')                    
   GOTO DONE                                                            
 ENDDO                                                                  
                                                           
 /* UPPERCASE NEW PASSWORD VALUE                      */
 CHGVAR &INDX2 VALUE(1)                                              
 CHGVAR &INDX3 VALUE(1)                                              
 CVT4:                                                               
   CHGVAR %SST(&XLTCHR2 2 1) VALUE(%SST(&NEWPW &INDX2 1))            
   CHGVAR &XLTCHR VALUE(%BIN(&XLTCHR2 1 2))                          
   IF COND( (&XLTCHR *LT 1) *OR (&XLTCHR *GT 255) ) THEN(DO)         
     CHGVAR &RTN  VALUE('3') /* reject */                            
     SNDPGMMSG MSG('INVALID CHARACTER IN NEW PASSWORD')              
     GOTO DONE                                                       
   ENDDO                                                             
   IF COND(%SST(&XLATEC &XLTCHR 1) *NE '.') +                        
   THEN(CHGVAR %SST(&NEWPW &INDX3 1) VALUE(%SST(&XLATEC &XLTCHR 1))) 
   CHGVAR &INDX2  VALUE(&INDX2 + 1)                                  
   CHGVAR &INDX3  VALUE(&INDX3 + 1)                                  
   IF COND(&INDX2 *GT &NPLEN) THEN(GOTO ECVT4)                        
   GOTO CVT4                                                        
 ECVT4:                                                     
                                   
 /* CHECK IF LAST POSITION OF NEW PASSWORD IS NUMERIC */       
 IF COND(%SST(&NEWPW &NPLEN 1) = '0') THEN(GOTO ERROR1) 
 IF COND(%SST(&NEWPW &NPLEN 1) = '1') THEN(GOTO ERROR1) 
 IF COND(%SST(&NEWPW &NPLEN 1) = '2') THEN(GOTO ERROR1) 
 IF COND(%SST(&NEWPW &NPLEN 1) = '3') THEN(GOTO ERROR1) 
 IF COND(%SST(&NEWPW &NPLEN 1) = '4') THEN(GOTO ERROR1) 
 IF COND(%SST(&NEWPW &NPLEN 1) = '5') THEN(GOTO ERROR1) 
 IF COND(%SST(&NEWPW &NPLEN 1) = '6') THEN(GOTO ERROR1) 
 IF COND(%SST(&NEWPW &NPLEN 1) = '7') THEN(GOTO ERROR1) 
 IF COND(%SST(&NEWPW &NPLEN 1) = '8') THEN(GOTO ERROR1) 
 IF COND(%SST(&NEWPW &NPLEN 1) = '9') THEN(GOTO ERROR1) 
                                                          
 /* CHECK IF PASSWORD CONTAINS USER PROFILE NAME        */
 CHGVAR &UNLEN VALUE(1)                                 
 LOOP2:      /* FIND LENGTH OF USER NAME */             
  IF COND(%SST(&UNAME &UNLEN 1) *NE ' ') THEN(DO)       
    CHGVAR &UNLEN VALUE(&UNLEN + 1)                     
    IF COND(&UNLEN = 11) THEN(GOTO ELOOP2)              
    GOTO LOOP2                                          
  ENDDO                                                 
 ELOOP2:                                                
  CHGVAR &UNLEN VALUE(&UNLEN - 1)

                                                               
 /* CHECK FOR USER NAME IN NEW PASSWORD             */
 IF COND(&UNLEN *GT &NPLEN) THEN(GOTO ELOOP3)
 CHGVAR &INDX VALUE(1)
 LOOP3:
   IF COND(%SST(&NEWPW &INDX &UNLEN) = %SST(&UNAME 1 &UNLEN)) + 
      THEN(GOTO ERROR2)
   IF COND((&INDX + &UNLEN + 1) *LT 128) THEN(DO)         
      CHGVAR &INDX VALUE(&INDX + 1)                     
      GOTO LOOP3                                        
   ENDDO                                                
 ELOOP3:                                                

 /* New Password is valid                        */     
 GOTO DONE                                              
                                                                            
 ERROR1:  /* NEW PASSWORD ENDS IN NUMERIC CHARACTER */  
  CHGVAR &RTN  VALUE('3') /* reject */                  
  SNDPGMMSG TOPGMQ(*PRV) MSGTYPE(*ESCAPE) MSGID(PWD0001) MSGF(QSYS/PWDERRORS)  
  GOTO DONE                                             
                                                                            
 ERROR2:  /* NEW PASSWORD CONTAINS USER NAME */         
  CHGVAR &RTN  VALUE('3') /* reject */                  
  SNDPGMMSG TOPGMQ(*PRV) MSGTYPE(*ESCAPE) MSGID(PWD0002) MSGF(QSYS/PWDERRORS) 
  GOTO DONE                                             
                                                                            
 DONE:                                                            
 ENDPGM 

