<h3>Manage MFA on IBM i</h3>

<h4>Enabling MFA on your system</h4>
<ul>
  <li>QSECURITY security level must be >= 40</li>
  <li>QPWDLVL password level must be >= 4</li>
</ul>
<ul>
  <li>Using IBM Navigator for i to Manage MFA<br />https://www.ibm.com/support/pages/node/7180390</li>
  <li>Retrieve TOTP Key (QSYRTVK) returns to the caller a protected version of the time-based one-time password (TOTP) key for the specified user profile.<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_76/apis/qsyrtvk.htm</li>
  <li>Set TOTP Key (QSYSETK) sets the time-based one-time password (TOTP) key for the specified user profile by using the receiver variable that was retrieved with the Retrieve TOTP Key (QSYRTVK) API<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_76/apis/qsysetk.htm</li>
</ul>
