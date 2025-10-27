For example:

     H DFTACTGRP(*NO)

      /copy LBCPYNV_H

     D CharStr         s            100A
     D PackPos         s             10I 0
     D Zoned           s             31S 9

     D in_attr         ds                  likeds(LBCPYNV_attr_t)
     D                                     inz(*likeds)
     D out_attr        ds                  likeds(LBCPYNV_attr_t)
     D                                     inz(*likeds)
      /free
                  //            1         2                        3
                  //  012345678901234567890       1 2 3 4     5678901
           CharStr = 'Hey this is a string ' + x'0123321F' + ' lalala';
           PackPos = 21;

           in_attr.type    = TYPE_PACKED;
           in_attr.decpos  = 2;
           in_attr.digits  = 7;

           out_attr.type   = TYPE_ZONED;
           out_attr.decpos = %decpos(Zoned);
           out_attr.digits = %len(Zoned);

           LBCPYNV( %addr(Zoned)
                  : out_attr
                  : %addr(CharStr) + PackPos
                  : in_attr );

           dsply %char(Zoned);
           *inlr = *on;
      /end-free


Here's the contents of the /copy member:

      /if defined(LBCPYNV_H_DEFINED)
      /eof
      /endif
      /define LBCPYNV_H_DEFINED

     D LBCPYNV_attr_t  ds                  qualified
     D   type                         1A   inz(TYPE_INT)
     D   decpos                       3U 0 inz(0)
     D   digits                       3U 0 inz(0)
     D                               10I 0 inz(0)

     D TYPE_INT        c                   const(x'00')
     D TYPE_FLOAT      c                   const(x'01')
     D TYPE_ZONED      c                   const(x'02')
     D TYPE_PACKED     c                   const(x'03')
     D TYPE_CHAR       c                   const(x'04')
     D TYPE_UINT       c                   const(x'0A')

     D LBCPYNV         PR                  extproc('_LBCPYNV')
     D   Output                        *   value
     D   OutAttr                           likeds(LBCPYNV_attr_t) const
     D   Input                         *   value
     D   InpAttr                           likeds(LBCPYNV_attr_t) const
