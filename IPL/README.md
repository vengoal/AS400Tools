<h4>IPL - Initial Program Load</h4>
<ul>
  <li>RTVIPLTIM - Retrieve IPL Date and Time><br />
  <pre><code>
                          Retrieve IPL Time (RTVIPLTIM)                       
                                                                              
 Type choices, press Enter.                                                   
                                                                              
 CL var for STRIPLDAT    ( 8) . .                 Character value             
 CL var for STRIPLTIM    ( 8) . .                 Character value             
 CL var for ENDIPLDAT    ( 8) . .                 Character value             
 CL var for ENDIPLTIM    ( 8) . .                 Character value             
 CL var for IPLSEC      (5 0) . .                 Number                      
 CL var for STRPWRDWND   ( 8) . .                 Character value             
 CL var for STRPWRDWNT   ( 8) . .                 Character value             
 CL var for ENDPWRDWND   ( 8) . .                 Character value             
 CL var for ENDPWRDWNT   ( 8) . .                 Character value             
 CL var for PWRDWNSEC   (5 0) . .                 Number                      
                                                                              
                                                                              
                                                                              
  
  Test Sample output:
   Variable               Type        Length         Value                     
                                                    *...+....1....+....2....+
 &ENDIPLDAT               *CHAR            8       '11/24/24'                
 &ENDIPLTIM               *CHAR            8       '05:08:06'                
 &ENDPWRDWND              *CHAR            8       '11/24/24'                
 &ENDPWRDWNT              *CHAR            8       '02:03:21'                
 &IPLSEC                  *DEC           5 0        266                      
 &PWRDWNSEC               *DEC           5 0        200                      
 &STRIPLDAT               *CHAR            8       '11/24/24'                
 &STRIPLTIM               *CHAR            8       '05:03:40'                
 &STRPWRDWND              *CHAR            8       '11/24/24'                
 &STRPWRDWNT              *CHAR            8       '02:00:01'                
  </code>
  </pre>
  </li>
  <ul>
    <li>Before Compile:<br />
    CrtPF      File( QTEMP/QWCCRTEC ) 
           RcdLen( 132 )          
           IgcDta( *YES )         </li>
    <li>CRTBNDCL PGM(xxx/RTVIPLTIM) SRCFILE(xxx/QCLSRC) SRCMBR(RTVIPLTIM)</li>
    <li>CRTCMD CMD(xxx/RTVIPLTIM) SRCFILE(xxx/QCMDSRC) SRCMBR(RTVIPLTIM) ALLOW(*BPGM *IPGM)</li>
    <li>Create TEST program <br />CRTCLPGM PGM(RTVIPLTIMT) SRCFILE(xxx/QCLSRC) SRCMBR(RTVIPLTIMT)</li>
  </ul>
  <li>Program QWCCRTEC: Prints Report on Time Spent in IPL Phases/Steps<br />https://www.ibm.com/support/pages/program-qwccrtec-prints-report-time-spent-ipl-phasessteps</li>
  <li>Find the last IBM i System IPL date<br />https://www.nicklitten.com/find-last-ipl-date/</li>
  <li>ILE CEE Date and Time APIs<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/ile4a1TOC.htm</li>
  <li>The CL Corner: More on ILE CEE Time APIs<br />https://www.mcpressonline.com/programming-other/cl/the-cl-corner-more-on-ile-cee-time-apis</li>
  <li>TAATOOL - RTVIPLTIM<br />https://taatool.com/document/L_rtvipltim.html</li>
</ul>
