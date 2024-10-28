Scan Message File (SCNMSGF) allows you to search any message file for a message identifier using any text description from the message.

SCNMSGF is free and does not require registration. Just another free tool happily provided by BVS/Tools.com!

Detail information : https://www.bvstools.com/e-rpg/softdesc?software=SCNMSGF

<pre>
                           Scan Message File (SCNMSGF)                          
                                                                                
 Type choices, press Enter.                                                     
                                                                                
 Message File . . . . . . . . . . > QCPFMSG       Name                          
   Library  . . . . . . . . . . .     *LIBL       Name, *LIBL                   
                                                                                
</pre>

<br />Search String ==> damage
<pre>
 10/28/24            Scan Message File *LIBL/QCPFMSG                  XXXXXXX  
 14:54:19       Search String damage                                  USER     
                                                                               
 Type options, press Enter.                                                    
      5=Display                                                                
                                                                               
Opt Message  Sev Text                                                          
    CAE0002  40  New level of CSP/AE required for application.                 
    CAE0005  30  &1 Date entered must be in the format &2.                     
    CAE0009  40  Overflow occurred. Target item is too short.                  
    CAE0014  40  REPLACE attempted without preceding UPDATE on &1.             
    CAE0020  40  Application and file record lengths not equal.                
    CAE0023  40  Allocation of table &1 failed.                                
    CAE0024  40  Subscript value for operand &1 is not valid.                  
    CAE0025  40  Subscript value &1 is not valid for operand &2.               
    CAE0026  40  A calculation caused a maximum value overflow.                
    CAE0027  40  Operand number &1 does not contain numeric data.              
    CAE0030  40  Test of fields on map &1 is not valid.                        
    CAE0031  40  CALL to &1 failed due to an error.                            
    CAE0032  40  Application &1 is missing a required parameter.               
    CAE0033  40  CALL application &1 only from another program.                
                                                                        More...
  F3=Exit   F5=Refresh                                                         
</pre>

<br />Search "damage" String result
<pre>
 10/28/24            Scan Message File *LIBL/QCPFMSG                  DDSC914  
 14:56:18       Search String damage                                  VENGOAL  
                                                                               
 Type options, press Enter.                                                    
      5=Display                                                                
                                                                               
Opt Message  Sev Text                                                          
    CPA0F01  30  Incorrect use of option &1 for program QSKMAINT can caus . . .
    CPA2201  99  User profile &1 damaged. (G)                                  
    CPA4023  99  Volume &4 damaged for file sequence &40. (C R)                
    CPA94EC  99  Tape on tape device &25 is damaged.                           
    CPA94F4  99  Tape on tape device &25 is damaged.                           
    CPC1252  50  MSGQ &1 in &2 deleted or damaged.                             
    CPC2617   0  Damaged mode description &1 deleted during IPL.               
    CPC2618   0  Damaged class-of-service &1 deleted during IPL.               
    CPDA0AD  30  Object Extended Attributes have been lost or damaged.         
    CPDA0AE  30  File system Extended Attributes have been lost or damaged.    
    CPDA186  50  Member &3 in database physical file &1 damaged.               
    CPDA414  30  Queue of user profiles for server &1 is damaged.              
    CPDA429  20  Network server storage space &1 damaged.                      
    CPDA442  10  Server storage space &1 is partially damaged.                 
                                                                        More...
  F3=Exit   F5=Refresh                                                         
</pre>
