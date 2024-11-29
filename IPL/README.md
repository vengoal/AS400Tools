<h4>IPL - Initial Program Load</h4>
<ul>
  <li>RTVIPLTIM - Retrieve IPL Date and Time><br />
  <pre><code>
                          Retrieve IPL Time (RTVIPLTIM)                       
                                                                              
 Type choices, press Enter.                                                   
                                                                              
 Date of IPL started  . . . . . .                 Character value             
 Time of IPL started  . . . . . .                 Character value             
 Date of IPL ended  . . . . . . .                 Character value             
 Time of IPL ended  . . . . . . .                 Character value             
 Number of seconds for IPL  . . .                 Number                      
 Date of power down started . . .                 Character value             
 Time of power down started . . .                 Character value             
 Date of power down ended . . . .                 Character value             
 Time of power down ended . . . .                 Character value             
 Number of seconds for PWRDWN . .                 Number                      
                                                                              
  
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
  <li>Program QWCCRTEC: Prints Report on Time Spent in IPL Phases/Steps<br />https://www.ibm.com/support/pages/program-qwccrtec-prints-report-time-spent-ipl-phasessteps</li>
  <li>Find the last IBM i System IPL date<br />https://www.nicklitten.com/find-last-ipl-date/</li>
  <li>ILE CEE Date and Time APIs<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/ile4a1TOC.htm</li>
  <li>The CL Corner: More on ILE CEE Time APIs<br />https://www.mcpressonline.com/programming-other/cl/the-cl-corner-more-on-ile-cee-time-apis</li>
  <li>TAATOOL - RTVIPLTIM<br />https://taatool.com/document/L_rtvipltim.html</li>
</ul>
