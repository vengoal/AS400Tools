# AS400Tools

## Exit Program
<ul>
  <li>Socket Exit Points<br />
      https://github.com/vengoal/AS400Tools/blob/main/ExitPgm/Socket/README.md</li>
</ul>

## Journal
<ul>
  <li>DMPJRN and CVJRNDTA - Mission Possible! Journaling Forensics 101 (With Free Tools)</li>
  <ul>
    <li><a href="https://www.itjungle.com/2013/03/06/fhg030613-story01/">Journal Forensics 101</a></li>
    <li>https://github.com/vengoal/AS400Tools/blob/main/Journal/DMPJRN/Journaling%20Forensics%20101.pdf</li>
    <li>https://www.gomitec.com/XW210B-1.html</li>
  </ul>
  <li>EXPJRNE -- Export Journal Entries V5.5</li>
  <ul>
    <li>https://www.mcpressonline.com/programming/rpg/journal-entries-exposed-joesd-made-readable</li>
    <li>http://www.tools400.de/English/Freeware/Utilities/utilities.html</li>
  </ul>
</ul>

## Command
<ul>
  <li>Data area</li>
  <ul>
     <li>EDTDTAARA  - Edit Data Area</li>
     <li>RTVDTAARAD  - Retrieve Data Area Description</li>
  </ul>
  <li>Data queue</li>
  <ul>
  <li>DSPDTAQE - Display Data Queue Entries <a href="https://github.com/vengoal/CF_API_CBX/tree/main/CBX167" target="_blank">CBX167</a></li>
  <li>DSPDTAQD - Display Data Queue Description</li>
  <li>CLRDTAQ  - Clear Data Queue</li>
  <li>RCVDTAQE - Receive Data Queue Entry</li>
  <li>RTNDTAQD - Return Data Queue Description CLP</li>
  <li>RTVDTAQD - Retrieve Data Queue Description</li>
  <li>SNDDTAQE - Send Data Queue Entry</li>
  </ul>
  <li>IPL ( Initial Program Load )</li>
  <ul>
    <li>RTVIPLTIM - Retrieve IPL Date and Time</li>
  </ul>
  <li>Job</li>
  <ul>
  <li>ENDALLJOB - End All Jobs with job name</li>
  </ul>
   <li>JobD - Job Job Description</li>
  <ul>
  <li>RTVJOBD - Retrieve Job Description</li>
  </ul>
  <li>Job log</li>
  <ul>
  <li>CHKJLMSGID - Check Joblog which contain MSGID to get MSGDTA</li>
  <li>RCVJLMSG   - Receive Joblog Message by job and from job log direction (Top or Bottom)</li>
  <li>RMVJLMSG   - Remove Job Log Messages (Utility Cleans Up Unwanted Job Log Messages by Rory Hewitt)</li>
  </ul>
  <li>Job queue</li>
  <ul>
   <li>ENDJOBQJOB - End Jobq Job</li>
   <li>MOVJOBQ    - Move Jobq job to another Jobq</li>
   <li>RTVJOBQA   - Retrieve Job Queue Attributes</li>
   <li>RTVJOBQSTS - Retrieve Job Queue Status</li>
  </ul>
   <li>Message</li>
   <ul>
    <li>MOVDIAGMSG - Move Diagnostic Message</li>
    <li>RMVMSGKEY RTVMSGKEY - Two commands clear joblog message between message key</li>
    <li>RSNESCMSG - Resend Escape Message</li>
    <li>STRCLRDR  - Start CL Reader <a href="https://archive.midrange.com/midrange-l/200209/msg01318.html"> from midrange.com  MIDRANGE-L </li>
  </ul>
  <li>Message File</li>
  <ul>
    <li>SCNMSGF - Scan Message File</li>
  </ul>
  <li>Program or Service Program</li>
  <ul>
    <li>RTVSRC - Retrieve ILE Source Code by Chris Stead</li>
  </ul>
  <li>SSF - Search Spool File <a href="https://www.itjungle.com/2024/01/15/guru-using-mixed-lists-to-add-data-structures-to-cl-commands/">Guru: Using Mixed Lists To Add “Data Structures” To CL Commands</a></li>
  <li>Save Restore</li>
  <ul>    
      <li>WRKSAVFOBJ - <a href="https://www.mcpressonline.com/it-infrastructure/it-infrastructure-other/the-work-with-save-file-objects-wrksavfobj-utility">The Work with Save File Objects (WRKSAVFOBJ) Utility</a></li>
  </ul>
      <li>Software Product License</li>
   <ul>
     <li>CHKLICEXPD - Check License Expiration Date ( QLZARTVK API )</li>
   </ul>
  <li>Spooled File</li>
      <ul>
        <li>WRKLPR - WRKLPR - The Work with LPR Utility</li>
      </ul>
  <li>User space</li>
   <ul>
    <li>CRTUSRSPC - Create User Space</li>
    <li>CHGUSRSPC - Change User Space</li>
    <li>CHGUSRSPCA - Change User Space Attributes</li>
    <li>DSPUSRSPC - Display User Space</li>
    <li>EDTUSRSPC - Edit User Space</li>
    <li>RTVUSRSPC - Retrieve User Space</li>
  </ul>
</ul>
