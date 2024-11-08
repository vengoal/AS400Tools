<h3>Message Handling</h3>
<ul>
  <li><a href="https://www.mcpressonline.com/it-infrastructure/it-infrastructure-other/as400-messaging-concepts-and-implementation">AS/400 Messaging Concepts and Implementation</a></li>
  <li><a href="https://www.ibm.com/support/pages/receiving-messages-joblog-after-program-callstack">Receiving Messages from the Joblog after the Program is Off the Callstack</a></li>
  <li><a href="https://www.mcpressonline.com/programming/apis/the-api-corner-removing-error-messages-from-the-job-log">The API Corner: Removing Error Messages from the Job Log</a></li>
  <li><a href="https://www.mcpressonline.com/programming/apis/simons-solutions-prepared-to-be-surprised-by-qcmd">STRCLRDR -- Simon's Solutions: Prepared to Be Surprised by QCMD?</li>
  <li><a href="https://archive.midrange.com/midrange-l/201408/msg00065.html">Attempting to remove message CPI2201 from joblog</a></li>
</ul>

<h3>MOVDIAGMSG, RSNESCMSG Usage:</h3>
<ul>
<code>
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
</code>
</ul>
