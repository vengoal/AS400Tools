<h4>Watch for Event</h4>

<ul>
<li>STRWCH - Watch Exit Programs Explained with CL Example<br />https://www.ibm.com/support/pages/strwch-watch-exit-programs-explained-cl-example</li>
<li>watch program error source member list<code>
Opt  Member      Type        Text                                              
     WCHCPA070X  CLP         Watch CLP and CLLE Pgm Error message CPA070*      
     WCHPGMERR   CLP         Watch RPGLE RPG CLP CLLE PGM error                
     WCHRNQ01XX  CLP         Watch RPGLE Pgm Error message RNQ01xx - RNQ05xx   
     WCHRNQ08XX  CLP         Watch RPGLE Pgm Error message RNQ08xx - RNQ10xx   
     WCHRNQ11XX  CLP         Watch RPGLE Pgm Error message RNQ11xx - RNQ13xx   
     WCHRPG01XX  CLP         Watch RPG   Pgm Error message RPG01*              
     WCHRPG02XX  CLP         Watch RPG   Pgm Error message RPG02* - RPG05*     
     WCHRPG08XX  CLP         Watch RPG   Pgm Error message RPG08* - RPG10*     
     WCHRPG11XX  CLP         Watch RPG   Pgm Error message RPG11* - RPG19*     
</code>
Compile above member to QGPL，<br />
Create message queue<br /><code>
CRTMSGQ MSGQ(QGPL/JOBDUMP) MSGQFULL(*WRAP)
Call WCHPGMERR
</code>
to start watch program for program error event.<br />
all error message sent to msgq QGPL/JOBDUMP and reply program error message with 'D'。
</li>
<li>Watch message queue QSYSMSG<br />https://www.ibm.com/docs/en/i/7.5?topic=messages-qsysmsg-message-queue</li>
</ul>
