<h4>WRKPRB -- Work with problem</h4>
<ul>
  <li>Problem Management APIs<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/pm1.htm</li>
  <li>Problem Logging APIs<br />https://www.ibm.com/docs/api/v1/content/ssw_ibm_i_75/apis/pm1a.htm</li>
  <li>Work with problem related DB files <br /><code>WRKOBJPDM LIB(QUSRSYS) OBJ(QASX*)</code></li>
</ul>
<h4>DSPPRB -- Display problem</h4>
<ul>
  <li>Display problem to outfile<br /><code>DSPPRB OUTPUT(*OUTFILE) OUTFILE(QTEMP/PRB)</code><br />System reference code drivened from outfile field PBRCT(Translate Table) and PBRFCD(Reference Code) :<br /><code>Substring(PBRCT 1 4) concate PBRFCD</code></li>
   <li>Display problem to spooled file<br /><code>DSPPRB OUTPUT(*PRINT)</code>
   <pre>
*...+....1....+....2....+....3....+....4....+....5....+....6....+....7....+....8....+....9....+....0....+....1....+....2....+..
                                                 Problem Log Report                                                     Page   
5770SS1 V7R1M0  100423                                                                     SYSTEMA   02/26/24  16:29:29 UTC+09:
                            System                           Resource    Service  Problem                                      
 Problem ID  Status         Ref Code     Date      Time      Name        Number   Description                                  
 2428255283  SENT           SRC11002610  10/08/24  16:06:08                       *Attention*  Contact your hardware service pr
 2422836187  READY          SRC577D3120  08/15/24  10:32:25  DC01                 *Attention*  Hardware service may be required
 2419954684  READY          SRC577D3120  07/17/24  15:55:40  DC01                 *Attention*  Hardware service may be required
 2414934343  READY          SRC577D3120  05/28/24  10:00:10  DC01                 *Attention*  Hardware service may be required
 2412748062  READY          SRC577D3120  05/06/24  13:59:57  DC01                 *Attention*  Hardware service may be required
 2410631267  READY          SRC577D3120  04/15/24  09:06:24  DC01                 *Attention*  Hardware service may be required
 2405151754  READY          SRCB900FDC7  02/20/24  15:04:28                       Software problem data for QYCUCTMGR has been 
 2405148383  READY          SRCB900FDC7  02/20/24  14:05:32                       Software problem data for QYCUCTMGR has been 
 2405147903  READY          SRCB900FDC7  02/20/24  13:57:09                       Software problem data for QYCUCTMGR has been 
 2405147864  READY          SRCB900FDC7  02/20/24  13:56:28                       Software problem data for QYCULCAMGR has been
 2336139080  READY          SRC577D3120  12/27/23  11:22:58  DC01                 *Attention*  Hardware service may be required
 2333257187  READY          SRC577D3120  11/28/23  16:39:24  DC01                 *Attention*  Hardware service may be required
 2333257183  SENT           SRCA1703000  11/28/23  16:39:20                       *Attention*  Contact your hardware service pr
 2330261789  READY          SRC577D3120  10/29/23  17:59:51  DC01                 *Attention*  Hardware service may be required
 2322045488  READY          SRCB900FDC7  08/08/23  13:14:58                       Software problem data for QYCULCAMGR has been
   </pre>
   </li>
</ul>
