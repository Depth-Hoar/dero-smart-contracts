Function Initialize(sellerAddress String, buyerAddress String, feePercent Uint64, blockExpiration Uint64) Uint64
    5 IF EXISTS("owner") THEN GOTO 70
    10 STORE("owner", SIGNER())
    20 STORE("seller", sellerAddress)
    30 STORE("buyer", buyerAddress)
    40 STORE("feePercent", feePercent)
    50 STORE("blockExpiration", blockExpiration)
    60 RETURN 0
    70 RETURN 1
End Function

Function Deposit(amount Uint64) Uint64
    10 IF SIGNER() != LOAD("buyer") THEN GOTO 40
    20 STORE("escrowBalance", LOAD("escrowBalance") + amount)
    30 RETURN 0 
    40 RETURN 1
End Function

Function ReleaseToSeller() Uint64
    10 IF SIGNER() != LOAD("owner") THEN GOTO 50
    20 SEND_DERO_TO_ADDRESS(LOAD("seller"), LOAD("escrowBalance"))
    30 STORE("escrowBalance", 0)
    40 RETURN 0
    50 RETURN 1
End Function

Function RefundToBuyer() Uint64
    10 IF SIGNER() != LOAD("owner") THEN GOTO 50
    20 SEND_DERO_TO_ADDRESS(LOAD("buyer"), LOAD("escrowBalance"))
    30 STORE("escrowBalance", 0)
    40 RETURN 0
    50 RETURN 1
End Function

Function CheckBalance() Uint64
    10 RETURN LOAD("escrowBalance")
End Function