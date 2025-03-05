<h2>Program Adoption Authority and IFS Authority</h2>
On IBM i, program adoption authority and Integrated File System (IFS) authority are two distinct mechanisms for managing access and privileges, and they behave differently depending on the context in which they’re used. Let’s break this down:

<h3>Program Adoption Authority</h3>
<ul>
  <li>Program adoption authority allows a program to temporarily "adopt" the authority of its owner while it’s running. This means that when a user runs the program, the program can perform actions using the owner’s privileges, even if the user themselves doesn’t have those privileges.</li>
  <ul>
  <li>Controlled by the USEADPAUT (Use Adopted Authority) attribute of a program, which is set to *YES or *NO.</li>
  <li>When a program adopts authority, it inherits the private authorities, special authorities (e.g., *ALLOBJ), and group profile authorities of the program’s owner.</li>
  <li>Commonly used in traditional IBM i applications (e.g., RPG, CL) to access objects like files, libraries, or commands in the QSYS.LIB file system.</li>
  </ul>
  <li>Adoption is dynamic and only applies during the program’s execution. Once the program ends, the user reverts to their own authority.</li>
  <li>Example:</li>
  <ul>
    <li>A payroll program owned by a profile with *ALLOBJ authority can update payroll files, even if the clerk running it has limited access.</li>
    <li>Command: <code>CHGPGM PGM(MYLIB/PAYROLL) USRPRF(*OWNER) USEADPAUT(*YES)</code>.</li>
  </ul>
</ul>
<h3>IFS Authority</h3>
<ul>
<li>The IFS is a UNIX-like file system on IBM i that supports a hierarchical structure (e.g., directories and stream files) and uses a different authority model based on data authorities (*R, *W, *X) and object authorities (e.g., *OBJMGT, *OBJEXIST).</li>
<ul>
  <li>Authorities are assigned to IFS objects (files, directories) using commands like CHGAUT or Navigator for i.</li>
  <li>Permissions are checked against the user’s profile, group profile, or public (*PUBLIC) settings at the time of access.</li>
  <li>Unlike traditional QSYS.LIB objects, the IFS does not support adopted authority.</li>
</ul>
  <li>The IFS ignores any adopted authority from a running program. Access is strictly based on the actual authorities of the user (or their group) at the time of the operation.</li>
  <li>Example:</li>
  <ul>
  <li>A user tries to write to /home/user/file.txt. If their profile lacks *W (write) authority to that file, the operation fails, regardless of any adopted authority from a program.</li>    
  </ul>  
</ul>

<h3>Key Differences</h3>
<ol>
  <li>Adoption Support</li>
  <ul>
    <li>Program Adoption: Works in QSYS.LIB and other native IBM i environments, allowing a program to escalate privileges temporarily.</li>
    <li>IFS: Does not recognize adopted authority. Access is determined solely by the user’s explicit authorities.</li>
  </ul>
  <li>Scope</li>
  <ul>
    <li>Program Adoption: Applies to traditional objects (files, programs, libraries) and commands in the QSYS.LIB file system.</li>
    <li>IFS: Applies to stream files and directories (e.g., /home, /QIBM, /QDLS) and uses a UNIX-style permission model.</li>
  </ul>
  <li>Security Implications:</li>
  <ul>
    <li>Program Adoption: Useful for controlled privilege escalation in applications but can be a security risk if not managed carefully (e.g., an overly privileged owner).</li>
    <li>IFS: More restrictive because it ignores adoption, requiring explicit authority grants. This can catch developers off guard if they rely on adoption for access.</li>
  </ul>
  <li>Behavior in Mixed Workloads</li>
  <ul>
    <li>If a program with adopted authority tries to access an IFS object, it will fail unless the user running the program (not the program owner) has sufficient IFS authority.</li>
    <li>Example:<br /><code>
    // RPG program with adopted authority to owner QSECOFR
    CALL PGM(MYLIB/WRITEIFS) PARM('/home/user/data.txt')</code><br />
    If the user lacks *W to /home/user/data.txt, the write fails, even if QSECOFR has full IFS authority.</li>
  </ul>
</ol>

<h3>Practical Considerations</h3>
<ul>
  <li>When Using Adoption</li>
  <ul>
    <li>Works well for legacy applications accessing database files or objects in QSYS.LIB.</li>
    <li>To manage IFS access in such programs, you might need to:</li>
    <ul>
      <li>Grant explicit IFS authority to users or groups (e.g., CHGAUT OBJ('/home/user') USER(MYUSER) DTAAUT(*RWX)).</li>
      <li>Use profile switching (e.g., via APIs like QSYGETPH and QWTSETP) to temporarily change the user’s identity to one with IFS access.</li>
    </ul>
  </ul>
  <li>When Using IFS</li>
  <ul>
    <li>Plan security explicitly, as reliance on adoption won’t work.</li>
    <li>Use IFS authority templates (*RX, *RWX) or specific permissions to grant access, similar to UNIX systems.</li>
    <li>Be aware that tools like IBM Navigator for i or network shares (e.g., via NetServer) also enforce IFS authorities independently of adoption.</li>
  </ul>
  <li>If you need a program to access the IFS with elevated privileges:</li>
  <ol>
    <li>Profile Switching: Use IBM i APIs to switch the job’s user profile to one with IFS authority during execution, then switch back.</li>
    <ul>
      <li>Example APIs: QSYGETPH (get profile handle), QWTSETP (set profile).</li>
    </ul>
    <li>Explicit Grants: Assign IFS authorities directly to users or groups, avoiding reliance on adoption.</li>
  </ol>
</ul>

<h3>Conclusion</h3>
<p>Program adoption authority is powerful for traditional IBM i applications but irrelevant in the IFS world. If your application spans both environments, you’ll need to manage two separate security strategies: adoption for QSYS.LIB and explicit permissions for the IFS.</p>
