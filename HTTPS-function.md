<h4>HTTPS function</h4>
<ul>
 <li>New HTTP functions based in QSYS2 (C version better performance than SYSTOOLS java version) - https://www.ibm.com/support/pages/node/6486889</li>
 <li>HTTP functions overview - https://www.ibm.com/docs/en/i/7.5?topic=programming-http-functions-overview</li>
 <li>HTTP options - https://www.ibm.com/docs/en/i/7.5?topic=functions-http-get-http-get-blob#rbafzscahttpget__HTTP_options</li>
 <li>Configuring Your IBM i System Secure Sockets Layer (SSL)/Transport Layer Security (TLS) Protocols and Cipher Suites<br />https://www.ibm.com/support/pages/node/666411</li>
 <li>Digital Certificate Manager for i (DCM) - Frequently Asked Questions and Common Tasks( IBM i 7.3, 7.4, 7.5)<br />https://www.ibm.com/support/pages/node/6607872</li>
 <li>SYSTOOLS Java version</li>
 <ul>
 <li>Configuring IBM i DB2 SYSTOOLS HTTP User-Defined Functions for TLS/HTTPS Secure Communications<br />https://www.ibm.com/support/pages/configuring-ibm-i-db2-systools-http-user-defined-functions-tlshttps-secure-communications</li>
 <li>How to import a certificate for Java keystore using Java keytool <br />https://www.ibm.com/support/pages/how-import-certificate-java-keystore-using-java-keytool</li>
 </ul>
</ul>

<h4>Grant certificate store file authority to user which running TLS (SSL) applications</h4>
<ul>
<li>When you got GSKit Error is 6003 - Access to the key database is not allowed, <br />the user profile which make HTTP request must have READ access to the certificate store file.<br /><br />
The default system certificate store located on this path:<br />
/QIBM/USERDATA/ICSS/CERT/SERVER/DEFAULT.KDB<br /><br />
This user needs *RX access to all of these directories:
<code>
/                                   (*PUBLIC default authority *RWX) 
/QIBM                               (*PUBLIC default authority *RX)
/QIBM/UserData                      (*PUBLIC default authority *RX)
/QIBM/UserData/ICSS                 (*PUBLIC default authority *RX)
/QIBM/UserData/ICSS/Cert            (*PUBLIC default authority *RX)
/QIBM/UserData/ICSS/Cert/Server     (*PUBLIC default authority *EXCLUDE)
</code>
<p>And also need *R access authority to these files:
<code>
/QIBM/UserData/ICSS/Cert/Server/DEFAULT.KDB      (*PUBLIC default authority *EXCLUDE)
/QIBM/UserData/ICSS/Cert/Server/DEFAULT.RDB      (*PUBLIC default authority *EXCLUDE)
</code>
<p>Or, the user must have *ALLOBJ authority.</li>
<li>
IFS does not support adopted authority.
Grant authority as following commands...(Change 'youruser' to the https function running userid)<code>
 CHGAUT OBJ('/') 
        USER(youruser) DTAAUT(*RX)
 CHGAUT OBJ('/QIBM') 
        USER(youruser) DTAAUT(*RX)
 CHGAUT OBJ('/QIBM/UserData') 
        USER(youruser) DTAAUT(*RX)
 CHGAUT OBJ('/QIBM/UserData/ICSS') 
        USER(youruser) DTAAUT(*RX)
 CHGAUT OBJ('/QIBM/UserData/ICSS/CERT') 
        USER(youruser) DTAAUT(*RX)
 CHGAUT OBJ('/QIBM/UserData/ICSS/CERT/SERVER')
        USER(youruser) DTAAUT(*RX)
 CHGAUT OBJ('/QIBM/UserData/ICSS/CERT/SERVER/DEFAULT.KDB')
        USER(youruser) DTAAUT(*R)
 CHGAUT OBJ('/QIBM/UserData/ICSS/CERT/SERVER/DEFAULT.RDB')
        USER(youruser) DTAAUT(*R)  </code>
</li>
</ul>
