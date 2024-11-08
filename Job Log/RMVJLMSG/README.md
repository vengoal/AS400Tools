<h3>RMVJLMSG - Remove Job Log Messages</h3>
<ul>
<li>RMVJLMSG (Utility Cleans Up Unwanted Job Log Messages by Rory Hewitt)</li>
<li>Creating the RMVJLMSG command and associated objects
<p>You should compile the RMVJLMSGR program and RMVJLMSGH source members using the defaults for the CRTBNDRPG and CRTPNLGRP commands, respectively. I suggest compiling all the objects into a utility library such as QGPL. Compile the RMVJLMSG *CMD source member with the following command:

CRTCMD CMD(QGPL/RMVJLMSG) PGM(QGPL/RMVJLMSGR) HLPPNLGRP(RMVJLMSGH)
       HLPID(*CMD) MAXPOS(0)
</p>
</li>
</ul>
