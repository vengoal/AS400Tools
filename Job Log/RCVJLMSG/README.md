RCVJLMSG -- Receive Job Log Message

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

<h1>Usage</h1>
<ul>
<li>1. CRTRPGMOD  MODULE(lib/RCVJLMSG) SRCFILE(lib/QRPGLESRC)</li>
<li>2. CRTRPGMOD  MODULE(lib/RCVJLMSGT) SRCFILE(XXX/QRPGLESRC)</li>
<li>3. CRTPGM     PGM(XXX/RCVJLMSGT) MODULE(RCVJLMSGT RCVJLMSG) ACTGRP(*NEW)</li>
<li>4. TEST program : CALL RCVJLMSGT ('*' 'F') or CALL RCVJLMSGT ('*' 'B')</li>  
</ul>
