<h3>Handling Job Abnormal End</h3>
<ul>
<li>Using the <a href="https://www.ibm.com/docs/en/i/7.5?topic=ssw_ibm_i_75/apis/QMHSNDSM.html">QMHSNDSM</a> API, you can identify a program to call when the job or call stack entry ends.<br />Use <a href="https://github.com/vengoal/AS400Tools/blob/main/Message/SNDSCPMSG.CMD">SNDSCPMSG</a> set job exit program</li>
<li>Practical RPG: Handling Abnormal Termination in Servers<br />https://www.mcpressonline.com/programming/rpg/practical-rpg-handling-abnormal-termination-in-servers</li>
<code>
     h dftactgrp(*no) actgrp(*new) option(*srcstmt:*nodebugio)
 
     d SendMessage     pr
     d   Message                     60    const

     d Cancel          pr
     d   TokenIn                       *

      **
      * External prototypes
      **
     dCEERTX           pr                  extproc('CEERTX')
     d   pCanclHdlr                    *    const procptr
     d   errInfo                       *    const options(*omit)
     d   FeedBack                    12     options(*omit)

     dQRCVDTAQ         PR                  EXTPGM('QRCVDTAQ')
     d   DQName                      10    const
     d   DQLibr                      10    const
     d   DQLen                        5p 0
     d   DQData                      32
     d   DQWait                       5p 0 const
 
     d DQLen           s              5p 0
     d DQData          s             32
 
     dQCMDEXC          PR                  EXTPGM('QCMDEXC')
     d   Command                     80    const
     d   CmdLen                      15p 5 const

      /free

       CEERTX(%paddr('CANCEL'):*OMIT:*OMIT);

       QRCVDTAQ( 'MCPQ': 'MCP': DQLen: DQData: 60);
       if DQLen = 0;
         SendMessage('Timeout');
       else;
         SendMessage('Received: ' + DQData);
       endif;

       *inlr = *on;

      /end-free

     p SendMessage     b
     d                 pi
     d   Message                     60    const
      /free
       QCMDEXC('SNDMSG MSG(''' + %trim(Message) + ''') TOUSR(*SYSOPR)': 80);
      /end-free
     p                 e

     p Cancel          b
     d                 pi
     d   TokenIn                       *
     d x               s              3u 0
      /free
       SendMessage('Canceled');
      /end-free
     p                 e
</code>
</li>
</ul>
