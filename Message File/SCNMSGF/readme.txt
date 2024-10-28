Scan Message File (SCNMSGF) allows you to search any message file for a message 
identifier using any text description from the message.

For example, if you search for the word "file", it will return all messages 
and their identifiers containing that word!

I've always wondered why IBM didn't supply such a tool. It makes using message files a 
lot easier!

See more at www.bvstools.com.

1.  Location of Source.                                  
                                                         
    PC File Name    Member    Type    Source File        
    ------------    --------- ----    -----------        
    SCNMSGF.CMD     SNCMSGF   CMD     QCMDSRC            
    MSGF001.CL      MSGF001CL CLP     QCLSRC             
    MSGF001.DF      MSGF001DF DSPF    QDDSSRC            
    MSGF001.RPG     MSGF001RG RPGLE   QRPGLESRC          
                                                         
2.  Compile MSGF001CL.                                   
    CRTCLPGM PGM(XXX/MSGF001CL) SRCFILE(XXX/QCLSRC)      
                                                         
3.  Create Command SCNMSGF.                              
    CRTCMD CMD(XXX/SCNMSGF) PGM(XXX/MSGF001CL) +         
       SRCFILE(XXX/QCMDSRC)                              
                                                         
4.  Compile MSGF001DF.                                   
    CRTDSPF FILE(XXX/MSGF001DF) SRCFILE(XXX/QDDSSRC)     
                                                         
5.  Compile MSGF001RG.                                   
    CRTBNDRPG PGM(XXX/MSGF001RG) SRCFILE(XXX/QRPGLESRC)  
    
Copyright (c) 1999-2016, BVSTools, Inc.
All rights reserved.

Redistribution and use in source and binary forms, with or without modification, are permitted provided that 
the following conditions are met:

1. Redistributions of source code must retain the above copyright notice, this list of conditions and the 
following disclaimer.

2. Redistributions in binary form must reproduce the above copyright notice, this list of conditions and the 
following disclaimer in the documentation and/or other materials provided with the distribution.

THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR IMPLIED 
WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A 
PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT 
LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, 
OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN
IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.