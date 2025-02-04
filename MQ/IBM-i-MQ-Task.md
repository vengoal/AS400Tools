https://www.ibm.com/docs/en/ibm-mq/9.0?topic=i-mq-tasks
<h4>Table 1. IBM i MQ tasks</h4>
<pre>
Job name        Function
AMQALMPX	The checkpoint processor that periodically takes journal checkpoints.
AMQZMUC0	Utility manager. This job executes critical queue manager utilities, for example the journal chain manager.
AMQZXMA0	The execution controller that is the first job started by the queue manager. It handles MQCONN requests, and starts agent processes to process IBM MQ API calls.
AMQZFUMA	Object authority manager (OAM).
AMQZLAA0	Queue manager agents that perform most of the work for applications that connect to the queue manager using MQCNO_STANDARD_BINDING.
AMQZLSA0	Queue manager agent.
AMQZMUF0	Utility Manager
AMQZMGR0	Process controller. This job is used to start and manage listeners and services.
AMQZMUR0	Utility manager. This job executes critical queue manager utilities, for example the journal chain manager.
AMQFQPUB	Queued publish/subscribe daemon.
AMQFCXBA	Broker worker job.
RUNMQBRK	Broker control job.
AMQRMPPA	Channel process pooling job.
AMQCRSTA	TCP/IP-invoked channel responder.
AMQCRS6B	LU62 receiver channel and client connection (see note).
AMQRRMFA	Repository manager for clusters.
AMQCLMAA	Non-threaded TCP/IP listener.
AMQPCSEA	PCF command processor that handles PCF and remote administration requests.
RUNMQTRM	Trigger monitor.
RUNMQDLQ	Dead letter queue handler.
RUNMQCHI	The channel initiator.
RUNMQCHL	Sender channel job that is started for each sender channel.
RUNMQLSR	Threaded TCP/IP listener.
AMQRCMLA	Channel MQSC and PCF command processor.
</pre>
<h4>MQ Job started sequence for every queue manager</h4>
<ol>
<li>AMQZXMA0</li>
<li>AMQZFUMA</li>
<li>AMQZMUC0</li>
<li>AMQALMPX</li>
<li>AMQZMUR0</li>
<li>AMQZMUF0</li>
<li>AMQRRMFA</li>
<li>AMQZMGR0</li>
<li>AMQFQPUB</li>
<li>RUNMQCHI</li>
<li>AMQFCXBA</li>
<li>AMQPCSEA</li>
<li>RUNMQLSR</li>
<li>AMQZLAA0</li>
</ol>
