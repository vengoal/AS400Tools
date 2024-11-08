<h4>WRKLPR - The Work with LPR Utility</h4><pre>
by Robin Klima<br />
September, 1996
Copyright 1996, Midrange Computing
</pre>
<a href="https://archive.midrange.com/midrange-l/201002/msg01264.html">https://archive.midrange.com/midrange-l/201002/msg01264.html</a>

<pre>
Figure 1: The Work with LPR Screen
Figure 2: Sending a Spooled File with LPR

Figure 3: The Work with LPR Command
/*===============================================================*/
/* To compile: */
/* */
/* CRTCMD CMD(XXX/WRKLPR) PGM(XXX/LPR001CL) + */
/* SRCFILE(XXX/QCMDSRC) */
/* */
/*===============================================================*/
CMD PROMPT('Work with LPR')
PARM KWD(USER) TYPE(*NAME) DFT(*CURRENT) +
SPCVAL((*CURRENT) (*ALL)) PROMPT('User')
Figure 4: CL Program LPR001CL
/*==================================================================*/
/* To compile: */
/* */
/* CRTCLPGM PGM(XXX/LRP001CL) SRCFILE(XXX/QCLSRC) */
/* */
/*==================================================================*/
PGM PARM(&USER)
DCL VAR(&USER) TYPE(*CHAR) LEN(10)
DCL VAR(&MSGID) TYPE(*CHAR) LEN(7)
DCL VAR(&MSGDTA) TYPE(*CHAR) LEN(80)
/* Send all errors to error handling routine */
MONMSG MSGID(CPF0000) EXEC(GOTO CMDLBL(ERROR))
/* Don't allow this command to be run recursively */
SNDPGMMSG MSG(' ') TOPGMQ(*SAME (LPR001RG))
MONMSG MSGID(CPF2469) EXEC(DO)
RMVMSG CLEAR(*ALL)
GOTO CMDLBL(CONTINUE)
ENDDO
RCVMSG PGMQ(*SAME (LPR001RG)) RMV(*YES)
SNDPGMMSG MSGID(CPF9898) MSGF(QCPFMSG) MSGDTA('Command +
WRKLPR already in use within this job') +
MSGTYPE(*ESCAPE)
/*Check to besure user exists */
CONTINUE: IF COND(%SST(&USER 1 1) *NE '*') THEN(DO)
CHKOBJ OBJ(&USER) OBJTYPE(*USRPRF)
MONMSG MSGID(CPF9801) EXEC(SNDPGMMSG MSGID(CPF33D1) +
MSGF(QCPFMSG) MSGDTA(&USER) MSGTYPE(*ESCAPE))
ENDDO
/* Create user space if necessary */
CHKOBJ OBJ(QTEMP/LPR001US) OBJTYPE(*USRSPC)
MONMSG MSGID(CPF9801) EXEC(CALL PGM(QUSCRTUS) +
PARM('LPR001US QTEMP' '' X'00010000' '' +
'*ALL' ''))
/* Call program to display spooled files */
CALL PGM(LPR001RG) PARM(&USER)
GOTO CMDLBL(ENDPGM)
/* Error handling routine */
ERROR: RCVMSG MSGTYPE(*EXCP) MSGDTA(&MSGDTA) MSGID(&MSGID)
SNDPGMMSG MSGID(&MSGID) MSGF(QCPFMSG) MSGDTA(&MSGDTA) +
MSGTYPE(*ESCAPE)
ENDPGM: ENDPGM
Figure 5: Panel Group LPR001PG
.*===================================================================*
.* To compile: *
.* *
.* CRTPNLGRP PNLGRP(XXX/LPR001PG) SRCFILE(XXX/QPNLSRC) *
.* *
.*===================================================================*
:PNLGRP.
.*====================================================================
.* Class Definitions
.*====================================================================
:CLASS NAME=optcls BASETYPE=action.
:ECLASS.
:CLASS NAME=namcls BASETYPE='OBJNAME 10'.
:ECLASS.
:CLASS NAME=splcls BASETYPE='CHAR 4'.
:ECLASS.
:CLASS NAME=jobcls BASETYPE='CHAR 6'.
:ECLASS.
:CLASS NAME=prmcls BASETYPE='CHAR 255'.
:ECLASS.
.*====================================================================
.* Variable Definitions
.*====================================================================
:VAR NAME=user CLASS=namcls.
:VAR NAME=opt CLASS=optcls.
:VAR NAME=splnam CLASS=namcls.
:VAR NAME=splnum CLASS=splcls.
:VAR NAME=jobnam CLASS=namcls.
:VAR NAME=usrnam CLASS=namcls.
:VAR NAME=jobnum CLASS=jobcls.
:VAR NAME=prm CLASS=prmcls.
.*====================================================================
.* Variable Record and List Definitions
.*====================================================================
:VARRCD NAME=detail VARS='opt splnam splnum jobnam usrnam jobnum'
NOGET='splnam splnum jobnam usrnam jobnum'.
:LISTDEF NAME=detlst VARS='opt splnam splnum jobnam usrnam jobnum'
MSGID=CPI3307 MSGF='QCPFMSG'.
.*====================================================================
.* Key Definitions
.*====================================================================
:KEYL NAME=fkeys.
:KEYI KEY=enter HELP=hlp ACTION=enter.
:KEYI KEY=help HELP=hlp ACTION=help.
:KEYI KEY=F1 HELP=hlp ACTION=help.
:KEYI KEY=F3 HELP=hlp ACTION=exit VARUPD=no .F3=Exit
:KEYI KEY=F4 HELP=hlp ACTION=prompt .F4=Prompt
:KEYI KEY=F5 HELP=hlp ACTION='return 5' .F5=Refresh
:KEYI KEY=F9 HELP=hlp ACTION=retrieve .F9=Retrieve
:KEYI KEY=F12 HELP=hlp ACTION=cancel VARUPD=no .F12=Cancel
:KEYI KEY=pagedown HELP=hlp ACTION=pagedown.
:KEYI KEY=pageup HELP=hlp ACTION=pageup.
:KEYI KEY=print HELP=hlp ACTION=print.
:EKEYL.
.*====================================================================
.* Panel Definition
.*====================================================================
:PANEL NAME=LPR001PG KEYL=fkeys HELP=hlp TOPSEP=sysnam ENTER=return
.Work with LPR
:LIST DEPTH=18 LISTDEF=detlst MAXHEAD=2 ACTOR=uim PARMS=prm.
:TOPINST .Type options, press Enter.
:LISTACT ENTER='CMD LPR FILE(&splnam.)'
ENTER='JOB(&jobnum./&usrnam./&jobnam.)'
ENTER='SPLNBR(&splnum.) &prm.'
PROMPT='CMD ?LPR ?*FILE(&splnam.)'
PROMPT='?*JOB(&jobnum./&usrnam./&jobnam.)'
PROMPT='?*SPLNBR(&splnum.) &prm'
HELP=hlp OPTION=1 NOCMD=prompt .1=Send using LPR
:LISTACT ENTER='CMD DSPSPLF FILE(&splnam.)'
ENTER='JOB(&jobnum./&usrnam./&jobnam.)'
ENTER='SPLNBR(&splnum.) &prm.'
PROMPT='CMD ?DSPSPLF ?*FILE(&splnam.)'
PROMPT='?*JOB(&jobnum./&usrnam./&jobnam.) ?*SPLNBR(&splnum.)'
PROMPT='&prm.' HELP=hlp OPTION=5 .5=Display
:LISTCOL VAR=opt USAGE=inout MAXWIDTH=3 HELP=hlp .Opt
:LISTGRP COL=splgrp HELP=hlp .Spooled File
:LISTCOL VAR=splnam USAGE=out MAXWIDTH=10 .Name
:LISTCOL VAR=splnum USAGE=out MAXWIDTH=8 .Number
:ELISTGRP.
:LISTGRP COL=jobgrp HELP=hlp .Job
:LISTCOL VAR=jobnam USAGE=out MAXWIDTH=10 .Name
:LISTCOL VAR=usrnam USAGE=out MAXWIDTH=10 .User
:LISTCOL VAR=jobnum USAGE=out MAXWIDTH=6 .Number
:ELISTGRP.
:LISTVIEW COLS='opt splgrp jobgrp'.
:ELIST.
:CMDLINE SIZE=short .Parameters or command
:EPANEL.
.*====================================================================
.* Help Module
.*====================================================================
:HELP NAME=hlp.
:EHELP.
:EPNLGRP.
Figure 6: RPG IV Program LPR001RG
*===============================================================
* To compile:
*
* CRTBNDRPG PGM(XXX/LPR001RG) SRCFILE(XXX/QRPGSRC)
*
*===============================================================
D UserSpace S 20 Inz('LPR001US QTEMP')
D PanelGroup S 20 Inz('LPR001PG *LIBL')
D Keys S 9B 0 Dim(5)
D Fields S 9B 0 Inz(5)
D StartPos S 9B 0 Inz(1)
D EntryLen S 9B 0 Inz(140)
D AppScope S 9B 0
D ExitParm S 9B 0
D BufferLen S 9B 0
D ErrorCode S 9B 0
D Fkey S 9B 0
D F5 C Const(5)
D Option S 4
D GenHeader DS
D OffSet 125 128B 0
D Entries 133 136B 0
D EntrySize 137 140B 0
D SplfInfo DS
D SplNam 21 30
D JobNam 49 58
D UsrNam 77 86
D JobNum 105 110
D SplBin 129 132B 0
D SplBuffer DS
D OptionBuf 2B 0
D SplNamBuf 10
D SplNumBuf 4
D JobNamBuf 10
D UsrNamBuf 10
D JobNumBuf 6
D SplNumber DS
D SplZon 4S 0
D SplChr 4 Overlay(SplZon)
*===============================================================
C *Entry Plist
C Parm UserName 10
* Open the panel
C Call 'QUIOPNDA'
C Parm DspHandle 8
C Parm PanelGroup
C Parm -1 AppScope
C Parm ExitParm
C Parm 'N' FullHelp 1
C Parm *Zeros ErrorCode
* Load the keys array
C Do5X30
C Eval Keys(X) = 200 + X
C Enddo
*Do until a keyother than F5 is pressed
C Dou Fkey <> F5
* List the spooled files
C Call 'QUSLSPL'
C Parm UserSpace
C Parm 'SPLF0200' FormatName 8
C Parm UserName
C Parm '*ALL' OutqName 20
C Parm '*ALL' FormType 10
C Parm '*ALL' UserData 10
C Parm *Zeros ErrorCode
C Parm *Blanks JobName 26
C Parm Keys
C Parm Fields
* Retrieve the generic header
C Call 'QUSRTVUS'
C Parm UserSpace
C Parm 1 StartPos
C Parm 140 EntryLen
C Parm GenHeader
C Eval StartPos = OffSet + 1
C Eval EntryLen = EntrySize
C Eval Option = 'FRST'
* Repeate for the number of entries in the list
C Do Entries
* Retrieve a list entry
C Call 'QUSRTVUS'
C Parm UserSpace
C Parm StartPos
C Parm EntryLen
C Parm SplfInfo
* Load the list fields
C Eval OptionBuf = *Zero
C Eval SplNamBuf = SplNam
C Eval SplZon = SplBin
C Eval SplNumBuf = SplChr
C Eval JobNamBuf = JobNam
C Eval UsrNamBuf = UsrNam
C Eval JobNumBuf = JobNum
*Add a list entrytothe panel
C Call 'QUIADDLE'
C Parm DspHandle
C Parm SplBuffer
C Parm 42 BufferLen
C Parm 'DETAIL' RecordName 10
C Parm 'DETLST' ListName 10
C Parm Option
C Parm ListHandle 4
C Parm *Zeros ErrorCode
C Eval Option = 'NEXT'
C Eval StartPos = StartPos + EntrySize
C Enddo
* Display the panel
C Call 'QUIDSPP'
C Parm DspHandle
C Parm Fkey
C Parm 'LPR001PG' PanelName 10
C Parm 'N' Redisplay 1
C Parm *Zeros ErrorCode
* Delete the list
C If Fkey = F5 and Entries 0
C Call 'QUIDLTL'
C Parm DspHandle
C Parm 'DETLST' ListName
C Parm *Zeros ErrorCode
C Endif
C Enddo
* Close the panel
C Call 'QUICLOA'
C Parm DspHandle
C Parm 'M' CloseOptn 1
C Parm *Zeros ErrorCode
C Eval *InLR = *On
</pre>
