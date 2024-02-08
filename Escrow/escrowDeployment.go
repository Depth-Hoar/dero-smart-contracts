package escrowDeployment

import (
	"fmt"
	"log"
	"os"

	dero "github.com/deroproject/derohe/rpc"
)

func UploadContract(sellerAddress string, buyerAddress string, feePercent uint64, blockExpiration uint64) {
	rpcClientW, ctx, cancel := rpc.SetWalletClient("127.0.0.1:30000", rpc.Wallet.UserPass)
	defer cancel()

	filePath := "Escrow.bas"
	file, err := os.ReadFile(filePath)
	if err != nil {
		log.Fatal(err)
	}

	txid := dero.Transfer_Result{}
	t1 := dero.Transfer{
		Destination: "deto1qyre7td6x9r88y4cavdgpv6k7lvx6j39lfsx420hpvh3ydpcrtxrxqg8v8e3z",
		Amount:      0,
	}

	initializeArgs := dero.Arguments{
		dero.Argument{Name: "entrypoint", DataType: "S", Value: "Initialize"},
		dero.Argument{Name: "sellerAddress", DataType: "S", Value: sellerAddress},
		dero.Argument{Name: "buyerAddress", DataType: "S", Value: buyerAddress},
		dero.Argument{Name: "feePercent", DataType: "U", Value: fmt.Sprintf("%d", feePercent)},
		dero.Argument{Name: "blockExpiration", DataType: "U", Value: fmt.Sprintf("%d", blockExpiration)},
	}

	args := dero.Arguments{
		dero.Argument{Name: "entrypoint", DataType: "S", Value: "InitializePrivate"},
		dero.Argument{Name: "b", DataType: "S", Value: "deto1qyre7td6x9r88y4cavdgpv6k7lvx6j39lfsx420hpvh3ydpcrtxrxqg8v8e3z"}}

	params := &dero.Transfer_Params{
		Transfers: []dero.Transfer{t1},
		SC_Code:   string(file),
		SC_Value:  0,
		SC_RPC:    args,
		Ringsize:  2,
	}

	if err := rpcClientW.CallFor(ctx, &txid, "transfer", params); err != nil {
		log.Printf("[UploadContract] %s\n", err)
		return
	}

	log.Println("[UploadContract] TXID:", txid)
}
