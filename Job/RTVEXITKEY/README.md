<h4>RTVEXITKEY - Retrieve Exit(F3 or F12) Key</h4><br />
Tips and Techniques: Checking for F3/F12 from an IBM Command<br />
https://www.mcpressonline.com/programming/rpg/tips-and-techniques-checking-for-f3f12-from-an-ibm-command

<ul>
  <li>RTVEXITKEY.CLP<code>
    CRTCLPGM PGM(RTVEXITKEY.CLP) 
             SRCFILE(lib/QCLSRC) 
             SRCMBR(RTVEXITKEY)
  </code></li>
  <li>RTVEXITKEY.CMD<code>
    CRTCMD CMD(RTVEXITKEY) 
           PGM(RTVEXITKEY) 
           ALLOW(*IPGM *BPGM *IMOD *BMOD)</code></li>
</ul>
