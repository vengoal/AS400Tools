PGM
         Dcl        &NEWDAT       *Char    10
         Dcl        &SysDat       *Char    10

         ADDDATE    DAYS(10) NEWDAT(&NEWDAT) FRMDAT('112524') +
                          FRMDATFMT(*MDY) NEWDATFMT(*YYMD)
         SNDUSRMSG MSG('The date *MDY' *BCAT '112524' *BCAT 'add 10 days ' +
                        *BCAT '*YYMD' +
                        *BCAT &NEWDAT) MSGTYPE(*INFO)

         ADDDATE    DAYS(-10) NEWDAT(&NEWDAT) FRMDAT('112524') +
                          NEWDATFMT(*YYMD)
         SNDUSRMSG MSG('The date *MDY' *BCAT '112524' *BCAT 'sub 10 days ' +
                        *BCAT '*YYMD' +
                        *BCAT &NEWDAT) MSGTYPE(*INFO)

         ADDDATE    DAYS(10) NEWDAT(&NEWDAT) FRMDAT('112524') +
                          FRMDATFMT(*MDY) NEWDATFMT(*LONGJUL)
         SNDUSRMSG MSG('The date *MDY' *BCAT '112524' *BCAT 'add 10 days ' +
                        *BCAT '*LONGJUL' +
                        *BCAT &NEWDAT) MSGTYPE(*INFO)

         ADDDATE    DAYS(-10) NEWDAT(&NEWDAT) FRMDAT('112524') +
                          NEWDATFMT(*LONGJUL)
         SNDUSRMSG MSG('The date *MDY' *BCAT '112524' *BCAT 'sub 10 days ' +
                        *BCAT '*LONGJUL' +
                        *BCAT &NEWDAT) MSGTYPE(*INFO)

ENDPGM
