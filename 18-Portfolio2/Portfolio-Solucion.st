!classDefinition: #AccountSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummaryTest methodsFor: 'portfolio' stamp: 'MS 10/25/2021 11:18:15'!
test07aPortfolioWithAnAccountWithoutTransactionsNorTransfersHasEmptyAccountSummary
	|portfolio accountSummary expectedReport|
	
	portfolio := Portfolio new.
	accountSummary := AccountSummary for: portfolio.
	
	expectedReport := OrderedCollection with: 'Balance = 0'.
	
	self assert: expectedReport equals: accountSummary report.! !

!AccountSummaryTest methodsFor: 'portfolio' stamp: 'MS 10/25/2021 11:19:51'!
test08aPortfolioWithOneAccountReturnsCorrectReport
	|portfolio account  accountSummary expectedReport|
		
	account := ReceptiveAccount new.
	Deposit register: 100  on: account .
	Withdraw register: 50 on: account.
	expectedReport := OrderedCollection 
		with:'Depósito por 100.' 
		with: 'Extracción por 50.'
		with: 'Balance = 50'.
	portfolio := Portfolio with: account.
	accountSummary := AccountSummary for: portfolio.
		
	self assert: expectedReport equals: accountSummary report .! !

!AccountSummaryTest methodsFor: 'portfolio' stamp: 'MS 10/25/2021 11:20:09'!
test09aPortfolioWithMultipleAccountReturnsCorrectReport
	|portfolio account1 account2 portfolioSummary expectedReport |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100  on: account1 .
	account1 transfer: 20 to: account2 .
	account2 transfer: 30 to: account1.
	portfolio := Portfolio with: account1.
	portfolio add: account2.
	
	portfolioSummary := AccountSummary for: portfolio .
	expectedReport := OrderedCollection 
		with: 'Depósito por 100.'
		with:'Salida por transferencia de 20.' 
		with:'Entrada por transferencia de 30.'
		with:'Entrada por transferencia de 20.'
		with:'Salida por transferencia de 30.' 
		with: 'Balance = 100'.
		
	self assert: expectedReport equals: portfolioSummary report .! !

!AccountSummaryTest methodsFor: 'portfolio' stamp: 'MS 10/25/2021 11:52:10'!
test10aPortfolioWithPortfoliosAndAccountsReturnsCorrectReport
	|portfolio1 portfolio2 account1 account2 account3 portfolioSummary expectedReport |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	Deposit register: 100  on: account1 .
	Deposit register: 	50 on: account2.

	portfolio1 := Portfolio with: account1.
	portfolio1 add: account2.
	Deposit register: 25 on: account3.
	portfolio2 := Portfolio with: account3.
	portfolio1 add: portfolio2.
	
	portfolioSummary := AccountSummary for: portfolio1 .
	expectedReport := OrderedCollection 
		with: 'Depósito por 100.'
		with: 'Depósito por 50.'
		with:'Depósito por 25.'
		with: 'Balance = 175'.
		
	self assert: expectedReport equals: portfolioSummary report .! !


!AccountSummaryTest methodsFor: 'receptive account' stamp: 'MS 10/25/2021 11:14:04'!
test01anAccountWithNoTransactionsAndNoTransfersReturnsEmptyAccountSummary
	|account accountSummary expectedReport|
	
	account := ReceptiveAccount new.
	accountSummary := AccountSummary for: account.
	
	expectedReport := OrderedCollection with: 'Balance = 0'.
	
	self assert: expectedReport equals: accountSummary report.! !

!AccountSummaryTest methodsFor: 'receptive account' stamp: 'MS 10/25/2021 11:14:34'!
test02anAccountWithOneDepositReturnsCorrectAccountSummary
	|account accountSummary expectedReport|
	
	account := ReceptiveAccount new.
	Deposit register:100 on:account .
	accountSummary := AccountSummary for: account.
	expectedReport := OrderedCollection with:'Depósito por 100.' with: 'Balance = 100'.
		
	self assert: expectedReport equals: accountSummary report.
	! !

!AccountSummaryTest methodsFor: 'receptive account' stamp: 'MS 10/25/2021 11:14:58'!
test03anAccountWithOneWithdrawReturnsCorrectAccountSummary

	|account accountSummary expectedReport|
	
	account := ReceptiveAccount new.
	Withdraw register:100 on:account.
	accountSummary := AccountSummary for: account.
	expectedReport := OrderedCollection with:'Extracción por 100.' with: 'Balance = -100'.
		
	self assert: expectedReport equals: accountSummary report.
	! !

!AccountSummaryTest methodsFor: 'receptive account' stamp: 'MS 10/25/2021 11:16:02'!
test04anAccountWithOneTransferToAnotherAccountReturnsCorrectReport

	|sourceAccount destinationAccount sourceAccountSummary expectedReport|
	
	sourceAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	sourceAccount transfer: 100 to: destinationAccount .
	sourceAccountSummary := AccountSummary for: sourceAccount.
	expectedReport := OrderedCollection with:'Salida por transferencia de 100.' with: 'Balance = -100'.
		
	self assert: expectedReport equals: sourceAccountSummary report.
	! !

!AccountSummaryTest methodsFor: 'receptive account' stamp: 'MS 10/25/2021 11:16:30'!
test05anAccountWithOneTransferFromAnotherAccountReturnsCorrectReport

	|sourceAccount destinationAccount destinationAccountSummary expectedReport |
	
	sourceAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	sourceAccount transfer: 100 to: destinationAccount .
	destinationAccountSummary := AccountSummary for: destinationAccount.
	expectedReport := OrderedCollection with:'Entrada por transferencia de 100.' with: 'Balance = 100'.
		
	self assert: (expectedReport ) equals: destinationAccountSummary report.
	! !

!AccountSummaryTest methodsFor: 'receptive account' stamp: 'MS 10/25/2021 11:17:14'!
test06anAccountWithMultipleTransactionsAndTransfersReturnsCorrectReport

	|sourceAccount destinationAccount sourceAccountSummary expectedReport |
	
	sourceAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	Deposit register: 100  on: sourceAccount .
	Withdraw register: 50 on: sourceAccount.
	sourceAccount transfer: 20 to: destinationAccount .
	destinationAccount transfer: 30 to: sourceAccount.
	sourceAccountSummary := AccountSummary for: sourceAccount .
	expectedReport := OrderedCollection 
		with: 'Depósito por 100.'
		with: 'Extracción por 50.'
		with:'Salida por transferencia de 20.' 
		with:'Entrada por transferencia de 30.'
		with: 'Balance = 60'.
		
	self assert: expectedReport equals: sourceAccountSummary report .
	! !


!classDefinition: #PortfolioTest category: 'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 5/27/2021 17:36:04'!
test02BalanceOfPortfolioWithAccountsIsSumOfAccountsBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'NR 6/22/2020 07:31:19'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #TransferNetTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNetTest methodsFor: 'portfolio' stamp: 'MS 10/25/2021 11:40:04'!
test06anEmptyPortfolioReturnsZeroReport
	
	|portfolio portfolioTransferNet|
	
	portfolio := Portfolio new.
	portfolioTransferNet := TransferNet for: portfolio.
	self assert: 0 equals: portfolioTransferNet report.! !

!TransferNetTest methodsFor: 'portfolio' stamp: 'MS 10/25/2021 11:45:25'!
test07aPortfolioWithOneAccountReturnsCorrectReport
	
	|portfolio account1 account2 portfolioTransferNet|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer transfer: 100 from: account1 to: account2.
	portfolio := Portfolio with: account2.
	portfolioTransferNet := TransferNet for: portfolio.
	self assert: 100 equals: portfolioTransferNet report.! !

!TransferNetTest methodsFor: 'portfolio' stamp: 'MS 10/25/2021 11:46:56'!
test08aPortfolioWithMultipleAccountsReturnsCorrectReport
	
	|portfolio account1 account2 portfolioTransferNet|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer transfer: 100 from: account1 to: account2.
	portfolio := Portfolio with: account1 with: account2 .
	portfolioTransferNet := TransferNet for: portfolio.
	self assert: 0 equals: portfolioTransferNet report.! !


!TransferNetTest methodsFor: 'receptive account' stamp: 'MS 10/25/2021 11:34:45'!
test01anAccountWithNoTransfersReturnZeroReport
	|account accountTransferNet|
	
	account := ReceptiveAccount new.
	accountTransferNet := TransferNet for:account.
	self assert: 0 equals: accountTransferNet report.! !

!TransferNetTest methodsFor: 'receptive account' stamp: 'MS 10/25/2021 11:35:18'!
test02anAccountWithOneTransferFromAnotherAccountReturnsCorrectReport
	|account1 account2 account2TransferNet|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer transfer: 100 from: account1  to: account2.
	account2TransferNet := TransferNet for: account2 .
	self assert: 100 equals: account2TransferNet report.! !

!TransferNetTest methodsFor: 'receptive account' stamp: 'MS 10/25/2021 11:35:33'!
test03anAccountWithOneTransferToAnotherAccountReturnsCorrectReport
	|account1 account2 account2TransferNet|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer transfer: 100 from: account2  to: account1.
	account2TransferNet := TransferNet for: account2.
	 
	self assert: -100 equals: account2TransferNet report.! !

!TransferNetTest methodsFor: 'receptive account' stamp: 'MS 10/25/2021 11:36:50'!
test04transactionsDoNotAffectReport
	
	|account1 account2 account1TransferNet|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer transfer: 100 from: account2  to: account1.
	Deposit register:1000  on: account1.
	Withdraw register: 500 on: account1.
	
	account1TransferNet := TransferNet for: account1.
	self assert: 100 equals: account1TransferNet report.! !

!TransferNetTest methodsFor: 'receptive account' stamp: 'MS 10/25/2021 11:38:55'!
test05anAccountWithMultipleTransfersFromAnotherAccountReturnsCorrectReport
	
	|account1 account2 account1TransferNet|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer transfer: 100 from: account2  to: account1.
	Transfer transfer: 100 from: account2  to: account1.
	Transfer transfer: 100 from: account2  to: account1.
	Transfer transfer: 100 from: account2  to: account1.
	Deposit register:1000  on: account1.
	Withdraw register: 500 on: account1.
	
	account1TransferNet := TransferNet for: account1.
	self assert: 400 equals: account1TransferNet report.
	! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'error' stamp: 'MS 10/25/2021 11:01:04'!
test01canNotTransferZeroAsAmount
	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
		self 
		should: [Transfer transfer: 0 from: account1  to:account2 ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer transferCannotBeNull equals: anError messageText.]! !

!TransferTest methodsFor: 'error' stamp: 'MS 10/25/2021 11:01:48'!
test02canNotTransferANegativeValueAsAmount
	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
		
		self 
		should: [Transfer transfer: -1 from: account1  to:account2]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer transferCannotBeNull equals: anError messageText.]! !

!TransferTest methodsFor: 'error' stamp: 'MS 10/25/2021 11:02:00'!
test03canNotTransferToSameAccount
	| account1  |
	account1 := ReceptiveAccount new.
		self 
		should: [Transfer transfer: 100 from: account1  to:account1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToSourceAccountErrorMesssage equals: anError messageText.]! !


!TransferTest methodsFor: 'test' stamp: 'MS 10/25/2021 11:02:19'!
test04aTransferMustAffectBothBalances
	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer transfer: 5 from: account1  to:account2.
		
	self assert: -5 equals: account1 balance.
	self assert: 5 equals: account2 balance.! !

!TransferTest methodsFor: 'test' stamp: 'MS 10/25/2021 11:03:11'!
test05canNavigateThroughTransfer
	| account1 account2 transfer |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer transfer: 100 from: account1  to:account2.
	
	self assert: transfer destination equals: transfer source otherPart.
	self assert: transfer source equals: transfer destination otherPart.! !

!TransferTest methodsFor: 'test' stamp: 'MS 10/25/2021 11:04:33'!
test06aTransferSavesTheTransactionInBothAccounts

	| account1 account2 transfer |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer transfer: 100 from: account1  to:account2.
	
	self assert: (account1 hasRegistered: transfer source).
	self assert: (account2 hasRegistered: transfer destination).! !


!classDefinition: #TreeStructureSummaryTest category: 'Portfolio-Solucion'!
TestCase subclass: #TreeStructureSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeStructureSummaryTest methodsFor: 'error' stamp: 'MS 10/25/2021 13:59:34'!
test05canNotGetReportFromSomethingThatIsNotAPortfolio
	|account |
	
	account := ReceptiveAccount named: 'Account1'.
	
	self
		should: [TreeStructureSummary for: account]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Cant report a non portfolio object'].! !


!TreeStructureSummaryTest methodsFor: 'test' stamp: 'MS 10/25/2021 11:54:17'!
test01anEmptyPortfolioReturnsCorrectReport
	
	|portfolio treeStructureSummary expectedReport|
	
	portfolio := Portfolio named: 'Portfolio'.
	treeStructureSummary := TreeStructureSummary for: portfolio.
	expectedReport := OrderedCollection with: 'Portfolio' with: '   Balance = 0'.
	
	self assert: expectedReport equals: treeStructureSummary report.! !

!TreeStructureSummaryTest methodsFor: 'test' stamp: 'MS 10/25/2021 11:55:09'!
test02aPortfolioWithOneAccountWithNoTransactionsNorTransfersReturnsCorrectReport
	
	|portfolio account treeStructureSummary expectedReport|
	
	portfolio := Portfolio named: 'Portfolio'.
	account := ReceptiveAccount named: 'Account'.
	portfolio add: account.	
	treeStructureSummary := TreeStructureSummary for: portfolio.
	expectedReport := OrderedCollection with: 'Portfolio' with: '   Account' with: '      Balance = 0' with: '   Balance = 0'.
	
	self assert: expectedReport equals: treeStructureSummary report.! !

!TreeStructureSummaryTest methodsFor: 'test' stamp: 'MS 10/25/2021 11:55:35'!
test03aPortfolioWithOneAccountWithMultipleTransactionsReturnsCorrectReport
	
	|portfolio account treeStructureSummary expectedReport|
	
	portfolio := Portfolio named: 'Portfolio'.
	account := ReceptiveAccount named: 'Account'.
	Deposit register:100  on: account.
	Withdraw register: 50 on: account.
	portfolio add: account.	
	treeStructureSummary := TreeStructureSummary for: portfolio.
	expectedReport := OrderedCollection with: 'Portfolio' with: '   Account' with: '      Depósito por 100.' with:'      Extracción por 50.' with: '      Balance = 50' with: '   Balance = 50'.
	
	self assert: expectedReport equals: treeStructureSummary report.! !

!TreeStructureSummaryTest methodsFor: 'test' stamp: 'MS 10/25/2021 11:55:59'!
test04aPortfolioWithMultipleAccountsReturnsCorrectReport
	
	|portfolio1 portfolio2 account1 account2 account3 treeStructureSummary expectedReport|
	
	portfolio1 := Portfolio named: 'Portfolio1'.
	portfolio2 := Portfolio named: 'Portfolio2'.
	account1 := ReceptiveAccount named: 'Account1'.
	account2 := ReceptiveAccount named: 'Account2'.
	account3 := ReceptiveAccount named: 'Account3'.
	
	Deposit register:100  on: account1.
	Withdraw register: 50 on: account2.
	Transfer transfer: 50 from: account1  to: account2.
	Deposit register: 25  on: account3.
	portfolio1 add: account1.
	portfolio2 add: account2.
	portfolio2 add: account3 .	
	portfolio1 add: portfolio2 .
	treeStructureSummary := TreeStructureSummary for: portfolio1.
	expectedReport := OrderedCollection 
		with: 'Portfolio1' 
		with: '   Account1' 
		with: '      Depósito por 100.' 
		with: '      Salida por transferencia de 50.'
		with: '      Balance = 50'
		with: '   Portfolio2' .
	expectedReport addLast: '      Account2'.	
	expectedReport addLast: '         Extracción por 50.'.
	expectedReport addLast: '         Entrada por transferencia de 50.'.
	expectedReport addLast: '         Balance = 0'.
	expectedReport addLast: '      Account3'.	
	expectedReport addLast: '         Depósito por 25.'.
	expectedReport addLast: '         Balance = 25'.
	expectedReport addLast: '      Balance = 25'.
	expectedReport addLast: '   Balance = 75'.
		
	self assert: expectedReport equals: treeStructureSummary report.! !


!classDefinition: #TreeStructureTest category: 'Portfolio-Solucion'!
TestCase subclass: #TreeStructureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeStructureTest methodsFor: 'error' stamp: 'MS 10/25/2021 13:59:00'!
test07canNotGetReportFromSomethingThatIsNotAPortfolio
	|account |
	
	account := ReceptiveAccount named: 'Account1'.
	
	self
		should: [TreeStructure for: account]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Cant report a non portfolio object'].
	! !


!TreeStructureTest methodsFor: 'test' stamp: 'MS 10/25/2021 11:56:33'!
test01anEmptyPortfolioReturnsCorrectReport
	|portfolio treeStructure expectedReport|
	
	portfolio :=  Portfolio named: 'Portfolio' .
	treeStructure := TreeStructure for: portfolio .
	expectedReport := OrderedCollection with: 'Portfolio'.
	
	self assert: expectedReport equals: treeStructure report.! !

!TreeStructureTest methodsFor: 'test' stamp: 'MS 10/25/2021 11:56:53'!
test02aPortfolioWithOneAccountReturnsCorrectReport
	|portfolio account treeStructure expectedReport|
	
	portfolio :=  Portfolio named: 'Portfolio' .
	account := ReceptiveAccount named: 'Account'.
	portfolio add: account.
	treeStructure := TreeStructure for: portfolio .
	expectedReport := OrderedCollection 
		with: 'Portfolio'
		with: '   Account'.
	
	self assert: expectedReport equals: treeStructure report.! !

!TreeStructureTest methodsFor: 'test' stamp: 'MS 10/25/2021 11:57:16'!
test03aPortfolioWithMultipleReceptiveAccountsReturnsCorrectReport
	|portfolio account1 account2 treeStructure expectedReport|
	
	portfolio :=  Portfolio named: 'Portfolio' .
	account1 := ReceptiveAccount named: 'Account1'.
	account2 := ReceptiveAccount named: 'Account2'.
	
	portfolio add: account1.
	portfolio add: account2.
	treeStructure := TreeStructure for: portfolio .
	expectedReport := OrderedCollection 
		with: 'Portfolio'
		with: '   Account1'
		with: '   Account2'.
	
	self assert: expectedReport equals: treeStructure report.! !

!TreeStructureTest methodsFor: 'test' stamp: 'MS 10/25/2021 11:57:51'!
test04aPortfolioWithOnePortfolioAndOneReceptiveAccountReturnsCorrectReport
	|portfolio1 account portfolio2  treeStructure expectedReport|
	
	portfolio1 :=  Portfolio named: 'PortfolioFather' .
	portfolio2 := Portfolio named: 'PortfolioSon'.
	account := ReceptiveAccount named: 'Account'.
	portfolio1 add: account.
	portfolio1 add: portfolio2 .
	
	treeStructure := TreeStructure for: portfolio1 .
	expectedReport := OrderedCollection 
		with: 'PortfolioFather'
		with: '   Account'
		with: '   PortfolioSon'.
	
	self assert: expectedReport equals: treeStructure report.! !

!TreeStructureTest methodsFor: 'test' stamp: 'MS 10/25/2021 11:58:48'!
test05aPortfolioWithOnePortfolioAndMultipleReceptiveAccountsReturnCorrectReport
	|portfolio1 account1 portfolio2 account2  treeStructure expectedReport|
	
	portfolio1 :=  Portfolio named: 'PortfolioFather' .
	portfolio2 := Portfolio named: 'PortfolioSon'.
	account1 := ReceptiveAccount named: 'Account1'.
	account2 := ReceptiveAccount named: 'Account2'.
	portfolio1 add: account1.
	portfolio1 add: portfolio2.
	portfolio2 add: account2.
	
	treeStructure := TreeStructure for: portfolio1 .
	expectedReport := OrderedCollection 
		with: 'PortfolioFather'
		with: '   Account1'
		with: '   PortfolioSon'
		with: '      Account2'.
	
	self assert: expectedReport equals: treeStructure report.! !

!TreeStructureTest methodsFor: 'test' stamp: 'MS 10/25/2021 11:59:31'!
test06APortfolioWithMultipleAccountsReturnCorrectReport
	|portfolio1  portfolio2 portfolio3 account1 account2 account3 treeStructure expectedReport|
	
	portfolio1 :=  Portfolio named: 'PortfolioFather' .
	portfolio2 := Portfolio named: 'PortfolioSon'.
	portfolio3 := Portfolio named: 'PortfolioGrandson'.
	account1 := ReceptiveAccount named: 'Account1'.
	account2 := ReceptiveAccount named: 'Account2'.
	account3 := ReceptiveAccount named: 'Account3'.
	
	portfolio1 add: portfolio2.
	portfolio1 add: account3.
	portfolio2 add: portfolio3.
	portfolio2 add: account1.
	portfolio2 add: account2.
	
	
	treeStructure := TreeStructure for: portfolio1 .
	expectedReport := OrderedCollection 
		with: 'PortfolioFather'
		with: '   PortfolioSon'
		with: '      PortfolioGrandson'
		with: '      Account1'
		with: '      Account2' 
		with: '   Account3'
		.
	
	self assert: expectedReport equals: treeStructure report.! !


!classDefinition: #Account category: 'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !

!Portfolio methodsFor: 'initialization' stamp: 'MS 10/23/2021 14:14:24'!
initializeWithName: aName 
	name := aName.
	self initialize .! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'name' stamp: 'MS 10/23/2021 14:23:07'!
name

	^name copy.! !


!Portfolio methodsFor: 'report' stamp: 'MS 10/25/2021 12:51:41'!
reportedBy: aReport

	aReport printPortfolio: self.

	accounts do: [:anAccount | anAccount reportedBy: aReport ].
	
	aReport printPortfolioBalance: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:13:23'!
named: aName 
	
	^self new initializeWithName: aName.! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions tranfers name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'Ch.A 10/18/2021 20:55:10'!
initialize

	super initialize.
	transactions := OrderedCollection new.
	tranfers := OrderedCollection new.! !

!ReceptiveAccount methodsFor: 'initialization' stamp: 'MS 10/23/2021 14:25:49'!
initializeWithName: aName 
	name := aName.
	self initialize.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/21/2019 18:55:56'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'transfer' stamp: 'MS 10/20/2021 15:54:44'!
transfer: aValue to: aReceptiveAccount
 
	^Transfer transfer: aValue from: self to: aReceptiveAccount.! !


!ReceptiveAccount methodsFor: 'name' stamp: 'MS 10/23/2021 14:49:18'!
name

	^name copy.! !


!ReceptiveAccount methodsFor: 'report' stamp: 'MS 10/25/2021 12:53:57'!
reportedBy: aReport
	
	transactions do: [:aTransaction | aTransaction affectReport: aReport ].	
	
	aReport printReceptiveAccount: self.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: 'Portfolio-Solucion'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:25:30'!
named: aName 
	
	^self new initializeWithName: aName! !


!classDefinition: #AccountTransaction category: 'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !

!Deposit methodsFor: 'balance' stamp: 'MS 10/22/2021 16:29:48'!
affectReport: aReport
	
	^aReport addFromDeposit: value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'balance' stamp: 'MS 10/22/2021 16:30:08'!
affectReport: aReport
	
	^aReport addFromWithdraw: value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'Portfolio-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Report methodsFor: 'report' stamp: 'MS 10/25/2021 12:50:52'!
printPortfolio: aPortfolio

	self subclassResponsibility .! !

!Report methodsFor: 'report' stamp: 'MS 10/25/2021 12:52:22'!
printPortfolioBalance: aPortfolio

	self subclassResponsibility .! !

!Report methodsFor: 'report' stamp: 'MS 10/25/2021 12:54:30'!
printReceptiveAccount: aReceptiveAccount

	self subclassResponsibility .! !

!Report methodsFor: 'report' stamp: 'MS 10/25/2021 11:07:07'!
report

	^report.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'MS 10/25/2021 14:02:06'!
for: anAccount
	^self new initializeWith: anAccount .! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'initialize' stamp: 'MS 10/25/2021 12:33:22'!
initializeWith: anAccount

	report := OrderedCollection new.
	anAccount reportedBy: self.
	report add: 'Balance = ', anAccount balance asString.! !


!AccountSummary methodsFor: 'print' stamp: 'MS 10/25/2021 12:50:37'!
printPortfolio: aPortfolio! !

!AccountSummary methodsFor: 'print' stamp: 'MS 10/25/2021 12:52:15'!
printPortfolioBalance: aPortfolio! !

!AccountSummary methodsFor: 'print' stamp: 'MS 10/25/2021 12:54:26'!
printReceptiveAccount: aReceptiveAccount
! !


!AccountSummary methodsFor: 'report' stamp: 'MS 10/22/2021 16:32:28'!
addFromDeposit: anAmount
	
	^report add: 'Depósito por ', anAmount asString, '.'.! !

!AccountSummary methodsFor: 'report' stamp: 'MS 10/22/2021 16:33:57'!
addFromTransferDestination: anAmount

	^report add: 'Entrada por transferencia de ', anAmount value asString, '.'

! !

!AccountSummary methodsFor: 'report' stamp: 'MS 10/22/2021 16:34:12'!
addFromTransferSource: anAmount

	^report add: 'Salida por transferencia de ', anAmount value asString, '.'.
! !

!AccountSummary methodsFor: 'report' stamp: 'MS 10/22/2021 16:32:10'!
addFromWithdraw: anAmount
	
	^report add: 'Extracción por ', anAmount asString, '.'.
	! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'report' stamp: 'MS 10/23/2021 11:26:03'!
addFromDeposit: anAmount! !

!TransferNet methodsFor: 'report' stamp: 'MS 10/25/2021 10:52:20'!
addFromTransferDestination: anAmount

	^report := report + anAmount.! !

!TransferNet methodsFor: 'report' stamp: 'MS 10/25/2021 10:52:20'!
addFromTransferSource: anAmount

	^report := report - anAmount.! !

!TransferNet methodsFor: 'report' stamp: 'MS 10/23/2021 11:26:15'!
addFromWithdraw: anAmount! !


!TransferNet methodsFor: 'initialize' stamp: 'MS 10/25/2021 12:31:14'!
initializeWith: anAccount 
	
	report := 0.
	
	anAccount reportedBy: self! !


!TransferNet methodsFor: 'print' stamp: 'MS 10/25/2021 12:50:42'!
printPortfolio: aPortfolio! !

!TransferNet methodsFor: 'print' stamp: 'MS 10/25/2021 12:52:10'!
printPortfolioBalance: aPortfolio! !

!TransferNet methodsFor: 'print' stamp: 'MS 10/25/2021 12:54:22'!
printReceptiveAccount: aReceptiveAccount
! !


!classDefinition: #TreeStructures category: 'Portfolio-Solucion'!
Report subclass: #TreeStructures
	instanceVariableNames: 'indentation sizeOfLevels'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeStructures methodsFor: 'initialization' stamp: 'MS 10/25/2021 12:49:00'!
initializeWith: aPortfolio 
	
	sizeOfLevels := OrderedCollection with: 1.
	report := OrderedCollection new.
	indentation := ''.
	aPortfolio reportedBy: self.

	
	! !


!TreeStructures methodsFor: 'as yet unclassified' stamp: 'MS 10/25/2021 12:55:34'!
addFromDeposit: anAmount! !

!TreeStructures methodsFor: 'as yet unclassified' stamp: 'MS 10/25/2021 12:55:45'!
addFromTransferDestination: anAmount
! !

!TreeStructures methodsFor: 'as yet unclassified' stamp: 'MS 10/25/2021 12:55:56'!
addFromTransferSource: anAmount
! !

!TreeStructures methodsFor: 'as yet unclassified' stamp: 'MS 10/25/2021 12:56:07'!
addFromWithdraw: anAmount! !


!TreeStructures methodsFor: 'indentation' stamp: 'MS 10/25/2021 10:36:35'!
decreaseIndentation

	indentation := indentation copyFrom: 1 to: (indentation size -3).! !

!TreeStructures methodsFor: 'indentation' stamp: 'MS 10/25/2021 10:41:07'!
increaseIndentation

	indentation := indentation , '   '.! !


!TreeStructures methodsFor: 'update tree' stamp: 'MS 10/25/2021 10:46:00'!
updateTreeIfLastLevelIsEmpty

	(sizeOfLevels last = 0) ifTrue: [
		self decreaseIndentation.
		sizeOfLevels removeLast.
	].
	! !

!TreeStructures methodsFor: 'update tree' stamp: 'MS 10/25/2021 10:44:17'!
updateTreeWith: anAccount

	sizeOfLevels at: (sizeOfLevels size) put: (sizeOfLevels last -1 ).
	sizeOfLevels addLast: anAccount accountsSize.
	! !


!TreeStructures methodsFor: 'print' stamp: 'MS 10/25/2021 10:39:54'!
printNameOf: anAccount

	report add: indentation, anAccount name.! !

!TreeStructures methodsFor: 'print' stamp: 'MS 10/25/2021 10:44:09'!
printPortfolio: aPortfolio

	self printNameOf: aPortfolio.
	
	(aPortfolio accountsSize = 0) ifFalse: [self increaseIndentation ].
	
	self updateTreeWith: aPortfolio.
	
	(sizeOfLevels last = 0) ifTrue: [
		sizeOfLevels removeLast.
	].
! !

!TreeStructures methodsFor: 'print' stamp: 'MS 10/25/2021 10:29:23'!
printPortfolioBalance: aPortfolio

	self subclassResponsibility.! !

!TreeStructures methodsFor: 'print' stamp: 'MS 10/25/2021 10:32:47'!
printReceptiveAccount: aReceptiveAccount
	
	self subclassResponsibility .
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TreeStructures class' category: 'Portfolio-Solucion'!
TreeStructures class
	instanceVariableNames: ''!

!TreeStructures class methodsFor: 'as yet unclassified' stamp: 'MS 10/25/2021 14:02:13'!
for: anAccount
	(anAccount class = Portfolio) ifFalse: [^self error: self isNotAPortfolio].
	^self new initializeWith: anAccount .! !

!TreeStructures class methodsFor: 'as yet unclassified' stamp: 'MS 10/25/2021 14:00:41'!
isNotAPortfolio
	^'Cant report a non portfolio object'.! !


!classDefinition: #TreeStructure category: 'Portfolio-Solucion'!
TreeStructures subclass: #TreeStructure
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeStructure methodsFor: 'print' stamp: 'MS 10/24/2021 14:54:21'!
printPortfolioBalance: aPortfolio! !

!TreeStructure methodsFor: 'print' stamp: 'MS 10/25/2021 10:46:27'!
printReceptiveAccount: aReceptiveAccount

	self printNameOf: aReceptiveAccount .
	
	sizeOfLevels at: (sizeOfLevels size) put: (sizeOfLevels last -1 ).
	
	self updateTreeIfLastLevelIsEmpty.
! !


!classDefinition: #TreeStructureSummary category: 'Portfolio-Solucion'!
TreeStructures subclass: #TreeStructureSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeStructureSummary methodsFor: 'as yet unclassified' stamp: 'MS 10/25/2021 10:48:46'!
addAccountSummaryFor: aReceptiveAccount
	
	|accountSummary|
		
	accountSummary := ((AccountSummary for: aReceptiveAccount ) report) collect: [:summaryEntry | indentation copy, summaryEntry].
	
	report addAll: accountSummary.
	
! !

!TreeStructureSummary methodsFor: 'as yet unclassified' stamp: 'MS 10/25/2021 10:46:39'!
printPortfolioBalance: aPortfolio
	
	report add: '   ', indentation , 'Balance = ', aPortfolio balance asString .
	
	self decreaseIndentation.
	! !

!TreeStructureSummary methodsFor: 'as yet unclassified' stamp: 'MS 10/25/2021 10:49:12'!
printReceptiveAccount: aReceptiveAccount
	
	self  printNameOf: aReceptiveAccount.
	
	self increaseIndentation .
	
	self addAccountSummaryFor: aReceptiveAccount.
	
	self decreaseIndentation.
	
	sizeOfLevels at: (sizeOfLevels size) put: (sizeOfLevels last -1 ).
	
	self updateTreeIfLastLevelIsEmpty.
! !


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value source destination'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 15:31:35'!
destination

	^destination! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 16:11:05'!
initializeFor: anAmount from: aSourceReceptiveAccount to: aDestinationReceptiveAccount
	
	value := anAmount.
	source := TransferSource for: self.
	destination :=  TransferDestination for: self.
	
	aSourceReceptiveAccount register: source.
	aDestinationReceptiveAccount register: destination.! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 15:31:42'!
source

	^source! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 16:20:39'!
value

	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'MS 10/25/2021 10:56:58'!
assertCanTransfer: anAmount from: aSourceReceptiveAccount	 to: aDestinationReceptiveAccount

	anAmount > 0 ifFalse: [self error: self transferCannotBeNull].
	
	(aSourceReceptiveAccount = aDestinationReceptiveAccount) ifTrue: [self error: self cannotTransferToSourceAccountErrorMesssage].

	
! !

!Transfer class methodsFor: 'instance creation' stamp: 'MS 10/25/2021 10:57:06'!
transfer: anAmount from: aSourceReceptiveAccount to: aDestinationReceptiveAccount
	
	self assertCanTransfer: anAmount from: aSourceReceptiveAccount to: aDestinationReceptiveAccount.
	
	^self new initializeFor: anAmount from: aSourceReceptiveAccount to: aDestinationReceptiveAccount .
! !


!Transfer class methodsFor: 'error message' stamp: 'Ch.A 10/18/2021 20:43:40'!
transferCannotBeNull
	^ 'Transfer cannot be null'! !


!Transfer class methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 15:13:25'!
cannotTransferToSourceAccountErrorMesssage
	^'An account cannot transfer to himself'.! !


!classDefinition: #TransferParts category: 'Portfolio-Solucion'!
Object subclass: #TransferParts
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferParts methodsFor: 'initialization' stamp: 'MS 10/20/2021 15:48:13'!
initializeFor: aTransfer

	transfer := aTransfer ! !


!TransferParts methodsFor: 'as yet unclassified' stamp: 'MS 10/25/2021 12:00:10'!
affectBalance: aBalance 

	self subclassResponsibility .! !

!TransferParts methodsFor: 'as yet unclassified' stamp: 'MS 10/25/2021 12:00:37'!
affectReport: aReport

	self subclassResponsibility .! !

!TransferParts methodsFor: 'as yet unclassified' stamp: 'MS 10/25/2021 13:46:42'!
otherPart

	self subclassResponsibility.! !

!TransferParts methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 15:48:31'!
transfer

	^transfer.! !

!TransferParts methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 16:17:44'!
value
	
	^transfer value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferParts class' category: 'Portfolio-Solucion'!
TransferParts class
	instanceVariableNames: ''!

!TransferParts class methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 15:46:44'!
for: aTransfer

	^ self new initializeFor: aTransfer! !


!classDefinition: #TransferDestination category: 'Portfolio-Solucion'!
TransferParts subclass: #TransferDestination
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDestination methodsFor: 'balance' stamp: 'MS 10/20/2021 16:22:18'!
affectBalance: aBalance 
	^aBalance + transfer value.! !


!TransferDestination methodsFor: 'accesing' stamp: 'MS 10/25/2021 11:03:11'!
otherPart
	^transfer source.! !


!TransferDestination methodsFor: 'report' stamp: 'MS 10/22/2021 16:30:51'!
affectReport: aReport
	
	^aReport addFromTransferDestination: transfer value ! !

!TransferDestination methodsFor: 'report' stamp: 'MS 10/25/2021 12:44:58'!
reportedBy: aReport 
	
	^aReport addFromTransferDestination: transfer value ! !


!classDefinition: #TransferSource category: 'Portfolio-Solucion'!
TransferParts subclass: #TransferSource
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferSource methodsFor: 'balance' stamp: 'MS 10/20/2021 16:21:24'!
affectBalance: aBalance 
	
	^aBalance - self value.! !


!TransferSource methodsFor: 'accesing' stamp: 'MS 10/25/2021 11:03:11'!
otherPart
	^transfer destination .! !


!TransferSource methodsFor: 'report' stamp: 'MS 10/22/2021 16:31:02'!
affectReport: aReport
	
	^aReport addFromTransferSource: transfer value ! !

!TransferSource methodsFor: 'report' stamp: 'MS 10/25/2021 12:45:04'!
reportedBy: aReport
	
	^aReport addFromTransferSource: transfer value ! !
