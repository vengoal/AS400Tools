<h4>Security reference</h4>
https://www.ibm.com/docs/en/ssw_ibm_i_75/pdf/sc415302.pdf<br />
<br >
<a href="https://www.ibm.com/docs/en/i/7.5?topic=ssw_ibm_i_75/apis/xsyvlphr.html">QPWDVLDPGM - Password validation program</a><br />
<ul>
<li><a href="https://www.ibm.com/docs/en/i/7.5?topic=ssw_ibm_i_75/apis/xsyvlphr.html">Validate Password Exit Program</a></li>
<ul>
<li>QPWDVLDPGM -> *REGFAC -> ADDEXITPGM QIBM_QSY_VLD_PASSWRD format VLDP0100 -> PWDEXITPGM1 - Password validation exit</li>
<li>CHGSYSVAL SYSVAL(QPWDVLDPGM) VALUE(*REGFAC)</li>
<li>ADDEXITPGM QIBM_QSY_VLD_PASSWRD FORMAT(VLDP0100) PGM(QGPL/PWDEXITPGM1)</li>
</ul>
<li><a href="https://www.ibm.com/docs/en/i/7.3?topic=qpwdvldpgm-using-password-approval-program">Using a password approval program</a></li>
<ul>
<li>QPWDVLDPGM -> PWDVALID.CLP</li>
</ul>
 <li><a href="https://github.com/vengoal/CF_API_CBX/tree/main/CBX707">Password Change Blocking for V5R4 and Earlier - CBX707</a></li>
</ul>
</ul>

<h3>Password Related System Values -- <a href="https://www.ibm.com/docs/en/i/7.5?topic=values-system-that-apply-passwords">link</a></h3>
<table class="MsoNormalTable" border="0" cellspacing="0" cellpadding="0" width="523" style="width:5.45in;border-collapse:collapse;mso-yfti-tbllook:1184;mso-padding-alt:
 0in 0in 0in 0in"></p>
<tr style="mso-yfti-irow:0">
<td width="124" nowrap valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><b><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>System<br />
  Value </span></b><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'></p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><b><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>iSeries<br />
  Navigator (<span class="SpellE">OpsNav</span>) Password Policy Name</span></b><span style='font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border:solid windowtext 1.0pt;
  border-left:none;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><b><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Password<br />
  Composition rule</span></b><span style='font-family:"Times New Roman";
  mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
</tr>

 <tr style="mso-yfti-irow:1;height:37.25pt">
<td width="124" nowrap valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:37.25pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'>QPWDCHGBLK</p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:37.25pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'>Block password change</p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:37.25pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'>Specifies the time period during which a password is blocked from being changed after the prior successful password change operation.</p>
<p></span></p>
</td>
</tr>

 <tr style="mso-yfti-irow:1;height:37.25pt">
<td width="124" nowrap valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:37.25pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'>QPWDEXPITV</p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:37.25pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'>Password expiration interval</p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:37.25pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'>Specifies number of days passwords are valid.</p>
<p></span></p>
</td>
</tr>

 <tr style="mso-yfti-irow:1;height:37.25pt">
<td width="124" nowrap valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:37.25pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'>QPWDEXPWRN</p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:37.25pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'>Password Expiration Warning</p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:37.25pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'>Specifies number of days before a password expiration to begin displaying the password expiration warning messages when a user signs on.</p>
<p></span></p>
</td>
</tr>

<tr style="mso-yfti-irow:2">
<td width="124" nowrap valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>QPWDLMTAJC</span><span style='font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Restrict<br />
  Consecutive Digits</span><span style='font-family:"Times New Roman";
  mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Don&#8217;t<br />
  allow two consecutive numeric digits (0-9) in a password</span><span style='font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
</tr>
<tr style="mso-yfti-irow:3">
<td width="124" valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>QPWDLMTCHR</span><span style='font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Restricted<br />
  Characters</span><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'></p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Don&#8217;t<br />
  allow specific characters to be used in password</span><span style='font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
</tr>
<tr style="mso-yfti-irow:4;height:95.75pt">
<td width="124" valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:95.75pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>QPWDLMTREP</span><span style='font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:95.75pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Restrict<br />
  Repeating Characters</span><span style='font-family:"Times New Roman";
  mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:95.75pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Specifies<br />
  whether the same character can be used twice in the password, or whether the<br />
  character can be repeated consecutively (ex., &#8216;BBBBB&#8217;)</span><span style='font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
</tr>
<tr style="mso-yfti-irow:5">
<td width="124" valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>QPWDLVL</p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Password<br />
  level</p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Overall<br />
  system password level. QPWDLVL must be set to ‘2’ or higher when using<br />
  passwords or <span class="SpellE">passphrases</span> longer than 10 characters.</p>
<p></span></p>
</td>
</tr>
<tr style="mso-yfti-irow:6">
<td width="124" valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>QPWDMAXLEN</span><span style='font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Maximum<br />
  Length </span><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'></p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Maximum<br />
  length of the entered password </span><span style='font-family:"Times New Roman";
  mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
</tr>
<tr style="mso-yfti-irow:7">
<td width="124" valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>QPWDMINLEN</span><span style='font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Minimum<br />
  Length </span><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'></p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Minimum<br />
  length of the entered password </span><span style='font-family:"Times New Roman";
  mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
</tr>
<tr style="mso-yfti-irow:8">
<td width="124" valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>QPWDPOSDIF</span><span style='font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Require<br />
  a new character in each position</span><span style='font-family:"Times New Roman";
  mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Password<br />
  cannot contain any of the same characters in the same positions that they<br />
  occupied in the previous password</span><span style='font-family:"Times New Roman";
  mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
</tr>
<tr style="mso-yfti-irow:9;height:52.1pt">
<td width="124" valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:52.1pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>QPWDRQDDGT</span><span style='font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:52.1pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Require<br />
  at least one digit</span><span style='font-family:"Times New Roman";
  mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:52.1pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Password<br />
  must contain at least one number (0-9)</span><span style='font-family:"Times New Roman";
  mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
</tr>
<tr style="mso-yfti-irow:10;height:52.1pt">
<td width="124" valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;padding:0in 5.4pt 0in 5.4pt;height:52.1pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>QPWDRQDDIF</span><span style='font-family:"Times New Roman";mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:52.1pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Password<br />
  re-use cycle</span><span style='font-family:"Times New Roman";mso-fareast-font-family:
  "Times New Roman"'></p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  padding:0in 5.4pt 0in 5.4pt;height:52.1pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Password<br />
  cannot be the same as any of the previous 4, 6, 8, 10, 12, etc passwords<br />
  previously entered by this user</span><span style='font-family:"Times New Roman";
  mso-fareast-font-family:"Times New Roman"'></p>
<p></span></p>
</td>
</tr>

<tr style="mso-yfti-irow:11;mso-yfti-lastrow:yes;page-break-inside:avoid">
<td width="124" valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>QPWDRULES</p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Password Rules</p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'> Specifies the rules used to check whether a password is formed correctly. You can specify more than one value for the QPWDRULES system value, unless you specify *PWDSYSVAL.</p>
<p></span></p>
</td>
</tr>

<tr style="mso-yfti-irow:11;mso-yfti-lastrow:yes;page-break-inside:avoid">
<td width="124" valign="top" style="width:92.7pt;border:solid windowtext 1.0pt;
  border-top:none;mso-border-top-alt:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>QPWDVLDPGM</p>
<p></span></p>
</td>
<td width="172" valign="top" style="width:128.75pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Password<br />
  validation program</p>
<p></span></p>
</td>
<td width="228" valign="top" style="width:170.95pt;border-top:none;border-left:
  none;border-bottom:solid windowtext 1.0pt;border-right:solid windowtext 1.0pt;
  mso-border-top-alt:solid windowtext 1.0pt;padding:0in 5.4pt 0in 5.4pt"></p>
<p class="MsoNormal" style="margin-bottom:0in;margin-bottom:.0001pt;line-height:
  normal"><span style='font-family:Arial;mso-fareast-font-family:"Times New Roman"'>Specifies<br />
  either the name of the password validation program; or *REGFAC to specify<br />
  program is designated in QIBM_QSY_VLD_PASSWRD exit point</p>
<p></span></p>
</td>
</tr>
</table>

