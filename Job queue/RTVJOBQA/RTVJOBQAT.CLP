Pgm

   dcl   &Jobq          *char     10          'QBATCH'
   dcl   &JobqLib       *char     10          '*LIBL'
   dcl   &RtnLib        *char     10
   dcl   &OprCtl        *char     10
   dcl   &AutChk        *char     10
   dcl   &NbrJobs       *dec     ( 9 0 )
   dcl   &Qstatus       *char     10
   dcl   &SbsNam        *char     10
   dcl   &SbsLib        *char     10
   dcl   &SeqNbr        *dec     ( 9 0 )
   dcl   &MaxAct        *dec     ( 9 0 )
   dcl   &CurAct        *dec     ( 9 0 )
   dcl   &Text          *char     50

   monmsg cpf0000 exec(goto ERROR)

   RtvJobQA   JobQ(&JobqLib/&Jobq) +
              RtnLib(&RtnLib)      +
              OprCtl(&OprCtl)      +
              AutChk(&AutChk)      +
              NbrJobs(&NbrJobs)    +
              Qstatus(&Qstatus)    +
              SbsNam(&SbsNam)      +
              SbsLib(&SbsLib)      +
              SeqNbr(&SeqNbr)      +
              MaxAct(&MaxAct)      +
              CurAct(&CurAct)      +
              Text(&Text)

   DmpCLPgm

   Return

 Error:
    MovDiagMsg
    Monmsg    CPF0000
    RsnEscMsg
    Monmsg    CPF0000

Endpgm
