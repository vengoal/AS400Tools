<h4>WRKPRB -- Work with problem</h4>
<ul>
  <li>Problem Management APIs<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/pm1.htm</li>
  <li>Problem Logging APIs<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/pm1a.htm</li>
  <li>Work with problem related DB files <br /><code>WRKOBJPDM LIB(QUSRSYS) OBJ(QASX*)</code></li>
</ul>
<h4>DSPPRB -- Display problem</h4>
<ul>
  <li>Display problem to outfile<br /><code>DSPPRB OUTPUT(*OUTFILE) OUTFILE(QTEMP/PRB)</code><br />System reference code drivened from outfile field PBRCT(Translate Table) and PBRFCD(Reference Code) :<br /><code>Substring(PBRCT 1 4) concate PBRFCD</code></li>
</ul>
