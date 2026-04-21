<h4>MONMQMCNN -- Monitor MQ Queue Manager Connection output to file</h4>
<code>
                     Monitor MQ Qmgr Conn Status (MONMQMCNN)                    
                                                                                
 Type choices, press Enter.                                                     
                                                                                
 Queue manager name . . . . . . .                                               
                                                                                
 File to receive output . . . . .   MQMCNN        Name                          
   Library  . . . . . . . . . . .     QTEMP       Name                          
 CL var for MQ reason      (4)  .                 Character value               
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                                
                                                                         Bottom 
 F3=Exit   F4=Prompt   F5=Refresh   F12=Cancel   F13=How to use this display    
 F24=More keys                                                                  
</code>
<h4>Output file layout</h4>
<code>
/*  Connection record spec as following:                             */
/*  Type CONN as following:                                          */
/*  Name          POS     LEN   NOTE                                 */
/*  ===========   ======= ===   ================================     */
/*  ConnId        001-016  16                                        */
/*  ConnInfoType  017-022   6                                        */
/*  ApplTag       023-044  28                                        */
/*  ApplType      051-056   6                                        */
/*  ChannelName   057-076  20                                        */
/*  ConnName      077-140  64                                        */
/*  UserId        141-204  64                                        */
/*  ProcessId     205-213   9                                        */
/*  ThreadId      214-217   4                                        */
/*                                                                   */
/*  Type HANDLE  as following:                                       */
/*  Name          POS     LEN   NOTE                                 */
/*  ===========   ======= ===   ================================     */
/*  ConnId        001-016  16                                        */
/*  ConnInfoType  017-022   6                                        */
/*  ObjectName    201-248  48                                        */
/*  ObjectType    249-256   8                                        */
</code>
