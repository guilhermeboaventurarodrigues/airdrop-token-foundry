# 	:mage: Contrato de airdrop, onde a carteira só pode ser inscrita uma única vez, e quando o contrato for executado os tokens serão distribuidos igualmente a todas elas.

##  :1st_place_medal: Tecnologias utilizadas
- Foundry
- Solidity

## 	:dart: Testes positivos
- testName()
- testSymbol()
- testDecimals()
- testTotalSupply()
- testBalanceOf()
- testTransfer()
- testApprove()
- testAllowance()
- testTransferFrom()
- testDecreaseAllowance()
- testIncreaseAllowance()
- testSubscribe()
- testExecute()

## :drop_of_blood: Testes negativos
- testFailApproveNotBalance()
- testFailTransferNotBalance()
- testFailTransferFromNotBalance()
- testFailHasSubscribed()
- testFailExecuteNotOwner()
