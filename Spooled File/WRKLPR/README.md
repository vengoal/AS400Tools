<h4>WRKLPR - The Work with LPR Utility</h4><pre>
by Robin Klima<br />
September, 1996
Copyright 1996, Midrange Computing
</pre>
<a href="https://archive.midrange.com/midrange-l/201002/msg01264.html">https://archive.midrange.com/midrange-l/201002/msg01264.html</a>
<pre>
In "Avoid SNADS Phobia with LPR and LPD," MC, August 1996, we described some
of the
many benefits of using Line Printer Requester (LPR) to send spooled files
over a TCP/IP
network. This month, I'll present an AS/400 utility that makes LPR even
easier to use. LPR by
itself is a very useful application. You can use LPR to send spooled files
to practically any
system in a TCP/IP network. Then you can either view the spooled file or
print it on the
destination system. The Line Printer Daemon (LPD) is the process on the
destination system that
receives the file sent by LPR.
One problem with LPR on the AS/400 is that there are no "Work with..."
screens that let you
select a spooled file you want to send with LPR. Commands such as Work with
Spooled Files
(WRKSPLF) or Work with Output Queue (WRKOUTQ) present a list of spooled
files, but they
don't offer an option to send the spooled files over a TCP/IP network.
Option 1 (Send) on these
screens runs the Send Net Spooled File (SNDNETSPLF) command, which sends the
spooled file
over a SNADS network.
When you locate a spooled file you want to send with LPR, you usually need
to jot down some
information about it and then prompt the LPR or Send TCP/IP Spooled File
(SNDTCPSPLF)
command and manually fill in the parameters that relate to the spooled file.
It would be much
easier to select a spooled file from a list and let the system enter the
spooled file information for
you. The Work with LPR (WRKLPR) command, presented in this article, lets you
do that. It
shows you a list of spooled files and lets you select one or more of them to
send using LPR.
The WRKLPR utility behaves very much like any other OS/400 "Work with..."
command
because I used the same technique IBM uses extensively throughout OS/400-a
User Interface
Manager (UIM) list panel. UIM list panels provide a consistent interface.
They also inherit
additional functionality and error trapping capabilities from OS/400-without
requiring a lot of
code. This utility provides you with a good example of a UIM list panel. You
can also find more
information in "UIM List Panels," MC, July 1994.

When you prompt WRKLPR, you can enter the name of a user profile in the USER
parameter.
The default, *CURRENT, causes WRKLPR to list only spooled files created by
the user running
the command. You can specify *ALL to list all spooled files on the system.
The WRKLPR command presents you with a list of spooled files, as shown in
Figure 1. This list
looks similar to the one you get when you run the WRKSPLF command. If you're
not sure which
spooled file you want to send, you can use option 5 to view the contents of
the spooled file.
When you find the one you want to send, use option 1 (Send using LPR) to
prompt the OS/400
LPR command, as shown in Figure 2. The name of the spooled file, the fully
qualified job name
that created the spooled file, and the spooled file number parameters are
already filled in for you-unlike
when you prompt LPR from a command line. You still need to enter the Remote
system
(RMTSYS) and Printer queue (PRTQ) parameters, since those are required
parameters on the
LPR command. You also may need to change other optional parameters, such as
Destination
type (DESTTYP) and Transform SCS to ASCII (TRANSFORM), depending on what
type of
system you're sending the spooled file to. (For more information on LPR
parameters, see "Avoid
SNADS Phobia with LPR and LPD," MC, August 1996.)
If you want to process multiple spooled files at once, you can use the
command line at the
bottom of the screen to pass parameters to the LPR command. Passing
parameters on the
command line prevents the utility from prompting you for the LPR parameters
for each spooled
file. The utility applies the parameters to each spooled file selected in
the list. For example, if
you want to send multiple spooled files to the QPRINT output queue on an
AS/400 called
ALPHA, you could select the spooled files with option 1 and type the
following on the command
line:
RMTSYS(ALPHA) PRTQ(QPRINT) +
DESTTYP(*AS400) TRANSFORM(*NO)
The command line also allows you to enter OS/400 commands. You can use F9 to
retrieve
previously entered commands. Other command keys include F4 to prompt a
command and F5 to
refresh the display.
The command definition for the WRKLPR command is shown in Figure 3. The
WRKLPR
command calls CL program LPR001CL, shown in Figure 4, as its command
processing program.
LPR001CL validates the USER parameter passed from the command and then
creates a user
space in QTEMP if necessary. It then calls an RPG program to list the
spooled files.
The panel group LPR001PG, shown in Figure 5 , serves as the interface to the
user. This panel
group is a special type known as a list panel. A list panel is similar to a
subfile. The main
difference is that a UIM list panel can give your applications more
functionality while requiring
even less code.
UIM list panels are made up of a series of tag statements. Each tag
statement begins with a colon
followed by a keyword. In Figure 5, I've grouped the tag statements into
sections and placed
comments at the beginning of each section. The following is a brief
description of each of these
sections.
o Class Definitions-Class definitions define the data types for the
variables used in the list panel.
o Variable Definitions-Each variable used in the list panel references one
of the class definitions

to determine its data type.
o Variable Record and List Definitions-The variable records establish a
buffer between the list
panel and the program that interacts with it.
o Key Definitions-The key definitions determine which function keys are
allowed in the
application and what action is to be taken when those keys are pressed.
o Panel Definition-The panel definition is where you describe which
constants and dialog
variables you want on the panel. This is also where you describe the
commands to run when an
item is selected from the list.
o Help Module-Help modules describe the actions taken when the help key is
pressed, depending
on the location of the cursor.
Together, these sections make up the definition of the list panel. In order
to present this list panel
to a user, a program must perform a series of API calls. The RPG IV program
LPR001RG in
Figure 6 shows how this is accomplished.
In addition to calling APIs to interact with the list panel, the LPR001RG
program also calls APIs
to retrieve information about the spooled files on the system. Here's a
brief description of the
APIs used in this program in the order in which they're called.
o The Open Display Application (QUIOPNDA) API opens the LPR001PG panel
group.
o The List Spooled Files (QUSLSPL) API loads the user space with information
about spooled
files on the system.
o The Retrieve User Space (QUSRTVUS) API is called once to retrieve the
generic header from
the user space, then multiple times to retrieve the spooled file
information.
o The Add List Entry (QUIADDLE) API adds an entry containing information
about a single
spooled file to the list panel.
o The Display Panel (QUIDSPP) API displays the panel and waits for the user
to press F3, F5, or
F12.
o The Delete List (QUIDLTL) API deletes the spooled file information from
the panel if the user
presses F5 so that the information can be refreshed.
o The Close Application (QUICLOA) API closes the UIM panel group.
As I mentioned, one of the best reasons for using UIM is that it does much
of the coding you
would normally have to do for a traditional display file application. This
work takes place in the
call to the Display Panel (QUIDSPP) API (where most of the interaction with
the user takes
place). For example, in the LPR001RG program, there is no need to write code
that would
execute when the user selects an item from the list, presses a page key, or
presses F9. All of this
functionality is built into the UIM panel group and the Display Panel
(QUIDSPP) API.
The WRKLPR utility gives you an easy way to select spooled files you to want
send over a
TCP/IP network. If you want, you can even customize this utility for your
environment. For

example, you can create separate options to send spooled files to specific
systems. Doing this
would eliminate the need for the user to have to fill in any additional LPR
parameters. You might
consider coding separate options for each system that you normally send
spooled files to.
Whether you decide to use this utility as is or customize it for your
environment, I think you'll
find it to be a useful addition to the TCP/IP utilities in OS/400.
Robin Klima is a senior technical editor for Midrange Computing. He can be
reached by E-mail
at klima@xxxxxxxxxx
REFERENCES
OS/400 Application Display Programming V3R1 (SC41-3715, CD-ROM QBKAUK00).
OS/400 System API Reference V3R1 (SC41-3801, CD-ROM QBKAVD00).
</pre>


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
