<h4>RTVJOBMSGW - Retrieve Job msg waiting information</h4>
<ul>
<li>Retrieve Job Information (QUSRJOBI) API format JOBI0200<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/qusrjobi.htm</li>
<li>CRTCLPGM  PGM(lib/RTVJOBMSGW) SrcFile(lib/QCLSRC) SrcMbr(RTVJOBMSGW)</li>
<li>CRTCMD CMD(lib/RTVJOBMSGW) SrcFile(QCMDSRC) SrcMbr(RTVJOBMSGW) ALLOW(*BPGM *IPGM)</li>
<li>CRTCLPGM PGM(lib/RTVJOBMSGT) SrcFile(lib/QCLSRC) SrcMbr(RTVJOBMSGT) Text('TEST Job RTVJOBMSGW command')</li>
<li>
<code>
                   Retrieve Job MSGW Information (RTVJOBMSGW)                   
                                                                                
 Type choices, press Enter.                                                     
                                                                                
 Job  . . . . . . . . . . . . . .   *             Name, *, *INT                 
   User . . . . . . . . . . . . .                 Name                          
   Number . . . . . . . . . . . .                 Character value               
 Internal job identifier  . . . .   *BLANK                                      
 CL var for MSGRPY       ( 1) . .                 Character value               
 CL var for JOB          ( 4) . .                 Character value               
 CL var for MSGQ         (10) . .                 Character value               
 CL var for MSGQLIB      (10) . .                 Character value               
 CL var for MSGID        ( 7) . .                 Character value               
 CL var for MSGTYPE      ( 2) . .                 Character value               
 CL var for MSGTXT      (132) . .                 Character value               
 CL var for SECLVL      (256) . .                 Character value               
 CL var for MSGDTA      (192) . .                 Character value               
 CL var for MSGF         (10) . .                 Character value               
 CL var for MSGFLIB      (10) . .                 Character value               
 CL var for ERRPGM       (10) . .                 Character value               
                                                                        More... 
 F3=Exit   F4=Prompt   F5=Refresh   F12=Cancel   F13=How to use this display    
 F24=More keys                                                                  

                   Retrieve Job MSGW Information (RTVJOBMSGW)                   
                                                                                
 Type choices, press Enter.                                                     
                                                                                
 CL var for ERRPGMLIB    (10) . .                 Character value               
 CL var for ERRMSGID     ( 7) . .                 Character value               
 CL var for ERRPGMSTMT   (10) . .                 Character value               
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                         Bottom 
 F3=Exit   F4=Prompt   F5=Refresh   F12=Cancel   F13=How to use this display    
 F24=More keys                                                                  
</code></li>
<ul>
</ul>
