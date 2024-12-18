<h3>Message Handling</h3>
<ul>
  <li><a href="https://www.mcpressonline.com/it-infrastructure/it-infrastructure-other/as400-messaging-concepts-and-implementation">AS/400 Messaging Concepts and Implementation</a></li>
  <li><a href="https://www.ibm.com/support/pages/receiving-messages-joblog-after-program-callstack">Receiving Messages from the Joblog after the Program is Off the Callstack</a></li>
  <li><a href="https://www.mcpressonline.com/programming/apis/the-api-corner-removing-error-messages-from-the-job-log">The API Corner: Removing Error Messages from the Job Log</a></li>
  <li><a href="https://www.mcpressonline.com/programming/apis/simons-solutions-prepared-to-be-surprised-by-qcmd">STRCLRDR -- Simon's Solutions: Prepared to Be Surprised by QCMD?</li>
  <li><a href="https://archive.midrange.com/midrange-l/201408/msg00065.html">Attempting to remove message CPI2201 from joblog</a></li>
  <li><a href="https://www.ibm.com/docs/en/i/7.5?topic=ssw_ibm_i_75/apis/QMHSNDSM.html">Send Scope Message (QMHSNDSM)</a> Sends a scope message that allows a user to specify a program to run when your program or job is completed.</li>
</ul>

<h3>EDITC</h3>
<ul>
  <li>Editing Numbers in CL <br />https://www.itjungle.com/2005/08/10/fhg081005-story02/</li>
  <li>The API Corner: Dynamically Editing a Numeric Value<br />https://www.mcpressonline.com/programming/apis/the-api-corner-dynamically-editing-a-numeric-value</li>
  <li>QECCVTEC<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/QECCVTEC.htm</li>
  <li>QECEDT<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/QECEDT.htm</li>
</ul>

<h3>MOVDIAGMSG, RSNESCMSG Usage:</h3>
<pre>
     Pgm
     
  /*-- Global error monitoring:  --------------------------------------*/
     MonMsg     CPF0000      *N        GoTo Error                       

.............
.............

 Error:                                                                          
    MovDiagMsg                                                                   
    Monmsg    CPF0000                                                            
    RsnEscMsg                                                                    
    Monmsg    CPF0000                                                            
                                                                                 
    Endpgm
</pre>

<h3>MOVPGMMSG, RSNESCMSG Usage:</h3>
CL Error-Handling With APIs<br />
https://www.itjungle.com/2012/05/02/fhg050212-story01/
<code>
MONMSG CPF0000 EXEC(GOTO ABEND)
. . . more code . . .
   RETURN
ABEND:
   MOVPGMMSG  MSGTYPE(*DIAG)
   RSNESCMSG
</code>
