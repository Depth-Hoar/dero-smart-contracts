// G45-NFT

Function InitializePrivate(collection String, metadataFormat String, metadata String) Uint64
10   IF EXISTS("minter") == 1 THEN GOTO 120
20   STORE("minter", SIGNER())
30   STORE("type", "G45-NFT")
40   STORE("owner", "")
50   STORE("timestamp", BLOCK_TIMESTAMP())
60   SEND_ASSET_TO_ADDRESS(SIGNER(), 1, SCID())
70   STORE("collection", collection)
80   STORE("metadataFormat", metadataFormat)
90   STORE("metadata", metadata)
100  STORE("stamp_name", "DERO Digital Stamp 2023")
110  RETURN 0
120  RETURN 1
End Function

Function DisplayNFT() Uint64
10   IF ADDRESS_STRING(SIGNER()) == "" THEN GOTO 5
20   IF ASSETVALUE(SCID()) != 1 THEN GOTO 5
30   STORE("owner", ADDRESS_STRING(SIGNER()))
40   RETURN 0
50   RETURN 1
End Function

Function RetrieveNFT() Uint64
10   IF LOAD("owner") != ADDRESS_STRING(SIGNER()) THEN GOTO 5
20   SEND_ASSET_TO_ADDRESS(SIGNER(), 1, SCID())
30   STORE("owner", "")
40   RETURN 0
50   RETURN 1
End Function