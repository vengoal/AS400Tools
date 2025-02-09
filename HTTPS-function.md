<h4>HTTPS function</h4>
<ui>
 <li>The user profile which make HTTP request must have READ access to the certificate store file.</li>
</ui>
<h4>Grant key store authority to user which running TLS (SSL) applications</h4>
<ul>
<li>When you got GSKit Error is 6003 - Access to the key database is not allowed, <br />the user profile which make HTTP request must have READ access to the certificate store file.<br />
The default system certificate store located on this path:<br />
/QIBM/USERDATA/ICSS/CERT/SERVER/DEFAULT.KDB<br /><br />
This user needs *RX access to all of these directories, as well as OBJEXIST authority:
<pre>
/QIBM
/QIBM/UserData
/QIBM/UserData/ICSS
/QIBM/UserData/ICSS/Cert
/QIBM/UserData/ICSS/Cert/Server</li>
</pre>
And also need *R access as well as OBJEXIST authority to these files:
<pre>
/QIBM/UserData/ICSS/Cert/Server/DEFAULT.KDB
/QIBM/UserData/ICSS/Cert/Server/DEFAULT.RDB
</pre>
Or, the user must have *ALLOBJ authority
<li>
Grant authority as following commands...(Change youruser to the https function running userid)
<pre>
 CHGAUT OBJ('/') +
        USER(youruser) DTAAUT(*RX)
 CHGAUT OBJ('/QIBM') +
        USER(youruser) DTAAUT(*RX)
 CHGAUT OBJ('/QIBM/UserData') +
        USER(youruser) DTAAUT(*RX)
 CHGAUT OBJ('/QIBM/UserData/ICSS') +
        USER(youruser) DTAAUT(*RX)
 CHGAUT OBJ('/QIBM/UserData/ICSS/CERT') +
        USER(youruser) DTAAUT(*RX)
 CHGAUT OBJ('/QIBM/UserData/ICSS/CERT/SERVER')
        USER(youruser) DTAAUT(*RX)
 CHGAUT OBJ('/QIBM/UserData/ICSS/CERT/SERVER/DEFAULT.KDB')
        USER(youruser) DTAAUT(*R)
 CHGAUT OBJ('/QIBM/UserData/ICSS/CERT/SERVER/DEFAULT.RDB')
        USER(youruser) DTAAUT(*R)
  </pre>
</li>
</ul>
