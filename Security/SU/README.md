<h3>TechTip: Take Advantage of the SU CL Command</h3>
https://www.mcpressonline.com/programming-other/cl/techtip-take-advantage-of-the-su-cl-command<br /><br />
Switch to and back from different user profiles within the same job with ease.

<h4>Usage:</h4>
<ul>
  <li><code>CRTBNDCL PGM(lib/SU) SRCFILE(lib/qclsrc) SRCMBR(SU)</code></li>
  <li><code>CRTCMD CMD(lib/SU) PGM(lib/SU) SRCFILE(lib/qcmdsrc) SRCMBR(SU)</code></li>
  <li><code>
                                       su (SU)                                    
                                                                                
 Type choices, press Enter.                                                     
                                                                                
 User name  . . . . . . . . . . .                 Name, *EXIT                   
 Password . . . . . . . . . . . .                 Character value, *NOPWD...    
                                                                                
  </code><br />
 The SU command allows an operator or a program to switch to another user profile in a single job. When switching to another user profile, you should pass a user profile (*USRPRF) name and the password of the USRPRF (or optionally one of the following accepted special values: *NOPWD, *NOPWDCHK, or *NOPWDSTS). For example: SU USER(USER_A) PASSWORD(******). When switching back to the previous USRPRF, you can simply issue SU USER(*EXIT).
  </li>
  <li>Password special value:</li>
  <ul>
    <li>*NOPWD	<br />The user requesting the profile handle must have *USE authority to the user profile.<br />
A profile handle does not get created for a disabled user profile.<br />
A profile handle does not get created for a user profile with an expired password.</li>

<li>*NOPWDCHK	<br />The user requesting the profile handle must have *USE authority to the user profile.<br />
If the profile is disabled, the user requesting the profile handle must have *ALLOBJ and *SECADM special authorities to get a handle.<br />
If the password is expired, the user requesting the profile handle must have *ALLOBJ and *SECADM special authorities to get a handle.</li>

<li>*NOPWDSTS	<br />The user requesting the profile handle must have *USE authority to the user profile.<br />
A profile handle does not get created for a disabled user profile.<br />
If the password is expired, the user requesting the profile handle must have *ALLOBJ and *SECADM special authorities to get a handle.</li>
  </ul>
</ul>

<h4>API refreence:</h4>
<ul>
  <li>Get Profile Handle (QSYGETPH) validates a user ID and password, and creates an encrypted abbreviation called a profile handle for that user profile.<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/QSYGETPH.htm</li>
  <li>Set Profile Handle (QWTSETP, QsySetToProfileHandle) switches the job to run under a new profile.<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/QWTSETP.htm</li>
  <li>Release Profile Handle (QSYRLSPH, QsyReleaseProfileHandle) validates a given profile handle and then releases it.<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/QSYRLSPH.htm</li>
</ul>
