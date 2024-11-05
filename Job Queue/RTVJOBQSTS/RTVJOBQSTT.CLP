Pgm

   dcl   &Jobq          *char     10          'QBATCH'
   dcl   &JobqLib       *char     10          '*LIBL'
   dcl   &RtnLib        *char     10
   dcl   &Qstatus       *char     10
   dcl   &SbsNam        *char     10
   dcl   &SbsLib        *char     10
   dcl   &CurAct        *dec     ( 9 0 )
   dcl   &ScdJob        *dec     ( 9 0 )
   dcl   &HldJob        *dec     ( 9 0 )
   dcl   &RlsJob        *dec     ( 9 0 )

   monmsg cpf0000 exec(goto ERROR)

   RtvJobQSts JobQ(&JobqLib/&Jobq) +
              RtnLib(&RtnLib)      +
              Qstatus(&Qstatus)    +
              SbsNam(&SbsNam)      +
              SbsLib(&SbsLib)      +
              CurAct(&CurAct)      +
              ScdJob(&ScdJob)      +
              HldJob(&HldJob)      +
              RlsJob(&RlsJob)

   DmpCLPgm

   Return

 Error:
    MovDiagMsg
    Monmsg    CPF0000
    RsnEscMsg
    Monmsg    CPF0000

Endpgm
