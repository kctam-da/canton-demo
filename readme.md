# Canton demo setup (with docker)

This repo provides two sample setups of Canton using docker containers. 

The simple setup contains
* two participant nodes
* one domain

The advanced setup contains (Canton enterprise image is needed)
* two participant nodes
* one domain manager
* one mediator
* two sequencers with a data (sequencer HA)

A sample daml model (testcanton) was created and compiled. The DAR will be used during the demonstration.

## Demo with Simple Setup

Step 1: Bring up all containers
```
cd simple
docker-compose up -d
```

Step 2: Run remote console
```
./run-console.sh
```

Step 3: Check health status
```
health.status
```

Step 4: Connect participant nodes to domain
```
participantDB.domains.connect("domain","http://domain-db:5018")
participantHSBC.domains.connect("domain","http://domain-db:5018")
```

Step 5: Check health status
```
health.status
```

Step 6: Check parties
```
participantDB.parties.list()
participantHSBC.parties.list()
```

Step 7: Define parties and users
```
var partyDB = participantDB.parties.enable("DB")
participantDB.ledger_api.users.create(id = "db", actAs = Set(partyDB.toLf), primaryParty = Some(partyDB.toLf))


var partyHSBC = participantHSBC.parties.enable("HSBC")
participantHSBC.ledger_api.users.create(id = "hsbc", actAs = Set(partyHSBC.toLf), primaryParty = Some(partyHSBC.toLf))
```

Step 8: Upload DAR
```
participantDB.dars.upload("/canton/dars/testcanton-0.0.1.dar")
participantHSBC.dars.upload("/canton/dars/testcanton-0.0.1.dar")
```

Step 9: Open new terminals to launch Navigator for both
```
daml navigator server localhost 5011 --port 4000
daml navigator server localhost 5012 --port 4001
```

Step 10: Perform contract creation and choice exercisng on Navigator.

Step 11: End the demo
```
docker-compose down -v
```


## Demo with Advanced Setup

Step 1: Bring up all containers
```
cd advanced
docker-compose up -d
```

Step 2: Run remote console
```
./run-console.sh
```

Step 3: Check health status
```
health.status
```

Step 4: Onboard domain
```
domainmgrDB.setup.bootstrap_domain(Seq(seq1DB),Seq(medDB))
```

Step 5: Connect participant nodes to domain
```
participantDB.domains.connect("domain","http://domain-db:5018")
participantHSBC.domains.connect("domain","http://domain-db:5018")
```

Step 6: Check health status
```
health.status
```

Step 7: Check parties
```
participantDB.parties.list()
participantHSBC.parties.list()
```

Step 8: Define parties and users
```
var partyDB = participantDB.parties.enable("DB")
participantDB.ledger_api.users.create(id = "db", actAs = Set(partyDB.toLf), primaryParty = Some(partyDB.toLf))


var partyHSBC = participantHSBC.parties.enable("HSBC")
participantHSBC.ledger_api.users.create(id = "hsbc", actAs = Set(partyHSBC.toLf), primaryParty = Some(partyHSBC.toLf))
```

Step 9: Upload DAR
```
participantDB.dars.upload("/canton/dars/testcanton-0.0.1.dar")
participantHSBC.dars.upload("/canton/dars/testcanton-0.0.1.dar")
```

Step 10: Open new terminals to launch Navigator for both
```
daml navigator server localhost 5011 --port 4000
daml navigator server localhost 5012 --port 4001
```

Step 11: Perform contract creation and choice exercisng on Navigator.

Step 12: End the demo
```
docker-compose down -v
```