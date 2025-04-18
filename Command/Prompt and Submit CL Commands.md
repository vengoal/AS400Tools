<h4>Prompt and Submit CL Commands with QCAPCMD API</h4>
<li>https://www.itjungle.com/2010/05/19/fhg051910-story02/</li>
<li>Using selective prompting for CL commands https://www.ibm.com/docs/en/i/7.6.0?topic=time-using-selective-prompting-cl-commands</li> 


<code>
pgm

 dcl  &Cmd          *char  1024
 dcl  &CmdLen       *int      4   value(1024)
 dcl  &Options      *char    20
 dcl  &OptionsLen   *int      4   value(20)
 dcl  &Options      *char    20
 dcl  &NewCmd       *char  1024
 dcl  &NewCmdLenA   *int      4   value(1024)
 dcl  &NewCmdLenC   *int      4   value(1024)

 chgvar  %sst(&Options  1 4) value(x'00000001')
 chgvar  %sst(&Options  5 1) value('0')
 chgvar  %sst(&Options  6 1) value('1')
 chgvar  %sst(&Options  7 1) value('0')
 chgvar  %sst(&Options 12 4) value(x'00000000')
 chgvar  %sst(&Options 16 5) value(x'0000000000')
 chgvar  &Cmd     value('DSPOBJD')

 call    qcapcmd   parm(&Cmd &CmdLen &Options &OptionsLen +
                   'CPOP0100' &NewCmd &NewCmdLenA &NewCmdLenC +
                   x'00000000')
 monmsg  cpf6801  exec(return)
 sbmjob  job(ted) rqsdta(&NewCmd) jobq(nomax)

endpgm
</code>
