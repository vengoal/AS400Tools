<h3>Clear joblog messages between msgkey</h3>
<ul>
  <li>RTVMSGKEY - Retrieve message key</li>
  <li>RMVMSGKEY - Remove message by message key</li>
  <li>RMVMSGKEYT - Remove message by message key test program</li>
</ul>
<h3>Usage:</h3>
<ul>
  <li>CRTCLPGM PGM(RTVMSGKEY) SRCFILE(lib/QCLSRC) SRCMBR(RTVMSGKEY)</li>
  <li>CRTCLPGM PGM(RMVMSGKEY) SRCFILE(lib/QCLSRC) SRCMBR(RMVMSGKEY)</li>
  <li>CRTCLPGM PGM(RMVMSGKEYT) SRCFILE(lib/QCLSRC) SRCMBR(RMVMSGKEYT)</li>
  <li>CRTCMD CMD(RTVMSGKEY) PGM(RTVMSGKEY) SRCFILE(lib/QCMDSRC) SRCMBR(RTVMSGKEY)</li>
  <li>CRTCMD CMD(RMVMSGKEY) PGM(RMVMSGKEY) SRCFILE(lib/QCMDSRC) SRCMBR(RMVMSGKEY)</li>
</ul>
<ul><pre>
 DCL         &MSGKEY *CHAR LEN(4)
             .
            RTVMSGKEY   MSGKEY(&MSGKEY)
                        /*                                          */
                        /* Commands that produce messages           */
                        /*                                          */
            RMVMSGKEY   MSGKEY(&MSGKEY)
</pre>
</ul>
