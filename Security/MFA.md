<h3>Manage MFA on IBM i</h3>

<h4>Enabling MFA on your system</h4>
<ul>
  <li>QSECURITY security level must be >= 40</li>
  <li>QPWDLVL password level must be >= 4</li>
  <li>DSPSECA - Display Security Attributes</li>
  <li>CHGSECA - Change  Security Attributes <br />Set Additional sign-on factor (ADLSGNFAC) parameter : <br /><code>CHGSECA   ADLSGNFAC(*ENABLED)</code><br />A change to this value takes effect at the next IPL.</li>
</ul>
<h4>Enabling MFA for a user</h4>
<ol>
  <li>Administrator operation:<br />CHGUSRPRF  - Change User Profile Authentication Methods (AUTHMTH) parameter : <br /><code>CHGUSRPRF AUTHMTH(*TOTP)</code></li>
  <li>User operation:<br />CHGTOTPKEY - Change TOTP Key<br />
    <code>
      CHGTOTPKEY   TOTPKEY(*GEN)
      CHGTOTPKEY   TOTPKEY(TOTP key value) ==> The value must be 32-characters that contain valid base 32 characters only (A - Z and 2 - 7).
    </code><br />This command will generate a TOTP key for the currently running user and store the TOTP key in their profile. This TOTP key is usually entered into a client application which can then generate a TOTP value.</li>
</ol>
<ul>
  <li>Using IBM Navigator for i to Manage MFA<br />https://www.ibm.com/support/pages/node/7180390</li>
  <li>Retrieve TOTP Key (QSYRTVK) returns to the caller a protected version of the time-based one-time password (TOTP) key for the specified user profile.<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_76/apis/qsyrtvk.htm</li>
  <li>Set TOTP Key (QSYSETK) sets the time-based one-time password (TOTP) key for the specified user profile by using the receiver variable that was retrieved with the Retrieve TOTP Key (QSYRTVK) API<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_76/apis/qsysetk.htm</li>
</ul>
