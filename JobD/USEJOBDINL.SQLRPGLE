     h dftactgrp(*no)
     h option(*nodebugio)

     d Exc_Cmd         PR                  extpgm('QCMDEXC')
     d  command                    2000A   const
     d  length                       15P 5 const

     d DataDS          ds
     d $count                         9s 0
     d $libList                    2750a

     d $jobd           s             10a
     d $cmd            s           2000a
     d $quote          s              1a   inz(X'7D')
     d $errmsg         s            100a

     c     *entry        plist
     c                   parm                    $jobd

      /free

       //Set SQL options
       exec sql
        SET OPTION
            commit=*none,
            datfmt=*iso;

       //Get Library List Info
       exec sql
         Select LIBL_COUNT, LIBL into :DataDS
         FROM QSYS2.JOB_DESCRIPTION_INFO
         WHERE JOBD = :$jobd
         fetch first 1 rows only;

         if sqlcod = 0;
         else;
           $errmsg = 'Jobd ' + %trim($jobd) + ' not found.';
           $cmd = 'SNDMSG MSG(' + $quote + %trim($errmsg) + $quote +
                  ') TOUSR(*REQUESTER)';
           Exc_Cmd(%trim($cmd): %len(%trim($cmd)));
           *inlr = *on;
           return;
         endif;

       $cmd = 'CHGLIBL LIBL(' + %trim($libList) + ')';
       Exc_Cmd(%trim($cmd): %len(%trim($cmd)));

        *inlr = *on;
        return;
      /end-free
