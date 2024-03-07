Function Initialize(sellerAddress String, buyerAddress String, feePercent Uint64, blockExpiration Uint64) Uint64
10 IF EXISTS("owner") THEN GOTO 100
20 STORE("owner", SIGNER())
30 STORE("seller", ADDRESS_RAW(sellerAddress))
40 STORE("buyer", ADDRESS_RAW(buyerAddress))
50 STORE("feePercent", feePercent)
60 STORE("blockExpiration", blockExpiration)
70 STORE("escrowBalance", 0)
99 RETURN 0
100 RETURN 1
End Function

Function Deposit() Uint64
10 IF SIGNER() != LOAD("buyer") THEN GOTO 100
20 STORE("escrowBalance", LOAD("escrowBalance") + DEROVALUE())
99 RETURN 0 
100 RETURN 1
End Function

Function ReleaseToSeller() Uint64
10 IF SIGNER() != LOAD("owner") THEN GOTO 100
20 SEND_DERO_TO_ADDRESS(LOAD("seller"), LOAD("escrowBalance"))
30 STORE("escrowBalance", 0)
99 RETURN 0
100 RETURN 1
End Function

Function RefundToBuyer() Uint64
10 IF SIGNER() != LOAD("owner") THEN GOTO 100
20 SEND_DERO_TO_ADDRESS(LOAD("buyer"), LOAD("escrowBalance"))
30 STORE("escrowBalance", 0)
99 RETURN 0
100 RETURN 1
End Function

