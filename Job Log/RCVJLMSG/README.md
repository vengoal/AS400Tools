<h2>RCVJLMSG -- Receive Job Log Message procedure</h2>
<p>
Procedure RCVJLMSG orginal from Vadim Rozen. <br />
Reference <a href = "https://www.mcpressonline.com/programming/apis/api-power-without-api-complexity" >API Power Without API Complexity!</a> by Ted Holt.
</p>

<pre>
 * =========================================================
 * Prototype for RcvJLMsg (Receive Job Log Message)         
 * =========================================================
d RCVJLMSG        pr                                        
d  iJob                         26                          
d  iAction                      10                          
d  iDirection                    1                          
d  oMessage                   1132                          
d  oReturn                      10                          

* =========================================================
* Permissable values for  iJob                             
*      '*' = current job                                   
*      or name (10), user (10), and number (6)             
* =========================================================
* Permissable values for iAction                           
*      '*NEW' = get first msg                              
*      '*CONTINUE' = get following messages                
* =========================================================
* Permissable values for iDirection                        
*      'F' = read forward from top of job log              
*      'B' = read backward from bottom of job log          
* =========================================================
</pre>     

<h3>Usage</h3>
<ul>
<li>Create service module : <br />CRTRPGMOD  MODULE(lib/RCVJLMSG) SRCFILE(lib/QRPGLESRC)</li>
<li>Create sample program module : <br />CRTRPGMOD  MODULE(lib/RCVJLMSGT) SRCFILE(lib/QRPGLESRC)</li>
<li>Create sample program : <br />CRTPGM     PGM(XXX/RCVJLMSGT) MODULE(RCVJLMSGT RCVJLMSG) ACTGRP(*NEW)</li>
<li>TEST sample program : <br />CALL RCVJLMSGT ('*' 'F') or CALL RCVJLMSGT ('*' 'B'),<br /> browse output QSYSPRT spooled file</li>  
</ul>
