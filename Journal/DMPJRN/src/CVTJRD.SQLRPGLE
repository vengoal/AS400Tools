      *****************************************************************
      * ALL SOFTWARE IS PROVIDED "AS IS" WITHOUT ANY WARRANTY OF ANY
      * NATURE WHATSOEVER. THE PROVIDER OF THIS SOFTWARE HEREBY
      * DISCLAIMS ALL WARRANTIES, REPRESENTATIONS, AND CONDITIONS,
      * STATUATORY OR OTHERWISE, EXPRESS OR IMPLIED, INCLUDING BUT NOT
      * LIMITED TO WARRANTY OF TITLE AND THE IMPLIED WARRANTY OF
      * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE. THE
      * PROVIDER SHALL NOT BE LIABLE FOR ANY DAMAGES ARISING FROM OR AS
      * A RESULT OF YOUR USE OF THIS SOFTWARE. USE IT AS YOUR OWN RISK.
      *****************************************************************
     h debug option(*srcstmt : *nodebugio)

     d c1_dtls         ds
     d   dspjrnfil                   10
     d   dspjrnlib                   10

     d thispgm         pr                  extpgm('CVTJRD')
     d                               10
     d                               10
     d                               10
     d                               10
     d                               10
     d                               10
     d                                4
     d                             1000

     d thispgm         pi
     d   dspfil                      10
     d   dsplib                      10
     d   outfil                      10
     d   outlib                      10
     d   jrnfil                      10
     d   jrnlib                      10
     d   sqlcodechar                  4
     d   sqlcmd                    1000

      /free

       //šIf CVTJRNDTA JRNFILE(*AUTO) is not specified, read the DSPJRN
       //šoutfile to retrieve the name of the journaled file from fields
       //šJOOBJ and JOLIB.

       exec sql
         set option commit=*none;

       if jrnfil = '*AUTO     ';

         sqlcmd='select distinct joobj, jolib from ' +
                %trim(dsplib) + '/' + %trim(dspfil) +
                ' where joobj <> '' ''';

         exec sql
           prepare sel1 from :sqlcmd;
         if sqlcode<>0;
           sqlcodechar = %char(sqlcode);
           *inlr = *on;
           return;
           endif;

         exec sql
           declare c1 cursor for sel1;
         if sqlcode<>0;
           sqlcodechar = %char(sqlcode);
           *inlr = *on;
           return;
           endif;

         exec sql
           open c1;
         if sqlcode<>0;
           sqlcodechar = %char(sqlcode);
           *inlr = *on;
           return;
           endif;

         exec sql
           fetch next from c1 into :c1_dtls;
         if sqlcode<>0;
           sqlcodechar = %char(sqlcode);
           *inlr = *on;
           return;
           endif;

         exec sql
           close c1;
         if sqlcode<>0;
           sqlcodechar = %char(sqlcode);
           *inlr = *on;
           return;
           endif;

         jrnfil = dspjrnfil;
         jrnlib = dspjrnlib;
         endif;


       //šCreate the CVTJRNDTA output file using an SQL join between the
       //šDSPJRN output file, which contains the audit data, and the
       //šoriginal journaled file, which contains the user data.

       sqlcmd='create table ' + %trim(outlib) + '/' + %trim(outfil) +
              ' as (select joentl, joseqn, jocode, joentt, jodate, +
              jotime, jojob, jouser, jonbr, jopgm, joobj, jolib, +
              jombr, joctrr, joflag, joccid, joincdat, jominesd, +
              jores, ' + %trim(JrnFil) + '.* from ' +
              %trim(dsplib) + '/' + %trim(dspfil) + ', ' +
              %trim(jrnlib) + '/' + %trim(jrnfil) +
              ') with no data';

       exec sql
         prepare crt1 from :sqlcmd;
         if sqlcode<>0;
           sqlcodechar = %char(sqlcode);
           *inlr = *on;
           return;
           endif;

       exec sql
         execute crt1;
       //šSQLCODE 7905 = Table created but was not journaled
         if sqlcode<>0 and sqlcode<>7905;
           sqlcodechar = %char(sqlcode);
           *inlr = *on;
           return;
           endif;

       *inlr = *on;
       return;

      /end-free
