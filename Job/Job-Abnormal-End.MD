<h3>Handling Job Abnormal End</h3>
<ul>
<li>Using the <a href="https://www.ibm.com/docs/en/i/7.5?topic=ssw_ibm_i_75/apis/QMHSNDSM.html">QMHSNDSM</a> API, you can identify a program to call when the job or call stack entry ends.<br />Use <a href="https://github.com/vengoal/AS400Tools/blob/main/Message/SNDSCPMSG.CMD">SNDSCPMSG</a> set job exit program</li>
<li>Practical RPG: Handling Abnormal Termination in Servers<br />CEERTX is the ILE RPG version of the concept and allows you to identify a procedure to be called if your call stack entry is terminated.<br />https://www.mcpressonline.com/programming/rpg/practical-rpg-handling-abnormal-termination-in-servers</li>
<ul>
<li>
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
<li>Simon's Solutions: Monitor for End Job Operations, Part I<br />https://www.mcpressonline.com/programming/rpg/simons-solutions-monitor-for-end-job-operations-part-i</li>
<li>Simon's Solutions: Monitor for End Job Operations, Part II<br />https://www.mcpressonline.com/programming/rpg/simons-solutions-monitor-for-end-job-operations-part-ii</li>
<ul>
<li>EOJ11.RPGLE<code>
     h dftactgrp(*no) bnddir('QC2LE')

     * API error code structure
     d qusec_t         ds                 qualified
     d                                       based(@dummy)
     d     bytes_in                   10i 0
     d     bytes_out                   10i   0
     d     msgid                       7a
     d                               1a

     * Message-specific message data
     * Prototype of the Send Scope Message   (QMHSNDSM) API
     d QMHSNDSM       pr                  extpgm('QMHSNDSM')
     d     type                       10a
     d     scope_pgm                   20a
     d     arg                         1a     options(*varsize)
     d     arg_len                     10i   0
     d     msg_key                    4a
     d     ec                                 likeds(qusec_t)

     * Prototype of libc routine sleep()
     d sleep           pr           10i 0 extproc('sleep')
     d                               10u 0 value

     d scope_type     s             10a     inz('*EXT')
     d scope_pgm       s             20a     inz('EOJ11     *LIBL')
     d arg             s             20a   inz('Hi,   scope program!')
     d arg_len         s             10i 0 inz(32)
     d msg_key         s             4a
     d ec                ds                 likeds(qusec_t)
     d text           s             30a
     d i_main         pr                 extpgm('EOJ11')
     d     greeting                   20a
     d i_main         pi
     d     greeting                   20a

     /free

           if %parms() > 0; // Now, EOJ11   works as a scope program.
               // Do cleanup works
               dsply 'Scope-handling program   invoked' '';
               text = 'ARG: ' + greeting;
               dsply text '';
               dsply 'Cleanup, cleanup, cleanup ...'   '';
               *inlr = *on;

               return;

           endif;


           // Register myself as a *EXT   scope-handling program

           ec.bytes_in = %len(ec);
           QMHSNDSM( scope_type
                   : scope_pgm
                   : arg
                   : arg_len
                   : msg_key
                   : ec);


           // Do my works
           dsply 'Doing my works ...' '';
           sleep(600);

           *inlr = *on;

     /end-free
</code>
</li>
</ul>
</ul>
