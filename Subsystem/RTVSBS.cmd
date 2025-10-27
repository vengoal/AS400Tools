<code>
/*�***************************************************************�*/
/*� Title    :- QMNSBS                                            �*/
/*� CPP      :- QMNSBS                                            �*/
/*� Function :- To return the name of the current subsystem, the  �*/
/*�             name of the controlling subsystem and the library �*/
/*�             the controlling subsystem description is in.      �*/
/*�                                                               �*/
/*� Notes:-  Command processing program QMNSBS is not a supported �*/
/*�          user interface. It is subject to change without notic�*/
/*�                                                               �*/
/*� Author   :- S.H.Coulter          Modified :-                  �*/
/*� Date     :- 30/03/90             Date     :-                  �*/
/*�                                                               �*/
/*�***************************************************************�*/

             CMD        PROMPT('Retrieve Subsystem Information')

             PARM       KWD(SBS) TYPE(*CHAR) LEN(10) RTNVAL(*YES) +
                          MIN(1) CHOICE('Character value') +
                          PROMPT('CL var for SBS          (10)')

             PARM       KWD(CTLSBSD) TYPE(*CHAR) LEN(10) RTNVAL(*YES) +
                          MIN(1) CHOICE('Character value') +
                          PROMPT('CL var for CTLSBSD      (10)')

             PARM       KWD(CTLSBSDLIB) TYPE(*CHAR) LEN(10) +
                          RTNVAL(*YES) MIN(1) CHOICE('Character +
                          value') PROMPT('CL var for CTLSBSDLIB   +
                          (10)')
</code>
