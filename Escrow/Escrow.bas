Function Initialize(sellerAddress String, buyerAddress String, feePercent Uint64, blockExpiration Uint64) Uint64
10 IF EXISTS("owner") THEN GOTO 100
20 STORE("owner", SIGNER())
30 STORE("seller", sellerAddress)
40 STORE("buyer", buyerAddress)
50 STORE("feePercent", feePercent)
60 STORE("blockExpiration", blockExpiration)
99 RETURN 0
100 RETURN 1
End Function

Function Deposit(amount Uint64) Uint64
10 IF SIGNER() != LOAD("buyer") THEN GOTO 40
20 STORE("escrowBalance", LOAD("escrowBalance") + amount)
30 RETURN 0 
40 RETURN 1
End Function

Function ReleaseToSeller() Uint64
10 IF SIGNER() != LOAD("owner") THEN GOTO 50
20 SEND_DERO_TO_ADDRESS(ADDRESS_RAW(LOAD("seller")), ADDRESS_RAW(LOAD("escrowBalance")))
30 STORE("escrowBalance", 0)
40 RETURN 0
50 RETURN 1
End Function

Function RefundToBuyer() Uint64
10 IF SIGNER() != LOAD("owner") THEN GOTO 50
20 SEND_DERO_TO_ADDRESS(ADDRESS_RAW(LOAD("buyer")), ADDRESS_RAW(LOAD("escrowBalance")))
30 STORE("escrowBalance", 0)
40 RETURN 0
50 RETURN 1
End Function

