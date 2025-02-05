<h4>TechTip: WebSphere MQ Administration with PCF</h4>
https://www.mcpressonline.com/programming-other/development-tools/techtip-websphere-mq-administration-with-pcf
<ul>
<li>JYMONMQ -  Monitor queue manager, channels, and queue using PCF</li>
<li>MQPRTEV</li>
<ul>
  <li>ADDLIBLE QMQM
  <li>CRTRPGMOD MODULE( lib/MQPRTEVR )</li>
  <li>CRTPGM ( lib/MQPRTEVR ) BNDSRVPGM( QMQM/LIBMQM )</li>
  <li>CRTCMD CMD( lib/MQPRTEV ) PGM( lib/MQPRTEVR )</li>
  <code>
                              Print MQ event (MQPRTEV)                           
                                                                               
 Type choices, press Enter.                                                    
                                                                               
 Message Queue Manager name . . .   *DFT                                       
 Queue name . . . . . . . . . . .   SYSTEM.ADMIN.CHANNEL.EVENT                 
 Clear Queue  . . . . . . . . . .   *NO           *YES, *NO                    
                                                                               
                                                                               
                                                                               
                                                                               
                                                                               
                                                                               
                                                                               
                                                                               
                                                                               
                                                                               
                                                                               
                                                                               
                                                                               
                                                                         Bottom
 F3=Exit   F4=Prompt   F5=Refresh   F12=Cancel   F13=How to use this display   
 F24=More keys                                                                 
  </code>
<li>Sample Output</li>
<code>
-------------------------------------------------------------------------------------------------------------------------------
MQEVENT  05/02/2025 01:45:10 MQCMD_Q_MGR_EVENT              MQCC_WARNING                   MQRC_Q_MGR_ACTIVE                   
                             MQCA_Q_MGR_NAME                TEST1                                                              
                             MQCACF_HOST_NAME               xxx.xxx.xxx.xxx                                                
                             MQIACF_REASON_QUALIFIER        31                                                                 
</code>
</ul>
</ul>
