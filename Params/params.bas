Function InitializePrivate(test String) Uint64
10 IF EXISTS ("OWNER") THEN GOTO 100
20 STORE("OWNER",SIGNER())
30 STORE("TEST",test)
99 RETURN 0
100 RETURN 1
End Function