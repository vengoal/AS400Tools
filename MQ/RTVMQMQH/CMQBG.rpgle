     /****************************************************************/
     /*                                                              */
     /*                       IBM MQ for IBM i                       */
     /*                                                              */
     /*      FILE NAME:      CMQBC                                   */
     /*                                                              */
     /*      DESCRIPTION:    Declarations for MQ Administration      */
     /*                      Interface                               */
     /*                                                              */
     /****************************************************************/
     /****************************************************************/

     /*      Values Related to Specific Functions                    */
     /****************************************************************/

     /* Create-Bag Options for mqCreateBag */
     D MQCBONONE       C                   CONST(x'00000000')
     D MQCBOUSERBAG    C                   CONST(x'00000000')
     D MQCBOADMINBAG   C                   CONST(x'00000001')
     D MQCBOCMDBAG     C                   CONST(x'00000010')
     D MQCBOSYSTEMBAG  C                   CONST(x'00000020')
     D MQCBOGROUPBAG   C                   CONST(x'00000040')
     D MQCBOLSTFRMALW  C                   CONST(x'00000002')
     D MQCBOLSTFRMINH  C                   CONST(x'00000000')
     D MQCBOREORDASRQ  C                   CONST(x'00000004')
     D MQCBODONOTREOR  C                   CONST(x'00000000')
     D MQCBOCHKSELECT  C                   CONST(x'00000008')
     D MQCBODONOTCHKS  C                   CONST(x'00000000')

     /* Buffer Length for mqAddString and mqSetString */
     D MQBL_NULL_TERM  C                   CONST(-1)

     /* Item Types for mqInquireItemInfo */
     D MQITEM_INT      C                   CONST(1)
     D MQITEM_STR      C                   CONST(2)
     D MQITEM_BAG      C                   CONST(3)
     D MQITEM_BST      C                   CONST(4)
     D MQITEM_INT_FIL  C                   CONST(5)
     D MQITEM_STR_FIL  C                   CONST(6)
     D MQITEM_INT64    C                   CONST(7)
     D MQITEM_BSF      C                   CONST(8)

     /*  */
     D MQIT_INTEGER    C                   CONST(1)
     D MQIT_STRING     C                   CONST(2)
     D MQIT_BAG        C                   CONST(3)

     /****************************************************************/
     /* Values Related to Most Functions                             */
     /****************************************************************/

     /* Handle Selectors */
     D MQHA_FIRST      C                   CONST(4001)
     D MQHA_BAG_HDL    C                   CONST(4001)
     D MQHA_LAST_USED  C                   CONST(4001)
     D MQHA_LAST       C                   CONST(6000)

     /* Limits for Selectors for Object Attributes */
     D MQOA_FIRST      C                   CONST(1)
     D MQOA_LAST       C                   CONST(9000)

     /* Integer System Selectors */
     D MQIASY_FIRST    C                   CONST(-1)
     D MQIASY_CCSID    C                   CONST(-1)
     D MQIASY_TYPE     C                   CONST(-2)
     D MQIASY_COMMAND  C                   CONST(-3)
     D MQIASY_MSGSEQN  C                   CONST(-4)
     D MQIASY_CONTROL  C                   CONST(-5)
     D MQIASY_COMPCOD  C                   CONST(-6)
     D MQIASY_REASON   C                   CONST(-7)
     D MQIASY_BAGOPT   C                   CONST(-8)
     D MQIASY_VERSION  C                   CONST(-9)
     D MQIASY_LSTUSED  C                   CONST(-9)
     D MQIASY_LAST     C                   CONST(-2000)

     /* Special Selector Values */
     D MQSEL_ANY       C                   CONST(-30001)
     D MQSEL_ANYUSR    C                   CONST(-30002)
     D MQSEL_ANYSYS    C                   CONST(-30003)
     D MQSEL_ALLSLTR   C                   CONST(-30001)
     D MQSEL_ALLUSR    C                   CONST(-30002)
     D MQSEL_ALLSYS    C                   CONST(-30003)

     /* Special Index Values */
     D MQIND_NONE      C                   CONST(-1)
     D MQIND_ALL       C                   CONST(-2)

     /* Bag Handles */
     D MQHB_UNUSBLHB   C                   CONST(-1)
     D MQHB_NONE       C                   CONST(-2)

     /****************************************************************/
     /* Simple Data Types                                            */
     /****************************************************************/

     D MQHBAG          S             10I 0
      * typedef MQHBAG MQPOINTER PMQHBAG;

     /****************************************************************/
     /* mqAddBag Function -- Add Nested Bag to Bag                   */
     /****************************************************************/
     D******************************************************************
     D* mqAddBag Function -- Add Nested Bag to Bag                    **
     D******************************************************************
      * void MQENTRY mqAddBag (
      * MQHBAG   Bag,        /* I: Bag handle */
      * MQLONG   Selector,   /* I: Item selector */
      * MQHBAG   ItemValue,  /* I: Item value */
      * PMQLONG  pCompCode,  /* OC: Completion code */
      * PMQLONG  pReason);   /* OR: Reason code qualifying CompCode */

     DMQADDBG          PR                  EXTPROC('mqAddBag')
     D* I: Bag handle
     D HBAG                          10I 0 Value
     D* I: Item selectore
     D ITEMSLTR                      10I 0 Value
     D* I: Item value
     D ITEMVALUE                     10I 0 Value
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0

     /****************************************************************/
     /* mqAddByteString Function -- Add Byte String to Bag           */
     /****************************************************************/

     /* void MQENTRY mqAddByteString (
      *   MQHBAG   Bag,           /* I: Bag handle */
      *   MQLONG   Selector,      /* I: Item selector */
      *   MQLONG   BufferLength,  /* IL: Length of buffer */
      *   PMQBYTE  pBuffer,       /* IB: Buffer containing item value */
      *   PMQLONG  pCompCode,     /* OC: Completion code */
      *   PMQLONG  pReason);      /* OR: Reason code qualifying CompCode */

     DMQADDBS          PR                  EXTPROC('mqAddByteString')
     D* I: Bag handlendle
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* Message data
     D BUFFER                          *   VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqAddByteStringFilter Function -- Add Byte String Filter to  */
     /* Bag                                                          */
     /****************************************************************/

     /* void MQENTRY mqAddByteStringFilter (
      *   MQHBAG   Bag,           /* I: Bag handle */
      *   MQLONG   Selector,      /* I: Item selector */
      *   MQLONG   BufferLength,  /* IL: Length of buffer */
      *   PMQBYTE  pBuffer,       /* IB: Buffer containing item value */
      *   MQLONG   Operator,      /* I: Item operator */
      *   PMQLONG  pCompCode,     /* OC: Completion code */
      *   PMQLONG  pReason);      /* OR: Reason code qualifying CompCode */

     DMQADDBF          PR                  EXTPROC('mqAddByteStringFilter')
     D* I: Bag handlendle
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* Message data
     D BUFFER                          *   VALUE
     D* I: Item operator
     D ITEMOPTR                      10I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqAddInquiry Function -- Add an Inquiry Item to Bag          */
     /****************************************************************/

     /* void MQENTRY mqAddInquiry (
      *   MQHBAG   Bag,        /* I: Bag handle */
      *   MQLONG   Selector,   /* I: Attribute selector */
      *   PMQLONG  pCompCode,  /* OC: Completion code */
      *   PMQLONG  pReason);   /* OR: Reason code qualifying CompCode */

     DMQADDIQ          PR                  EXTPROC('mqAddInquiry')
     D* I: Bag handlendle
     D HBAG                          10I 0 VALUE
     D* I: Attribute selector
     D ATRSLTR                       10I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqAddInteger Function -- Add Integer to Bag                  */
     /****************************************************************/

     /* void MQENTRY mqAddInteger (
      *   MQHBAG   Bag,        /* I: Bag handle */
      *   MQLONG   Selector,   /* I: Item selector */
      *   MQLONG   ItemValue,  /* I: Item value */
      *   PMQLONG  pCompCode,  /* OC: Completion code */
      *   PMQLONG  pReason);   /* OR: Reason code qualifying CompCode */

     DMQADDIN          PR                  EXTPROC('mqAddInteger')
     D* I: Bag handlendle
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item value
     D ITEMVALUE                     10I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqAddInteger64 Function -- Add 64-bit Integer to Bag         */
     /****************************************************************/

     /* void MQENTRY mqAddInteger64 (
      *   MQHBAG   Bag,        /* I: Bag handle */
      *   MQLONG   Selector,   /* I: Item selector */
      *   MQINT64  ItemValue,  /* I: Item value */
      *   PMQLONG  pCompCode,  /* OC: Completion code */
      *   PMQLONG  pReason);   /* OR: Reason code qualifying CompCode */

     DMQADD64          PR                  EXTPROC('mqAddInteger64')
     D* I: Bag handlendle
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item value
     D ITEMVALUE                     20I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqAddIntegerFilter Function -- Add Integer Filter to Bag     */
     /****************************************************************/

     /* void MQENTRY mqAddIntegerFilter (
      *   MQHBAG   Bag,        /* I: Bag handle */
      *   MQLONG   Selector,   /* I: Item selector */
      *   MQLONG   ItemValue,  /* I: Item value */
      *   MQLONG   Operator,   /* I: Item operator */
      *   PMQLONG  pCompCode,  /* OC: Completion code */
      *   PMQLONG  pReason);   /* OR: Reason code qualifying CompCode */

     DMQADDIF          PR                  EXTPROC('mqAddIntegerFilter')
     D* I: Bag handlendle
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item value
     D ITEMVALUE                     10I 0 VALUE
     D* I: Item operator
     D ITEMOPTR                      10I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqAddString Function -- Add String to Bag                    */
     /****************************************************************/

      * void MQENTRY mqAddString (
      *   MQHBAG   Bag,           /* I: Bag handle */
      *   MQLONG   Selector,      /* I: Item selector */
      *   MQLONG   BufferLength,  /* IL: Length of buffer */
      *   PMQCHAR  pBuffer,       /* IB: Buffer containing item value */
      *   PMQLONG  pCompCode,     /* OC: Completion code */
      *   PMQLONG  pReason);      /* OR: Reason code qualifying CompCode */

     DMQADDST          PR                  EXTPROC('mqAddString')
     D* I: Bag handlendle
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* Buffer containing item value
     D BUFFER                          *   VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqAddStringFilter Function -- Add String Filter to Bag       */
     /****************************************************************/

     /* void MQENTRY mqAddStringFilter (
      *   MQHBAG   Bag,           /* I: Bag handle */
      *   MQLONG   Selector,      /* I: Item selector */
      *   MQLONG   BufferLength,  /* IL: Length of buffer */
      *   PMQCHAR  pBuffer,       /* IB: Buffer containing item value */
      *   MQLONG   Operator,      /* I: Item operator */
      *   PMQLONG  pCompCode,     /* OC: Completion code */
      *   PMQLONG  pReason);      /* OR: Reason code qualifying CompCode */

     DMQADDSF          PR                  EXTPROC('mqAddStringFilter')
     D* I: Bag handlendle
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* Message data
     D BUFFER                          *   VALUE
     D* I: Item operator
     D ITEMOPTR                      10I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqBagToBuffer Function -- Convert Bag to PCF                 */
     /****************************************************************/

     /* void MQENTRY mqBagToBuffer (
      *   MQHBAG   OptionsBag,    /* I: Handle of options bag */
      *   MQHBAG   DataBag,       /* I: Handle of data bag */
      *   MQLONG   BufferLength,  /* IL: Length of buffer */
      *   PMQVOID  pBuffer,       /* OB: Buffer to contain PCF */
      *   PMQLONG  pDataLength,   /* OL: Length of PCF returned in buffer */
      *   PMQLONG  pCompCode,     /* OC: Completion code */
      *   PMQLONG  pReason);      /* OR: Reason code qualifying CompCode */

     DMQBG2BF          PR                  EXTPROC('mqBagToBuffer')
     D* I: Handle of options bag
     D HBAGOPT                       10I 0 VALUE
     D* I: Handle of data bag
     D HBAGDATA                      10I 0 VALUE
     D* Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* OB: Buffer to contain PCF
     D BUFFER                          *
     D* OL: Length of PCF returned in buffer
     D DataLen                       10I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqBufferToBag Function -- Convert PCF to Bag                 */
     /****************************************************************/

     /* void MQENTRY mqBufferToBag (
      *   MQHBAG   OptionsBag,    /* I: Handle of options bag */
      *   MQLONG   BufferLength,  /* IL: Length of buffer */
      *   PMQVOID  pBuffer,       /* IB: Buffer containing PCF */
      *   MQHBAG   DataBag,       /* IO: Handle of bag to contain data */
      *   PMQLONG  pCompCode,     /* OC: Completion code */
      *   PMQLONG  pReason);      /* OR: Reason code qualifying CompCode */

     DMQBF2BG          PR                  EXTPROC('mqBufferToBag')
     D* I: Handle of options bag
     D HBAGOPT                       10I 0 VALUE
     D* IL: Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* IB: Buffer to contain PCF
     D BUFFER                          *
     D* IO: Handle of data bag to contain data
     D HBAGDATA                      10I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqClearBag Function -- Delete All Items in Bag               */
     /****************************************************************/

     /* void MQENTRY mqClearBag (
      *   MQHBAG   Bag,        /* I: Bag handle */
      *   PMQLONG  pCompCode,  /* OC: Completion code */
      *   PMQLONG  pReason);   /* OR: Reason code qualifying CompCode */

     DMQCLRBG          PR                  EXTPROC('mqClearBag')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqCountItems Function -- Count Items in Bag                  */
     /****************************************************************/

     /* void MQENTRY mqCountItems (
      *   MQHBAG   Bag,         /* I: Bag handle */
      *   MQLONG   Selector,    /* I: Item selector */
      *   PMQLONG  pItemCount,  /* O: Number of items */
      *   PMQLONG  pCompCode,   /* OC: Completion code */
      *   PMQLONG  pReason);    /* OR: Reason code qualifying CompCode */

     DMQCNTIT          PR                  EXTPROC('mqCountItems')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* O: Number of items
     D ITEMCOUNT                     10I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqCreateBag Function -- Create Bag                           */
     /****************************************************************/

     /* void MQENTRY mqCreateBag (
      *   MQLONG   Options,    /* I: Bag options */
      *   PMQHBAG  pBag,       /* O: Handle of bag created */
      *   PMQLONG  pCompCode,  /* OC: Completion code */
      *   PMQLONG  pReason);   /* OR: Reason code qualifying CompCode */

     DMQCRTBG          PR                  EXTPROC('mqCreateBag')
     D* I: Bag options
     D Options                       10I 0 VALUE
     D* O: Handle of bag created
     D HBAGOPT                       10I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqDeleteBag Function -- Delete Bag                           */
     /****************************************************************/

     /* void MQENTRY mqDeleteBag (
      *   PMQHBAG  pBag,       /* IO: Bag handle */
      *   PMQLONG  pCompCode,  /* OC: Completion code */
      *   PMQLONG  pReason);   /* OR: Reason code qualifying CompCode */

     DMQDELBG          PR                  EXTPROC('mqDeleteBag')
     D* I: Handle of bag
     D HBAG                          10I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqDeleteItem Function -- Delete Item in Bag                  */
     /****************************************************************/

     /* void MQENTRY mqDeleteItem (
      *   MQHBAG   Bag,        /* I: Bag handle */
      *   MQLONG   Selector,   /* I: Item selector */
      *   MQLONG   ItemIndex,  /* I: Item index */
      *   PMQLONG  pCompCode,  /* OC: Completion code */
      *   PMQLONG  pReason);   /* OR: Reason code qualifying CompCode */

     DMQDELIT          PR                  EXTPROC('mqDeleteItem')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqExecute Function -- Send Admin Command and Receive Reponse */
     /****************************************************************/

     /* void MQENTRY mqExecute (
      *   MQHCONN  Hconn,        /* I: Connection handle */
      *   MQLONG   Command,      /* I: Command identifier */
      *   MQHBAG   OptionsBag,   /* I: Handle of options bag */
      *   MQHBAG   AdminBag,     /* I: Handle of admin bag */
      *   MQHBAG   ResponseBag,  /* I: Handle of response bag */
      *   MQHOBJ   AdminQ,       /* I: Handle of admin queue */
      *   MQHOBJ   ResponseQ,    /* I: Handle of response queue */
      *   PMQLONG  pCompCode,    /* OC: Completion code */
      *   PMQLONG  pReason);     /* OR: Reason code qualifying CompCode */

     DMQEXEC           PR                  EXTPROC('mqExecute')
     D* I: Connection handle
     D HCONN                         10I 0 VALUE
     D* I: Command identifier
     D CMDID                         10I 0 VALUE
     D* I: Handle of options bag
     D OPTBAG                        10I 0 VALUE
     D* I: Handle of admin bag
     D ADMINBAG                      10I 0 VALUE
     D* I: Handle of response bag
     D RESPONSEBAG                   10I 0 VALUE
     D* I: Handle of admin queue
     D ADMINQ                        10I 0 VALUE
     D* I: Handle of response queue
     D RESPONSEQ                     10I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqGetBag Function -- Receive PCF Message into Bag            */
     /****************************************************************/

     /* void MQENTRY mqGetBag (
      *   MQHCONN  Hconn,        /* I: Connection handle */
      *   MQHOBJ   Hobj,         /* I: Queue handle */
      *   PMQVOID  pMsgDesc,     /* IO: Message descriptor */
      *   PMQVOID  pGetMsgOpts,  /* IO: Get-message options */
      *   MQHBAG   Bag,          /* IO: Handle of bag to contain message */
      *   PMQLONG  pCompCode,    /* OC: Completion code */
      *   PMQLONG  pReason);     /* OR: Reason code qualifying CompCode */


     /****************************************************************/
     /* mqInquireBag Function -- Inquire Handle in Bag               */
     /****************************************************************/

     /* void MQENTRY mqInquireBag (
      *   MQHBAG   Bag,         /* I: Bag handle */
      *   MQLONG   Selector,    /* I: Item selector */
      *   MQLONG   ItemIndex,   /* I: Item index */
      *   PMQHBAG  pItemValue,  /* O: Item value */
      *   PMQLONG  pCompCode,   /* OC: Completion code */
      *   PMQLONG  pReason);    /* OR: Reason code qualifying CompCode */

     DMQINQBG          PR                  EXTPROC('mqInquireBag')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* O: Item value
     D ITEMVALUE                     10I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqInquireByteString Function -- Inquire Byte String in Bag   */
     /****************************************************************/

     /* void MQENTRY mqInquireByteString (
      *   MQHBAG   Bag,                /* I: Bag handle */
      *   MQLONG   Selector,           /* I: Item selector */
      *   MQLONG   ItemIndex,          /* I: Item index */
      *   MQLONG   BufferLength,       /* IL: Length of buffer */
      *   PMQBYTE  pBuffer,            /* OB: Buffer to contain string */
      *   PMQLONG  pByteStringLength,  /* O: Length of byte string returned */
      *   PMQLONG  pCompCode,          /* OC: Completion code */
      *   PMQLONG  pReason);           /* OR: Reason code qualifying CompCode */


     DMQINQBS          PR                  EXTPROC('mqInquireByteString')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* IL: Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* OB: Buffer to contain string
     D BUFFER                          *
     D* O: Length of byte string returned
     D OUTBUFLEN                     10I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqInquireByteStringFilter Function -- Inquire Byte String    */
     /* Filter in Bag                                                */
     /****************************************************************/

     /* void MQENTRY mqInquireByteStringFilter (
      *   MQHBAG   Bag,                /* I: Bag handle */
      *   MQLONG   Selector,           /* I: Item selector */
      *   MQLONG   ItemIndex,          /* I: Item index */
      *   MQLONG   BufferLength,       /* IL: Length of buffer */
      *   PMQBYTE  pBuffer,            /* OB: Buffer to contain string */
      *   PMQLONG  pByteStringLength,  /* O: Length of byte string returned */
      *   PMQLONG  pOperator,          /* O: Item operator */
      *   PMQLONG  pCompCode,          /* OC: Completion code */
      *   PMQLONG  pReason);           /* OR: Reason code qualifying CompCode */

     DMQINQBF          PR                  EXTPROC('mqInquireByteStringFilter')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* IL: Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* OB: Buffer to contain string
     D BUFFER                          *
     D* O: Length of byte string returned
     D OUTBUFLEN                     10I 0
     D* O: Item operator
     D ITEMOPERATOR                  10I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqInquireInteger Function -- Inquire Integer in Bag          */
     /****************************************************************/

     /* void MQENTRY mqInquireInteger (
      *   MQHBAG   Bag,         /* I: Bag handle */
      *   MQLONG   Selector,    /* I: Item selector */
      *   MQLONG   ItemIndex,   /* I: Item index */
      *   PMQLONG  pItemValue,  /* O: Item value */
      *   PMQLONG  pCompCode,   /* OC: Completion code */
      *   PMQLONG  pReason);    /* OR: Reason code qualifying CompCode */

     DMQINQIN          PR                  EXTPROC('mqInquireInteger')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* O: Item value
     D ITEMVALUE                     10I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqInquireInteger64 Function -- Inquire 64-bit Integer in Bag */
     /****************************************************************/

     /* void MQENTRY mqInquireInteger64 (
      *   MQHBAG    Bag,         /* I: Bag handle */
      *   MQLONG    Selector,    /* I: Item selector */
      *   MQLONG    ItemIndex,   /* I: Item index */
      *   PMQINT64  pItemValue,  /* O: Item value */
      *   PMQLONG   pCompCode,   /* OC: Completion code */
      *   PMQLONG   pReason);    /* OR: Reason code qualifying CompCode */

     DMQINQ64          PR                  EXTPROC('mqInquireInteger64')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* O: Item value
     D ITEMVALUE                     20I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqInquireIntegerFilter Function -- Inquire Integer Filter in */
     /* Bag                                                          */
     /****************************************************************/

     /* void MQENTRY mqInquireIntegerFilter (
      *   MQHBAG   Bag,         /* I: Bag handle */
      *   MQLONG   Selector,    /* I: Item selector */
      *   MQLONG   ItemIndex,   /* I: Item index */
      *   PMQLONG  pItemValue,  /* O: Item value */
      *   PMQLONG  pOperator,   /* O: Item operator */
      *   PMQLONG  pCompCode,   /* OC: Completion code */
      *   PMQLONG  pReason);    /* OR: Reason code qualifying CompCode */

     DMQINQIF          PR                  EXTPROC('mqInquireIntegerFilter')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* O: Item value
     D ITEMVALUE                     10I 0
     D* O: Item operator
     D ITEMOPERATOR                  10I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqInquireItemInfo Function -- Inquire Attributes of Item in  */
     /* Bag                                                          */
     /****************************************************************/

     /* void MQENTRY mqInquireItemInfo (
      *   MQHBAG   Bag,           /* I: Bag handle */
      *   MQLONG   Selector,      /* I: Item selector */
      *   MQLONG   ItemIndex,     /* I: Item index */
      *   PMQLONG  pOutSelector,  /* O: Selector of item */
      *   PMQLONG  pItemType,     /* O: Data type of item */
      *   PMQLONG  pCompCode,     /* OC: Completion code */
      *   PMQLONG  pReason);      /* OR: Reason code qualifying CompCode */

     DMQINQIT          PR                  EXTPROC('mqInquireItemInfo')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* O: Selector of item
     D OUTITEMSLTR                   10I 0
     D* O: Data type of item
     D ITEMTYPE                      10I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqInquireString Function -- Inquire String in Bag            */
     /****************************************************************/

     /* void MQENTRY mqInquireString (
      *   MQHBAG   Bag,              /* I: Bag handle */
      *   MQLONG   Selector,         /* I: Item selector */
      *   MQLONG   ItemIndex,        /* I: Item index */
      *   MQLONG   BufferLength,     /* IL: Length of buffer */
      *   PMQCHAR  pBuffer,          /* OB: Buffer to contain string */
      *   PMQLONG  pStringLength,    /* O: Length of string returned */
      *   PMQLONG  pCodedCharSetId,  /* O: Character-set identifier of string */
      *   PMQLONG  pCompCode,        /* OC: Completion code */
      *   PMQLONG  pReason);         /* OR: Reason code qualifying CompCode */

     DMQINQST          PR                  EXTPROC('mqInquireString')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* IL: Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* OB: Buffer to contain string
     D BUFFER                          *   VALUE
     D* O: Length of string returned
     D STRLEN                        10I 0
     D* O: Character-set identifier of string
     D OUTCCSID                      10I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqInquireStringFilter Function -- Inquire String Filter in   */
     /* Bag                                                          */
     /****************************************************************/

     /* void MQENTRY mqInquireStringFilter (
      *   MQHBAG   Bag,              /* I: Bag handle */
      *   MQLONG   Selector,         /* I: Item selector */
      *   MQLONG   ItemIndex,        /* I: Item index */
      *   MQLONG   BufferLength,     /* IL: Length of buffer */
      *   PMQCHAR  pBuffer,          /* OB: Buffer to contain string */
      *   PMQLONG  pStringLength,    /* O: Length of string returned */
      *   PMQLONG  pCodedCharSetId,  /* O: Character-set identifier of string */
      *   PMQLONG  pOperator,        /* O: Item operator */
      *   PMQLONG  pCompCode,        /* OC: Completion code */
      *   PMQLONG  pReason);         /* OR: Reason code qualifying CompCode */

     DMQINQSF          PR                  EXTPROC('mqInquireStringFilter')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* IL: Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* OB: Buffer to contain string
     D BUFFER                          *
     D* O: Length of string returned
     D STRLEN                        10I 0
     D* O: Character-set identifier of string
     D OUTCCSID                      10I 0
     D* O: Item operator
     D OPERATOR                      10I 0
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqPad Function -- Pad Null-terminated String with Blanks     */
     /****************************************************************/

     /* void MQENTRY mqPad (
      *   PMQCHAR  pString,       /* I: Null-terminated string to be padded */
      *   MQLONG   BufferLength,  /* IL: Length of buffer */
      *   PMQCHAR  pBuffer,       /* OB: Buffer to contain padded string */
      *   PMQLONG  pCompCode,     /* OC: Completion code */
      *   PMQLONG  pReason);      /* OR: Reason code qualifying CompCode */


     /****************************************************************/
     /* mqPutBag Function -- Send Bag as PCF Message                 */
     /****************************************************************/

     /* void MQENTRY mqPutBag (
      *   MQHCONN  Hconn,        /* I: Connection handle */
      *   MQHOBJ   Hobj,         /* I: Queue handle */
      *   PMQVOID  pMsgDesc,     /* IO: Message descriptor */
      *   PMQVOID  pPutMsgOpts,  /* IO: Put-message options */
      *   MQHBAG   Bag,          /* I: Handle of bag containing message data */
      *   PMQLONG  pCompCode,    /* OC: Completion code */
      *   PMQLONG  pReason);     /* OR: Reason code qualifying CompCode */


     /****************************************************************/
     /* mqSetByteString Function -- Modify Byte String in Bag        */
     /****************************************************************/

     /* void MQENTRY mqSetByteString (
      *   MQHBAG   Bag,           /* I: Bag handle */
      *   MQLONG   Selector,      /* I: Item selector */
      *   MQLONG   ItemIndex,     /* I: Item index */
      *   MQLONG   BufferLength,  /* I: Length of buffer */
      *   PMQBYTE  pBuffer,       /* I: Buffer containing item value */
      *   PMQLONG  pCompCode,     /* OC: Completion code */
      *   PMQLONG  pReason);      /* OR: Reason code qualifying CompCode */

     DMQSETBS          PR                  EXTPROC('mqSetByteString')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* IL: Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* I: Buffer to contain item value
     D BUFFER                          *
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqSetByteStringFilter Function -- Modify Byte String Filter  */
     /* in Bag                                                       */
     /****************************************************************/

     /* void MQENTRY mqSetByteStringFilter (
      *   MQHBAG   Bag,           /* I: Bag handle */
      *   MQLONG   Selector,      /* I: Item selector */
      *   MQLONG   ItemIndex,     /* I: Item index */
      *   MQLONG   BufferLength,  /* IL: Length of buffer */
      *   PMQBYTE  pBuffer,       /* IB: Buffer containing item value */
      *   MQLONG   Operator,      /* I: Item operator */
      *   PMQLONG  pCompCode,     /* OC: Completion code */
      *   PMQLONG  pReason);      /* OR: Reason code qualifying CompCode */

     DMQSETBF          PR                  EXTPROC('mqSetByteString')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* IL: Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* I: Buffer to contain item value
     D BUFFER                          *
     D* I: Item operator
     D OPERATOR                        *
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqSetInteger Function -- Modify Integer in Bag               */
     /****************************************************************/

     /* void MQENTRY mqSetInteger (
      *   MQHBAG   Bag,        /* I: Bag handle */
      *   MQLONG   Selector,   /* I: Item selector */
      *   MQLONG   ItemIndex,  /* I: Item index */
      *   MQLONG   ItemValue,  /* I: Item value */
      *   PMQLONG  pCompCode,  /* OC: Completion code */
      *   PMQLONG  pReason);   /* OR: Reason code qualifying CompCode */

     DMQSETIN          PR                  EXTPROC('mqSetInteger')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* I: Item value
     D ITEMVALUE                     10I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqSetInteger64 Function -- Modify 64-bit Integer in Bag      */
     /****************************************************************/

     /* void MQENTRY mqSetInteger64 (
      *   MQHBAG   Bag,        /* I: Bag handle */
      *   MQLONG   Selector,   /* I: Item selector */
      *   MQLONG   ItemIndex,  /* I: Item index */
      *   MQINT64  ItemValue,  /* I: Item value */
      *   PMQLONG  pCompCode,  /* OC: Completion code */
      *   PMQLONG  pReason);   /* OR: Reason code qualifying CompCode */

     DMQSET64          PR                  EXTPROC('mqSetInteger64')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* I: Item value
     D ITEMVALUE                     20I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqSetIntegerFilter Function -- Modify Integer Filter in Bag  */
     /****************************************************************/

     /* void MQENTRY mqSetIntegerFilter (
      *   MQHBAG   Bag,        /* I: Bag handle */
      *   MQLONG   Selector,   /* I: Item selector */
      *   MQLONG   ItemIndex,  /* I: Item index */
      *   MQLONG   ItemValue,  /* I: Item value */
      *   MQLONG   Operator,   /* I: Item operator */
      *   PMQLONG  pCompCode,  /* OC: Completion code */
      *   PMQLONG  pReason);   /* OR: Reason code qualifying CompCode */

     DMQSETIF          PR                  EXTPROC('mqSetIntegerFilter')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* I: Item value
     D ITEMVALUE                     10I 0 VALUE
     D* I: Item operator
     D OPERATOR                      10I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqSetString Function -- Modify String in Bag                 */
     /****************************************************************/

     /* void MQENTRY mqSetString (
      *   MQHBAG   Bag,           /* I: Bag handle */
      *   MQLONG   Selector,      /* I: Item selector */
      *   MQLONG   ItemIndex,     /* I: Item index */
      *   MQLONG   BufferLength,  /* IL: Length of buffer */
      *   PMQCHAR  pBuffer,       /* IB: Buffer containing item value */
      *   PMQLONG  pCompCode,     /* OC: Completion code */
      *   PMQLONG  pReason);      /* OR: Reason code qualifying CompCode */

     DMQSETST          PR                  EXTPROC('mqSetString')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* IL: Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* IB: Buffer to contain item value
     D BUFFER                          *
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0

     /****************************************************************/
     /* mqSetStringFilter Function -- Modify String Filter in Bag    */
     /****************************************************************/

     /* void MQENTRY mqSetStringFilter (
      *   MQHBAG   Bag,           /* I: Bag handle */
      *   MQLONG   Selector,      /* I: Item selector */
      *   MQLONG   ItemIndex,     /* I: Item index */
      *   MQLONG   BufferLength,  /* IL: Length of buffer */
      *   PMQCHAR  pBuffer,       /* IB: Buffer containing item value */
      *   MQLONG   Operator,      /* I: Item operator */
      *   PMQLONG  pCompCode,     /* OC: Completion code */
      *   PMQLONG  pReason);      /* OR: Reason code qualifying CompCode */

     DMQSETSF          PR                  EXTPROC('mqSetStringFilter')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Item selector
     D ITEMSLTR                      10I 0 VALUE
     D* I: Item index
     D ITEMINDEX                     10I 0 VALUE
     D* IL: Length of the Buffer
     D BUFLEN                        10I 0 VALUE
     D* IB: Buffer to contain item value
     D BUFFER                          *
     D* I: Item operator
     D OPERATOR                      10I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0


     /****************************************************************/
     /* mqTrim Function -- Replace Trailing Blanks with Null         */
     /* Character                                                    */
     /****************************************************************/

     /* void MQENTRY mqTrim (
      *   MQLONG   BufferLength,  /* IL: Length of buffer */
      *   PMQCHAR  pBuffer,       /* IB: Buffer containing blank-padded string */
      *   PMQCHAR  pString,       /* O: String with blanks discarded */
      *   PMQLONG  pCompCode,     /* OC: Completion code */
      *   PMQLONG  pReason);      /* OR: Reason code qualifying CompCode */


     /****************************************************************/
     /* mqTruncateBag Function -- Delete Trailing Items in Bag       */
     /****************************************************************/

     /* void MQENTRY mqTruncateBag (
      *   MQHBAG   Bag,        /* I: Bag handle */
      *   MQLONG   ItemCount,  /* I: Number of items to remain in bag */
      *   PMQLONG  pCompCode,  /* OC: Completion code */
      *   PMQLONG  pReason);   /* OR: Reason code qualifying CompCode */

     DMQTRNBG          PR                  EXTPROC('mqTruncateBag')
     D* I: Handle of bag
     D HBAG                          10I 0 VALUE
     D* I: Number of items to remain in bag
     D ITEMCOUNT                     10I 0 VALUE
     D* Completion code
     D CMPCOD                        10I 0
     D* Reason code qualifying CompCode
     D REASON                        10I 0
