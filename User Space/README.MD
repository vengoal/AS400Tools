<h4>User Space APIs</h4>
https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/obj5.htm<br>

USRSPCCMDS.SAVF Reference :<br>
https://www.ibm.com/support/pages/creatingchangingretrieving-user-space-usrspc-ibm%C2%AE-iseries%E2%84%A2-family-servers

To restore the objects, send the save file to your system and run the following command from the OS/400 or i5/OS command line:

RSTOBJ OBJ(*ALL) SAVLIB(QTEMP) DEV(*SAVF) SAVF(QGPL/USRSPCCMDS) RSTLIB(QGPL)
