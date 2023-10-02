Function Initialize() Uint64
// 5 IF EXISTS("owner") THEN GOTO 50
// 10 STORE("owner", SIGNER())
20 STORE("participantCount", 0)
30 STORE("lotteryPool", 0) 
40 RETURN 0
50 RETURN 1
End Function

Function Participate() Uint64
10  LET amount = DEROVALUE()
20  IF amount < 1000000000000 THEN GOTO 130
30  STORE("participant_" + ITOA(LOAD("participantCount")), SIGNER()) 
40  STORE("participantCount", LOAD("participantCount") + 1) 
50  STORE("lotteryPool", LOAD("lotteryPool") + amount) 
60  IF LOAD("participantCount") < 10 THEN GOTO 120 
70  LET winnerIndex = RANDOM(LOAD("participantCount"))
80  LET winnerAddress = LOAD("participant_" + ITOA(winnerIndex))
90  SEND_DERO_TO_ADDRESS(ADDRESS_RAW(LOAD(winnerAddress)), LOAD("lotteryPool"))
100 STORE("participantCount", 0)
110 STORE("lotteryPool", 0)
120 RETURN 0
130 RETURN 1
End Function