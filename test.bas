Function Initialize() Uint64
10  IF EXISTS("initialized") THEN GOTO 90  // Contract has already been initialized
20  STORE("decimals", 2)  // Assuming 2 decimals for the loyalty points
30  STORE("symbol", "DLP")  // Dero Loyalty Points
40  STORE("name", "Dero Loyalty Points Token")
50  STORE("image_url", "https://example.com/path_to_image.png")  // Replace with actual image URL
60  STORE("owner", SIGNER())  // The one initializing will be the owner/admin
70  STORE("initialized", 1)  // Mark the contract as initialized
80 RETURN 0
90 RETURN 1
End Function


