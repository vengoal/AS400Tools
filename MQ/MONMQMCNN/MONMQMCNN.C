#include <stdio.h>
#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include <recio.h>

#include <cmqc.h>                          /* MQI                             */
#include <cmqcfc.h>                        /* PCF                             */
#include <cmqbc.h>                         /* MQAI                            */
#include <cmqxc.h>                         /* MQCD                            */

#define  WAIT_TIME    5000                 /* wait time for mqexecute         */
#define  OUTPUTLEN    512                  /* Output buffer length            */

/******************************************************************************/
/* DataTypes                                                                  */
/******************************************************************************/
typedef _RFILE OUTFILEHDL;

OUTFILEHDL *outfp = NULL;               /* output file handle                 */

/******************************************************************************/
/* Macros                                                                     */
/******************************************************************************/
#define OUTFILE "%s/%s(%s)"
#define OPENOUTFILE(hdl, fname) \
  (hdl) = _Ropen((fname),"ar, rtncode=Y");
#define CLOSEOUTFILE(hdl) \
  _Rclose((hdl));
#define WRITEOUTFILE(hdl, buf, buflen) \
  _Rwrite((hdl),(buf),(buflen));

/******************************************************************************/
/* Function prototypes                                                        */
/******************************************************************************/
void CheckCallResult(MQCHAR *, MQLONG , MQLONG);

/******************************************************************************/
/* Function: main                                                             */
/******************************************************************************/
int main(int argc, char *argv[])
{
   /***************************************************************************/
   /* Parameter:                           I/O  Type Length                   */
   /* argv[1]: MQM name                     I   Char     48                   */
   /* argv[2]: File to receive output       I   Char     20                   */
   /* argv[3]: MQM API Reason code          O   Char      4                   */
   /***************************************************************************/

   /***************************************************************************/
   /* MQAI variables                                                          */
   /***************************************************************************/
   MQHCONN hConn;                          /* handle to MQ connection         */
   MQCHAR qmName[MQ_Q_MGR_NAME_LENGTH+1]=""; /* default QMgr name             */
   MQLONG reason;                          /* reason code                     */
   MQLONG trimReason;                          /* reason code                 */
   MQLONG connReason;                      /* MQCONN reason code              */
   MQLONG compCode;                        /* completion code                 */
   MQHBAG adminBag = MQHB_UNUSABLE_HBAG;   /* admin bag for mqExecute         */
   MQHBAG responseBag = MQHB_UNUSABLE_HBAG; /* response bag for mqExecute     */
   MQHBAG optionsBag = MQHB_UNUSABLE_HBAG; /* options bag for mqExecute       */
   MQHBAG qAttrsBag;                       /* bag containing qm attributes    */
   MQHBAG errorBag;                        /* bag containing cmd server error */
   MQLONG mqExecuteCC;                     /* mqExecute completion code       */
   MQLONG mqExecuteRC;                     /* mqExecute reason code           */
   MQLONG strAttrLength;                   /* Actual length of q name         */
   MQLONG intAttr;                         /* integer attribute returned      */
   MQLONG intApplType;                     /* integer attribute returned      */
   MQLONG intPrcId;                        /* integer attribute returned      */
   MQLONG intThrId;                        /* integer attribute returned      */
   MQLONG intObjType;                      /* integer attribute returned      */
   MQLONG first;                           /* loop counter                    */
   MQLONG i;                               /* loop counter                    */
   MQLONG j;                               /* loop counter                    */
   MQLONG k;                               /* loop counter                    */
   MQLONG x;                               /* loop counter                    */
   MQLONG infoType;                        /* loop counter                    */
   MQLONG numberOfBags;                    /* number of bags in response bag  */
   MQCHAR strAttr[512];                    /* string attribute returned       */
   MQCHAR qmgrStatus[10+1]="";             /* string attribute returned       */
   MQCHAR chlIniStatus[10+1]="";           /* string attribute returned       */
   MQCHAR cmdSvrStatus[10+1]="";           /* string attribute returned       */
   MQCHAR connCount[10+1]="";              /* string attribute returned       */
   MQCHAR genericConnId[1]= "";            /* GenericConnectionId             */
   MQCHAR connId[MQ_CONNECTION_ID_LENGTH+1]=""; /* Connection Id              */
   MQCHAR real_connId[16+1]="";            /* Connection Id                   */
   MQCHAR connInfoType[6+1]="";            /* Connection Info Type            */
   MQCHAR applType[6+1]="";                /* Appl Type                       */
   MQCHAR applTag[MQ_APPL_TAG_LENGTH+1];   /* handle  queue extracted from bag*/
   MQCHAR chlName[MQ_CHANNEL_NAME_LENGTH+1];/*handle  queue extracted from bag*/
   MQCHAR connName[MQ_CONN_NAME_LENGTH+1]; /*handle  queue extracted  from bag*/
   MQCHAR connName64[64+1];                /*handle  queue extracted  from bag*/
   MQCHAR userId[MQ_MAX_USER_ID_LENGTH+1]; /*handle  queue extracted  from bag*/
   MQCHAR objName[MQ_OBJECT_NAME_LENGTH+1];
   MQCHAR objType[8+1];
   MQCHAR OutputBuffer[OUTPUTLEN];         /* output data buffer              */

   char   qualOutf[21];
   char   outf[11];
   char   outfLib[11];
   char   tmpStr[11];
   char   outfileStr[22]="";

   if (argc < 4)
   {
      printf("Syntax: %s qmgrname outputFile rc\n",argv[0]);
      exit(-1);
   }

   genericConnId[0] = '\0';

   strncpy(qmName, argv[1], (size_t)MQ_Q_MGR_NAME_LENGTH);
   printf("\nDisplay MQMName   %s\n\n", qmName);

   /* reset Ourput parameter to blank space 0x40 */
   memset(argv[3],64,   4);        /* RC             */

   strncpy(qualOutf, argv[2], 20);
   strncpy(outf   , &qualOutf[0],10);
   outf[10]='\0';
   strncpy(outfLib, &qualOutf[10],10);
   outfLib[10]='\0';
   for(i=0; i< 10; i++)
   {
     if(outf[i] == ' ' )
     {
       outf[i] = 0x00;
       break;
     }
   }

   for(i=0; i< 10; i++)
   {
     if(outfLib[i] == ' ' )
     {
       outfLib[i] = '\0';
       break;
     }
   }
   sprintf(outfileStr, OUTFILE, outfLib, outf, outf);

   /***************************************************************************/
   /* Connect to the queue manager                                            */
   /***************************************************************************/
   MQCONN(qmName, &hConn, &compCode, &connReason);

   /***************************************************************************/
   /* Report the reason and stop if the connection failed.                    */
   /***************************************************************************/
   if (compCode == MQCC_FAILED)
   {
      mqTrim(MQ_Q_MGR_NAME_LENGTH, qmName, qmName, &compCode, &trimReason);
      sprintf(argv[3], "%4d", connReason);
      CheckCallResult("Queue Manager connection", compCode, connReason);
      exit( (int)connReason);
   }

   /***************************************************************************/
   /* Open the output file                                                    */
   /***************************************************************************/
   //OPENOUTFILE(outfp, OUTFILE);
   OPENOUTFILE(outfp, outfileStr);
   if(outfp == NULL)
   {
     printf("Could not open output file.\n");
     goto MOD_EXIT;
   }

   first = 0;
Again:
   first  = first  + 1;

   /***************************************************************************/
   /* Create an admin bag for the mqExecute call                              */
   /***************************************************************************/
   mqCreateBag(MQCBO_ADMIN_BAG, &adminBag, &compCode, &reason);
   CheckCallResult("Create admin bag", compCode, reason);

   /***************************************************************************/
   /* Create a response bag for the mqExecute call                            */
   /***************************************************************************/
   if (compCode == MQCC_OK)
   {
      mqCreateBag(MQCBO_ADMIN_BAG, &responseBag, &compCode, &reason);
      CheckCallResult("Create response bag", compCode, reason);
   }

   /***************************************************************************/
   /* Create an options bag to set the timeout value of the mqexecute call    */
   /***************************************************************************/
   if (compCode == MQCC_OK)
   {
      mqCreateBag(MQCBO_USER_BAG, &optionsBag, &compCode, &reason);
      CheckCallResult("Create options bag", compCode, reason);
      if (compCode == MQCC_OK && reason == MQRC_NONE)
      {
         mqAddInteger(optionsBag, MQIACF_WAIT_INTERVAL, WAIT_TIME,
                      &compCode, &reason);
      }

      /********************************************************/
      /* If generating the options bag fails, just use the    */
      /* default time of 30 seconds by setting options bag    */
      /* to MQHB_NONE                                         */
      /********************************************************/
      if (compCode != MQCC_OK)
      {
         optionsBag = MQHB_NONE;
         compCode   = MQCC_OK;
         reason     = MQRC_NONE;
      }
   }

   /***************************************************************************/
   /* Put Generic Connection Id to the admin bag                              */
   /***************************************************************************/
   if (compCode == MQCC_OK)
   {
      mqAddByteString(adminBag, MQBACF_GENERIC_CONNECTION_ID,
                      1                      ,
                      genericConnId, &compCode, &reason);
      CheckCallResult("Add genericConnId", compCode, reason);
   }

   /***************************************************************************/
   /* Indicate we want all CONN_INFO_ALL which include CONN and HANDLE        */
   /***************************************************************************/
   if (compCode == MQCC_OK)
   {
     if ( first == 1 )
      mqAddInteger(adminBag, MQIACF_CONN_INFO_TYPE, MQIACF_CONN_INFO_CONN,
                   &compCode, &reason);
     if ( first == 2 )
      mqAddInteger(adminBag, MQIACF_CONN_INFO_TYPE, MQIACF_CONN_INFO_HANDLE,
                   &compCode, &reason);
      CheckCallResult("Add status attrs", compCode, reason);
   }

   /***************************************************************************/
   /* Indicate we want all attributes                                         */
   /***************************************************************************/
   if (compCode == MQCC_OK)
   {
      mqAddInteger(adminBag, MQIACF_CONNECTION_ATTRS  , MQIACF_ALL,
                   &compCode, &reason);
      CheckCallResult("Add status attrs", compCode, reason);
   }

   /***************************************************************************/
   /* The mqExecute call creates the PCF structure required, sends it to      */
   /* the command server, and receives the reply from the command server into */
   /* the response bag. The attributes are contained in system bags that are  */
   /* embedded in the response bag, one set of attributes per bag.            */
   /***************************************************************************/
   if (compCode == MQCC_OK)
   {
      mqExecute(hConn,                /* MQ connection handle                 */
                MQCMD_INQUIRE_CONNECTION, /* Command to be executed           */
                optionsBag,           /* No options bag                       */
                adminBag,             /* Handle to bag containing commands    */
                responseBag,          /* Handle to bag to receive the response*/
                MQHO_NONE,            /* Put msg on SYSTEM.ADMIN.COMMAND.QUEUE*/
                MQHO_NONE,            /* Create a dynamic q for the response  */
                &compCode,            /* Completion code from the mqexecute   */
                &reason);             /* Reason code from mqexecute call      */
   }

   /***************************************************************************/
   /* Check the command server is started. If not exit.                       */
   /***************************************************************************/
   if (reason == MQRC_CMD_SERVER_NOT_AVAILABLE)
   {
      mqTrim(MQ_Q_MGR_NAME_LENGTH, qmName, qmName, &compCode, &trimReason);
      sprintf(argv[3], "%4d", reason);
      printf("Please start the command server: <strmqcsv QMgrName>\n");
      MQDISC(&hConn, &compCode, &reason);
      CheckCallResult("Disconnect from Queue Manager", compCode, reason);
      exit(98);
   }

   /***************************************************************************/
   /* Check the result from mqExecute call. If successful find a display      */
   /* a few channel attributes. If failed find the error.                     */
   /***************************************************************************/
   if ( compCode == MQCC_OK )                      /* Successful mqExecute    */
   {
      /*************************************************************************/
      /* Count the number of system bags embedded in the response bag from the */
      /* mqExecute call. The attributes for each queue are in a separate bag.  */
      /*************************************************************************/
      mqCountItems(responseBag, MQHA_BAG_HANDLE, &numberOfBags,
                   &compCode, &reason);
      CheckCallResult("Count number of bag handles", compCode, reason);

      for ( i=0; i<numberOfBags; i++)
      {
         /***********************************************************************/
         /* Get the next system bag handle out of the mqExecute response bag.   */
         /* This bag contains the channel attributes                            */
         /***********************************************************************/
         mqInquireBag(responseBag, MQHA_BAG_HANDLE, i, &qAttrsBag,
                      &compCode, &reason);
         CheckCallResult("Get the result bag handle", compCode, reason);

         if (compCode == MQCC_OK && reason == MQRC_NONE)
         {
            /******************************************************************/
            /* Get the qmgr name out of the qmgr status attributes bag        */
            /******************************************************************/
            mqInquireByteString(qAttrsBag, MQBACF_CONNECTION_ID, 0,
                                MQ_CONNECTION_ID_LENGTH, strAttr,
                                &strAttrLength, &compCode, &reason);
            if (compCode == MQCC_OK && reason == MQRC_NONE)
            {
               printf("Connection Id           : \n");

               x = MQ_CONNECTION_ID_LENGTH;
               k = 0;
               for (j = 0; j < x; j++)
               {
                   if (j > 0) printf(":");
                   if (j>15)
                   {
                     sprintf(&real_connId[(k*2)],"%02X", strAttr[j]);
                     k++;
                   }
                   printf("%02X", strAttr[j]);
               }
               real_connId[16]='\0';
               printf("\n");
               printf("Connection Id           : %s\n", real_connId);
            }

            /******************************************************************/
            /* Get ConnInfoType out of the attributes bag                     */
            /******************************************************************/
            mqInquireInteger(qAttrsBag, MQIACF_CONN_INFO_TYPE, MQIND_NONE,
                             &intAttr, &compCode, &reason);
            CheckCallResult("Get ConnInfoType"    , compCode, reason);
            if (compCode == MQCC_OK && reason == MQRC_NONE)
            {
               infoType = intAttr;
               printf("Conntion info type      : ");
               switch (intAttr)
               {
                  case MQIACF_CONN_INFO_CONN:
                     strncpy(connInfoType, "CONN  ", 6);
                     connInfoType[6]='\0';
                     printf("CONN\n");

                     /*********************************************************/
                     /* Get the Application Name out of the attributes bag    */
                     /*********************************************************/
                     memset(applTag, 64, sizeof(applTag));
                     mqInquireString(qAttrsBag, MQCACF_APPL_TAG, 0,
                                     MQ_APPL_TAG_LENGTH, strAttr,
                                     &strAttrLength,NULL, &compCode,&reason);
                     CheckCallResult("Get ApplTag"    , compCode, reason);
                     if (compCode==0 && reason==0)
                     {
                       strncpy(applTag, strAttr , strAttrLength);
                       printf("Application             : %s\n",applTag);
                     }
                     applTag[MQ_APPL_TAG_LENGTH]='\0';
                     /*********************************************************/
                     /* Get the Application Type out of the attributes bag    */
                     /*********************************************************/
                     mqInquireInteger(qAttrsBag, MQIA_APPL_TYPE, MQIND_NONE,
                                      &intApplType,&compCode, &reason);
                     CheckCallResult("Get ApplType"    , compCode, reason);
                     memset(applType, 64, sizeof(applType));
                     if (compCode == MQCC_OK && reason == MQRC_NONE)
                     {
                       printf("Application type        : ");
                       switch (intApplType)
                       {
                        case MQAT_QMGR:
                         strncpy(applType, "QMGR  ", 6);
                         printf("QMGR");
                         break;
                        case MQAT_CHANNEL_INITIATOR:
                         strncpy(applType, "CHINIT", 6);
                         printf("CHINIT");
                         break;
                        case MQAT_USER:
                         strncpy(applType, "USER  ", 6);
                         printf("USER");
                         break;
                        case MQAT_SYSTEM_EXTENSION:
                         strncpy(applType, "SYSTEM", 6);
                         printf("SYSTEM_EXTENSION");
                         break;
                       }
                       applType[6]='\0';
                       printf("\n");
                     }
                     /*********************************************************/
                     /* Get the Channel Name out of the attributes bag        */
                     /*********************************************************/
                     mqInquireString(qAttrsBag, MQCACH_CHANNEL_NAME, 0,
                                     MQ_CHANNEL_NAME_LENGTH, strAttr,
                                     &strAttrLength,NULL, &compCode,&reason);
                     CheckCallResult("Get ChannelName", compCode, reason);
                     memset(chlName, 64, sizeof(chlName));
                     chlName[MQ_CHANNEL_NAME_LENGTH]='\0';
                     if (compCode==0 && reason==0)
                     {
                       strncpy(chlName, strAttr , strAttrLength);
                       printf("Channel                 : %s\n",chlName);
                     }
                     /*********************************************************/
                     /* Get the ConnectionName out of the attributes bag      */
                     /*********************************************************/
                     mqInquireString(qAttrsBag, MQCACH_CONNECTION_NAME, 0,
                                     MQ_CONN_NAME_LENGTH, strAttr,
                                     &strAttrLength,NULL, &compCode,&reason);
                     CheckCallResult("Get ConnName"   , compCode, reason);
                     memset(connName64, 64, sizeof(connName64));
                     connName64[64]='\0';
                     if (compCode==0 && reason==0)
                     {
                       strncpy(connName64, strAttr , strAttrLength);
                       printf("Connection name         : %s\n",connName64);
                     }
                     /*********************************************************/
                     /* Get the UserId         out of the attributes bag      */
                     /*********************************************************/
                     mqInquireString(qAttrsBag, MQCACF_USER_IDENTIFIER, 0,
                                     MQ_MAX_USER_ID_LENGTH, strAttr ,
                                     &strAttrLength,NULL, &compCode,&reason);
                     CheckCallResult("Get UserId"     , compCode, reason);
                     memset(userId  , 64, sizeof(userId));
                     userId[MQ_MAX_USER_ID_LENGTH]='\0';
                     if (compCode==0 && reason==0)
                     {
                       strncpy(userId  , strAttr , strAttrLength);
                       printf("UserId                  : %s\n",userId);
                     }
                     /*********************************************************/
                     /* Get the Process Id out of the attributes       bag    */
                     /*********************************************************/
                     mqInquireInteger(qAttrsBag, MQIACF_PROCESS_ID, MQIND_NONE,
                                      &intPrcId, &compCode, &reason);
                     CheckCallResult("Get Process Id"  , compCode, reason);
                     if (compCode == MQCC_OK && reason == MQRC_NONE)
                     {
                       printf("Process Id              : %09ld\n",intPrcId);
                     }
                     /*********************************************************/
                     /* Get the Thread Id out of the attributes        bag    */
                     /*********************************************************/
                     mqInquireInteger(qAttrsBag, MQIACF_THREAD_ID , MQIND_NONE,
                                      &intThrId, &compCode, &reason);
                     CheckCallResult("Get Thread Id"   , compCode, reason);
                     if (compCode == MQCC_OK && reason == MQRC_NONE)
                     {
                       printf("Thread Id               : %04ld\n",intThrId);
                     }

                     memset(OutputBuffer,64, sizeof(OutputBuffer));
                     sprintf(OutputBuffer,
                             "%-16s%-6s%-28s%-6s%-20s%-64s%-64s%09ld%04ld",
                                               real_connId,
                                               connInfoType,
                                               applTag,
                                               applType,
                                               chlName,
                                               connName64,
                                               userId,
                                               intPrcId,
                                               intThrId);
                     printf("%s", OutputBuffer);
                     WRITEOUTFILE(outfp, OutputBuffer, sizeof(OutputBuffer));
                     break;

                  case MQIACF_CONN_INFO_HANDLE:
                     strncpy(connInfoType, "HANDLE", 6);
                     connInfoType[6]='\0';
                     printf("HANDLE\n");
                     /*********************************************************/
                     /* Get the Object Name out of the attributes bag         */
                     /*********************************************************/
                     mqInquireString(qAttrsBag, MQCACF_OBJECT_NAME, 0,
                                     MQ_OBJECT_NAME_LENGTH, strAttr,
                                     &strAttrLength,NULL, &compCode,&reason);
                     CheckCallResult("Get Object name", compCode, reason);
                     memset(objName, 64, sizeof(objName));
                     objName[MQ_OBJECT_NAME_LENGTH]='\0';
                     if (compCode==0 && reason==0)
                     {
                       strncpy(objName , strAttr , strAttrLength);
                       mqTrim(MQ_OBJECT_NAME_LENGTH,strAttr, strAttr,
                              &compCode, &reason);
                       printf("Object name             : %s\n",strAttr);
                     }
                     /*********************************************************/
                     /* Get the Object Type out of the attributes bag         */
                     /*********************************************************/
                     mqInquireInteger(qAttrsBag, MQIACF_OBJECT_TYPE, MQIND_NONE,
                                      &intObjType,&compCode, &reason);
                     CheckCallResult("Get Object type" , compCode, reason);
                     memset(objType, 64, sizeof(objType));
                     objType[8]='\0';
                     if (compCode == MQCC_OK && reason == MQRC_NONE)
                     {
                       printf("Object type             : ");
                       switch (intObjType)
                       {
                        case MQOT_Q:
                         strncpy(objType , "QUEUE   " , 8);
                         printf("QUEUE");
                         break;
                        case MQOT_NAMELIST:
                         strncpy(objType , "NAMELIST" , 8);
                         printf("NAMELIST");
                         break;
                        case MQOT_PROCESS:
                         strncpy(objType , "PROCCESS" , 8);
                         printf("PROCCESS");
                         break;
                        case MQOT_Q_MGR:
                         strncpy(objType , "QMGR    " , 8);
                         printf("QMGR");
                         break;
                        case MQOT_CHANNEL:
                         strncpy(objType , "CHANNEL " , 8);
                         printf("CHANNEL");
                         break;
                        case MQOT_AUTH_INFO:
                         strncpy(objType , "AUTHINFO" , 8);
                         printf("AUTHINFO");
                         break;
                        case MQOT_TOPIC:
                         strncpy(objType , "TOPIC   " , 8);
                         printf("TOPIC");
                         break;
                       }
                       printf("\n");
                     }
                     memset(OutputBuffer,64, sizeof(OutputBuffer));
                     sprintf(OutputBuffer,
                             "%-16s%-6s%-48s%-8s",
                                               real_connId,
                                               connInfoType,
                                               objName,
                                               objType);
         printf("%s", OutputBuffer);
         WRITEOUTFILE(outfp, OutputBuffer, sizeof(OutputBuffer));

                     break;
               }
               sprintf(argv[3], "%04d", reason);
            }

            sprintf(argv[3], "%04d", reason);

         }
         printf("\n");
      }
   }

   else                                               /* Failed mqExecute     */
   {
      /************************************************************************/
      /* If the command fails get the system bag handle out of the mqexecute  */
      /* response bag.This bag contains the reason from the command server    */
      /* why the command failed.                                              */
      /************************************************************************/
      sprintf(argv[6], "%4d", reason);
      switch (reason)
      {
         case MQRCCF_COMMAND_FAILED:

            mqInquireBag(responseBag, MQHA_BAG_HANDLE, 0, &errorBag,
                         &compCode, &reason);
            CheckCallResult("Get the result bag handle", compCode, reason);

            /******************************************************************/
            /* Get the completion code and reason code, returned by the comman*/
            /* server, from the embedded error bag.                           */
            /******************************************************************/
            mqInquireInteger(errorBag, MQIASY_COMP_CODE, MQIND_NONE,
                             &mqExecuteCC, &compCode, &reason );
            CheckCallResult("Get the completion code from the result bag",
                            compCode, reason);
            mqInquireInteger(errorBag, MQIASY_REASON, MQIND_NONE, &mqExecuteRC,
                             &compCode, &reason);
            CheckCallResult("Get the reason code from the result bag",
                            compCode, reason);
            sprintf(argv[6], "%4d", mqExecuteRC);
            printf("Error returned by the command server: Completion    Code = %d : Reason = %d\n",
                    mqExecuteCC, mqExecuteRC);

            break;

         case MQRC_NO_MSG_AVAILABLE:

            printf("No results returned for qmgr %s. This qmgr may not exist.\n", qmName);
            break;

         default:
            printf("Call to get qmgr    status attributes failed: Completion Code = %d : Reason = %d\n",
                   compCode, reason);
      }

   }

MOD_EXIT:
   /***************************************************************************/
   /* Delete the admin bag if successfully created.                           */
   /***************************************************************************/
   if (adminBag != MQHB_UNUSABLE_HBAG)
   {
      mqDeleteBag(&adminBag, &compCode, &reason);
      CheckCallResult("Delete the admin bag", compCode, reason);
   }

   /***************************************************************************/
   /* Delete the response bag if successfully created.                        */
   /***************************************************************************/
   if (responseBag != MQHB_UNUSABLE_HBAG)
   {
      mqDeleteBag(&responseBag, &compCode, &reason);
      CheckCallResult("Delete the response bag", compCode, reason);
   }

   if ( first < 2 )
     goto Again;

   /***************************************************************************/
   /* Disconnect from the queue manager if not already connected              */
   /***************************************************************************/
   if (connReason != MQRC_ALREADY_CONNECTED)
   {
      MQDISC(&hConn, &compCode, &reason);
      CheckCallResult("Disconnect from Queue Manager", compCode, reason);
   }

   /***************************************************************************/
   /* Close the output file if open                                           */
   /***************************************************************************/
   if(outfp != NULL)
      CLOSEOUTFILE(outfp);

   return MQCC_OK;
}


/******************************************************************************/
/*                                                                            */
/* Function: CheckCallResult                                                  */
/*                                                                            */
/******************************************************************************/
/*                                                                            */
/* Input Parameters:  Description of call                                     */
/*                    Completion code                                         */
/*                    Reason code                                             */
/*                                                                            */
/* Output Parameters: None                                                    */
/*                                                                            */
/* Logic: Display the description of the call, the completion code and the    */
/*        reason code if the completion code is not successful                */
/*                                                                            */
/******************************************************************************/
void  CheckCallResult(char *callText, MQLONG cc, MQLONG rc)
{
   if (cc != MQCC_OK)
      printf("%s failed: Completion Code = %d : Reason = %d\n", callText,cc,rc);

}
