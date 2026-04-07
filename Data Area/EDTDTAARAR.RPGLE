      *===============================================================
      * To compile:
      *
      *     CRTBNDRPG PGM(XXXLIB/EDT101RG) SRCMBR(EDT101RG)
      *
      *===============================================================
     H DftActGrp(*no)

     FEDTDTAARADCF   E             WORKSTN
     F                                     SFILE(SFLRCD:RelRecNbr)
     f                                     infds(info)

     d Info            ds
     d  key                  369    369

     D Cmd             S           2100
     D CmdLen          S             15  5
     D DoRrn           S              5  0
     D DtaAraName      S             20
     d F03             c                   const(x'33')
     d F12             c                   const(x'3C')
     D Index           S              5  0
     D InDtaArea       S             10
     D InLIb           S             10
     D Len             S              5  0
     D OData           S           2000
     D OutData         S             50
     D OutPosN         S              4  0
     d Protect         c                   const(x'A0')
     d NonDisplay      c                   const(x'27')
     D ReceiveLen      S             10i 0
     D RelRecNbr       S              4  0
     D Remainder       S              5  0
     D Result          S              5  0
     D RtvLength       S             10i 0
     D Size            S              4  0
     D StrPosit        S             10i 0 inz(1)
     D X               S              5  0
     D Y               S              5  0
     D ChgCon          c                   'CHGDTAARA DTAARA('

     D Receiver        DS         32000    based(ReceiverPt)
     D  BytesAvl                     10i 0
     D  BytesAct                     10i 0
     D  TypeReturn                   10
     D  RecLib                       10
     D  RtnLength                    10i 0
     D  NbrDecimal                   10i 0
     D  RcvData                    2000

     D Receiver1       DS                  INZ
     D  BytesPoss              1      4B 0
     D  BytesRtrnd             5      8B 0

      *  API error data structure
     D ErrorDs         DS                  INZ
     D  BytesProvd             1      4B 0 inz(116)
     D  BytesAvail             5      8B 0
     D  MessageId              9     15
     D  Err###                16     16

     D PackedNums      DS
     D  packed1                1      1p 0
     D  packed2                1      2p 0
     D  packed3                1      3p 0
     D  packed4                1      4p 0
     D  packed5                1      5p 0
     D  packed6                1      6p 0
     D  packed7                1      7p 0
     D  packed8                1      8p 0
     D  packed9                1      9p 0
     D  packed10               1     10p 0
     D  packed11               1     11p 0
     D  packed12               1     12p 0
     D  packed13               1     13p 0
     D  packed14               1     14p 0
     D  packed15               1     15p 0

     C     *ENTRY        PLIST
     C                   PARM                    DtaAraName
     C                   movel     DtaAraName    InDtaArea
     C                   move      DtaAraName    InLib

     c                   movel     InDtaArea     DtaAraName
     c                   move      InLib         DtaAraName
      *
     C                   CALL      'QWCRDTAA'
     C                   PARM                    Receiver1
     C                   PARM      8             ReceiveLen
     C                   PARM                    DtaAraName
     C                   PARM      -1            StrPosit
     C                   PARM      32000         RtvLength
     C                   PARM                    ErrorDs

     c                   alloc     BytesPoss     ReceiverPt

     C                   CALL      'QWCRDTAA'
     C                   PARM                    Receiver
     C                   PARM      BytesPoss     ReceiveLen
     C                   PARM                    DtaAraName
     C                   PARM      -1            StrPosit
     C                   PARM      BytesPoss     RtvLength
     C                   PARM                    ErrorDs

     c                   z-add     RtnLength     Size
     c                   z-add     RtnLength     Len
     c                   If        Len > 50
     c                   eval      Len = 50
     c                   Endif
     c                   z-add     RtnLength     OutLen
     c                   z-add     NbrDecimal    OutDec
     c                   Eval      Outtyp = TypeReturn

     c                   Eval      Index = 37
     c                   Eval      OutPosN = 1

     c                   Dou       (Index + Len) > BytesPoss

     c                   If        (Index + Len) > BytesPoss
     c                   Eval      Len = (BytesPoss - Index) + 1
     c                   else
     c                   Eval      Len = 50
     c                   If        Len > Rtnlength
     c                   Eval      Len = RtnLength
     c                   Endif
     c                   End

     c                   Eval      Data = %subst(Receiver:Index:Len)

     c                   If        TypeReturn = '*DEC'
     c                   movel     data          PackedNums
     c                   select
     c                   When      Len <= 1
     c                   movel     Packed1       OutData
     c                   When      Len <= 2
     c                   movel     Packed2       OutData
     c                   When      Len <= 3
     c                   movel     Packed3       OutData
     c                   When      Len <= 4
     c                   movel     Packed4       OutData
     c                   When      Len <= 5
     c                   movel     Packed5       OutData
     c                   When      Len <= 6
     c                   movel     Packed6       OutData
     c                   When      Len <= 7
     c                   movel     Packed7       OutData
     c                   When      Len <= 8
     c                   movel     Packed8       OutData
     c                   When      Len <= 9
     c                   movel     Packed9       OutData
     c                   When      Len <= 10
     c                   movel     Packed10      OutData
     c                   When      Len <= 11
     c                   movel     Packed11      OutData
     c                   When      Len <= 12
     c                   movel     Packed12      OutData
     c                   When      Len <= 13
     c                   movel     Packed13      OutData
     c                   When      Len <= 14
     c                   movel     Packed14      OutData
     c                   When      Len <= 15
     c                   movel     Packed15      OutData
     c                   endsl
     c     RtnLength     Div       2             Result
     c                   Mvr                     Remainder
     c                   if        Remainder <> 0
     c                   movel(p)  OutData       Data
     c                   else
     c                   eval      Data = %subst(OutData:2:RtnLength)
     c                   Endif
     c                   Eval      %subst(Data:RtnLength + 2:1) = Protect
     c                   Eval      %subst(Data:RtnLength + 1:1) = NonDisplay
     c                   else
     c                   If        Len < 50
     c                   Eval      %subst(Data:RtnLength + 2:1) = Protect
     c                   Eval      %subst(Data:RtnLength + 1:1) = NonDisplay
     c                   Endif
     c                   Endif

     c                   EVAL      RelRecNbr = RelRecNbr + 1
     c                   move      OutPosN       OutPos
     C                   WRITE     SFLRCD
     c                   Eval      OutPosN = OutPosN + 50

     c                   Eval      Index = Index + Len

     c                   Enddo

     c                   If        Index < BytesPoss
     c                   eval      Len = (BytesPoss - Index) + 1
     c                   Eval      Data = %subst(Receiver:Index:Len)
     c                   If        len <> 50
     c                   Eval      %subst(Data:Len + 2:1) = Protect
     c                   Eval      %subst(Data:Len + 1:1) = NonDisplay
     c                   Endif
     C                   Eval      RelRecNbr = RelRecNbr + 1
     c                   move      OutPosN       OutPos
     C                   WRITE     SFLRCD
     c                   Endif

     c                   If        RelRecNbr > 0
     C                   Eval      *In21 = *ON
     C                   Endif
     C                   WRITE     FORMAT1
     C                   EXFMT     SFLCTL

     c                   If        Key <> F03 AND
     c                             Key <> F12
     c                   Exsr      UpdateSR
     c                   Endif
     c                   Eval      *inlr = *on

     c     UpdateSR      Begsr
     c                   Eval      DoRRN = RelRecNbr
     c                   Eval      Index = 1

     c                   Do        DoRRN         x
     c     x             chain     SflRcd
     c                   eval      %subsT(OData:Index:50) = Data
     c                   eval      index = Index + 50
     c                   enddo

     c                   If        TypeReturn <> '*DEC'
     c                   Eval      Cmd = ChgCon + %trim(Inlib) + '/' +
     c                             %trim(InDtaArea) +
     c                             ') VALUE(''' + %subst(OData:1:Size) +
     c                                 ''')'
     c                   Else
     c                   Eval      Cmd = ChgCon + %trim(Inlib) + '/' +
     c                             %trim(InDtaArea) + ') VALUE(' +
     c                              %subst(OData:1:(outlen-outdec)) +
     c                              '.'                             +
     c                              %subst(OData:(outlen-outdec+1):outdec) + ')'
     c*                  Eval      Cmd = ChgCon + %trim(Inlib) + '/' +
     c*                            %trim(InDtaArea) + ') VALUE(' +
     c*                             %subst(OData:1:Size) + ')'
     c                   Endif
     c
     c     ' '           Checkr    Cmd           Len
     c                   z-add     Len           CmdLen
     c                   call      'QCMDEXC'
     c                   parm                    Cmd
     c                   parm                    CmdLen
     c                   Endsr
