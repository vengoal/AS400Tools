Thank you for using DMPJRN and CVJRNDTA.

To install these tools on your IBM i (V5R3M0 and later only):

- CRTSAVF QGPL/DMPJRN
- STRTCPSVR *FTP (if not already started)
- On your PC
	- Unzip this zip file to C:\DMPJRN
	- Open a command prompt
	- ftp xxx.xxx.xx.xxx - enter user name & password
	- quote site namefmt 1
	- bin
	- cd /qsys.lib/qgpl.lib
	- lcd c:\dmpjrn
	- put dmpjrn.savf
	- quit
	- exit
- RSTLIB SAVLIB(DMPJRN) DEV(*SAVF) SAVF(QGPL/DMPJRN)

Notes:
- Any library can be used instead of QGPL if you prefer - just change the CRTSAVF, CD, and RSTLIB commands.
- The save file can be deleted after the RSTLIB is complete.

Please send any feedback on the DMPJRN & CVTJRNDTA commands to:

Steven Wolk
SWolk@PCRichard.com


ALL SOFTWARE IS PROVIDED "AS IS" WITHOUT ANY WARRANTY OF ANY NATURE WHATSOEVER. THE PROVIDER OF THIS SOFTWARE 
HEREBY DISCLAIMS ALL WARRANTIES, REPRESENTATIONS, AND CONDITIONS, STATUATORY OR OTHERWISE, EXPRESS OR IMPLIED, 
INCLUDING BUT NOT LIMITED TO WARRANTY OF TITLE AND THE IMPLIED WARRANTY OF MERCHANTABILITY AND FITNESS FOR A 
PARTICULAR PURPOSE. THE PROVIDER SHALL NOT BE LIABLE FOR ANY DAMAGES ARISING FROM OR AS A RESULT OF YOUR USE 
OF THIS SOFTWARE. USE IT AS YOUR OWN RISK.