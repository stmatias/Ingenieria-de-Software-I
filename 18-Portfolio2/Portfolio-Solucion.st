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


!classDefinition: #ReportTest category: 'Portfolio-Solucion'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReportTest methodsFor: 'accountSummaryTest' stamp: 'AC 10/23/2021 16:16:32'!
test01anAccountWithoutTransactionsReturnsCeroBalance
	|account accountSummary|
	
	account := ReceptiveAccount new.
	accountSummary := AccountSummary for: account.
	
	self assert: (OrderedCollection with: 'Balance = 0') equals: accountSummary report.! !

!ReportTest methodsFor: 'accountSummaryTest' stamp: 'AC 10/23/2021 16:06:58'!
test02anAccountWithOneDepositReturnsThatTransactionAndItsBalance

	|account accountSummary expectedReport|
	
	account := ReceptiveAccount new.
	Deposit register:100 on:account .
	accountSummary := AccountSummary for: account.
	expectedReport := OrderedCollection with:'Depósito por 100.' with: 'Balance = 100'.
		
	self assert: expectedReport equals: accountSummary report.
	! !

!ReportTest methodsFor: 'accountSummaryTest' stamp: 'AC 10/23/2021 16:07:05'!
test03anAccountWithOneWithdrawReturnsThatTransactionAndItsBalance

	|account accountSummary expectedReport|
	
	account := ReceptiveAccount new.
	Withdraw register:100 on:account.
	accountSummary := AccountSummary for: account.
	expectedReport := OrderedCollection with:'Extracción por 100.' with: 'Balance = -100'.
		
	self assert: expectedReport equals: accountSummary report.
	! !

!ReportTest methodsFor: 'accountSummaryTest' stamp: 'AC 10/23/2021 16:07:15'!
test04anSourceAccountWithOneTransferOutReturnsThatTransferAndItsBalance

	|sourceAccount destinationAccount sourceAccountSummary expectedReport|
	
	sourceAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	sourceAccount transfer: 100 to: destinationAccount .
	sourceAccountSummary := AccountSummary for: sourceAccount.
	expectedReport := OrderedCollection with:'Salida por transferencia de 100.' with: 'Balance = -100'.
		
	self assert: expectedReport equals: sourceAccountSummary report.
	! !

!ReportTest methodsFor: 'accountSummaryTest' stamp: 'AC 10/23/2021 16:07:26'!
test05anDestinationAccountWithOneTransferInReturnsThatTransferAndItsBalance

	|sourceAccount destinationAccount destinationAccountSummary expectedReport |
	
	sourceAccount := ReceptiveAccount new.
	destinationAccount := ReceptiveAccount new.
	sourceAccount transfer: 100 to: destinationAccount .
	destinationAccountSummary := AccountSummary for: destinationAccount.
	expectedReport := OrderedCollection with:'Entrada por transferencia de 100.' with: 'Balance = 100'.
		
	self assert: (expectedReport ) equals: destinationAccountSummary report.
	! !

!ReportTest methodsFor: 'accountSummaryTest' stamp: 'AC 10/23/2021 16:05:47'!
test06anAccountWithAllFourTypeOfTransactionsReturnsAllFourTransactionAndItsBalance

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

!ReportTest methodsFor: 'accountSummaryTest' stamp: 'AC 10/23/2021 16:06:35'!
test07anEmptyPortfolioReturnsCeroBalance
	|portfolio accountSummary expectedReport|
	
	portfolio := Portfolio new.
	accountSummary := AccountSummary for: portfolio.
	
	expectedReport := OrderedCollection with: 'Balance = 0'.
	
	self assert: expectedReport equals: accountSummary report.! !

!ReportTest methodsFor: 'accountSummaryTest' stamp: 'AC 10/23/2021 16:09:27'!
test08aPortfolioWithOneAccountReturnsThatAccountsAccountSummary
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

!ReportTest methodsFor: 'accountSummaryTest' stamp: 'AC 10/23/2021 16:10:48'!
test09aPortfolioWithTwoAccountsReturnsAllTransactionsAndTheCombinedBalance
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

<<<<<<< HEAD
!ReportTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:07:18'!
test10
	|account accountTransferNet|
=======

!ReportTest methodsFor: 'transferNetTest' stamp: 'AC 10/23/2021 16:16:22'!
test01anAccountWithoutTransactionsReturnCero
	|account|
>>>>>>> f13b8e25ad9d5e52e057018391322afbd43c04b2
	
	account := ReceptiveAccount new.
	accountTransferNet := TransferNet for:account.
	self assert: 0 equals: accountTransferNet report.! !

<<<<<<< HEAD
!ReportTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:08:04'!
test11
	|account1 account2 account2TransferNet|
=======
!ReportTest methodsFor: 'transferNetTest' stamp: 'AC 10/23/2021 16:19:51'!
test02anAccountWithOneTransferInReturnsPositiveTransferNet
	|account1 account2|
>>>>>>> f13b8e25ad9d5e52e057018391322afbd43c04b2
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer transfer: 100 from: account1  to: account2.
	account2TransferNet := TransferNet for: account2 .
	self assert: 100 equals: account2TransferNet report.! !

<<<<<<< HEAD
!ReportTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:08:44'!
test12
	|account1 account2 account2TransferNet|
=======
!ReportTest methodsFor: 'transferNetTest' stamp: 'AC 10/23/2021 16:19:37'!
test03anAccountWithOneTransferOutReturnNegativeTransferNet
	|account1 account2|
>>>>>>> f13b8e25ad9d5e52e057018391322afbd43c04b2
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer transfer: 100 from: account2  to: account1.
	account2TransferNet := TransferNet for: account2.
	 
	self assert: -100 equals: account2TransferNet report.! !

<<<<<<< HEAD
!ReportTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:09:21'!
test13
=======
!ReportTest methodsFor: 'transferNetTest' stamp: 'AC 10/23/2021 16:20:52'!
test04depositAndWithdrawShouldntAffectAccountTransferNet
>>>>>>> f13b8e25ad9d5e52e057018391322afbd43c04b2
	
	|account1 account2 account1TransferNet|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer transfer: 100 from: account2  to: account1.
	Deposit register:1000  on: account1.
	Withdraw register: 500 on: account1.
	
	account1TransferNet := TransferNet for: account1.
	self assert: 100 equals: account1TransferNet report.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:11:34'!
test14
	
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
	self assert: 400 equals: account1TransferNet report.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:10:59'!
test15
	
	|portfolio portfolioTransferNet|
	
	portfolio := Portfolio new.
	portfolioTransferNet := TransferNet for: portfolio.
	self assert: 0 equals: portfolioTransferNet report.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:11:56'!
test16
	
	|portfolio account1 account2 portfolioTransferNet|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer transfer: 100 from: account1 to: account2.
	portfolio := Portfolio with: account2.
	portfolioTransferNet := TransferNet for: portfolio.
	self assert: 100 equals: portfolioTransferNet report.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:09:58'!
test17
	
	|portfolio account1 account2 portfolioTransferNet|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	Transfer transfer: 100 from: account1 to: account2.
	portfolio := Portfolio with: account1 with: account2 .
	portfolioTransferNet := TransferNet for: portfolio.
	self assert: 0 equals: portfolioTransferNet report.! !


!classDefinition: #TransferTest category: 'Portfolio-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 15:55:21'!
test01canNotTransferZeroAsAmount
	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
		self 
		should: [account1 transfer: 0 to: account2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer transferCannotBeNull equals: anError messageText.]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 16:25:20'!
test02canNotTransferANegativeValueAsAmount
	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
		
		self 
		should: [account1 transfer: -1 to: account2. ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer transferCannotBeNull equals: anError messageText.]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 16:25:29'!
test03canNotTransferToSameAccount
	| account1  |
	account1 := ReceptiveAccount new.
		self 
		should: [account1 transfer:50  to: account1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToSourceAccountErrorMesssage equals: anError messageText.]! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 16:25:34'!
test04aTransferMustAffectBothBalances
	| account1 account2 |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	account1 transfer:5  to: account2.
		
	self assert: -5 equals: account1 balance.
	self assert: 5 equals: account2 balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 16:25:38'!
test05canNavigateThroughTransfer
	| account1 account2 transfer |
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := account1 transfer:5  to: account2.	
	
	self assert: transfer destination equals: transfer source other.
	self assert: transfer source equals: transfer destination other.! !


!classDefinition: #TreeStructureTest category: 'Portfolio-Solucion'!
TestCase subclass: #TreeStructureTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeStructureTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:12:30'!
test01
	|portfolio treeStructure expectedReport|
	
	portfolio :=  Portfolio named: 'Portfolio' .
	treeStructure := TreeStructure for: portfolio .
	expectedReport := OrderedCollection with: 'Portfolio'.
	
	self assert: expectedReport equals: treeStructure report.! !

!TreeStructureTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:24:46'!
test02
	|portfolio account treeStructure expectedReport|
	
	portfolio :=  Portfolio named: 'Portfolio' .
	account := ReceptiveAccount named: 'Account'.
	portfolio add: account.
	treeStructure := TreeStructure for: portfolio .
	expectedReport := OrderedCollection 
		with: 'Portfolio'
		with: '   Account'.
	
	self assert: expectedReport equals: treeStructure report.! !

!TreeStructureTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 16:27:27'!
test03
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

!TreeStructureTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 16:29:42'!
test04
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

!TreeStructureTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 16:39:57'!
test05
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

!TreeStructureTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 16:47:16'!
test06
	|portfolio1 account1 portfolio2 account2  treeStructure expectedReport|
	
	portfolio1 :=  Portfolio named: 'PortfolioFather' .
	portfolio2 := Portfolio named: 'PortfolioSon'.
	account1 := ReceptiveAccount named: 'Account1'.
	account2 := ReceptiveAccount named: 'Account2'.
	portfolio2 add: account2.
	portfolio1 add: portfolio2.
	portfolio1 add: account1.
	
	
	treeStructure := TreeStructure for: portfolio1 .
	expectedReport := OrderedCollection 
		with: 'PortfolioFather'
		with: '   PortfolioSon'
		with: '      Account2'
		with: '   Account1'.
	
	self assert: expectedReport equals: treeStructure report.! !

!TreeStructureTest methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 18:03:32'!
test07
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

!Account methodsFor: 'transactions' stamp: 'AC 10/23/2021 15:17:28'!
addedTo: anAccount
	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

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


!Portfolio methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 15:14:01'!
affectReport: anAccountReporter
	accounts do: [:anAccount | anAccount affectReport: anAccountReporter].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:23:07'!
name

	^name copy.! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 16:31:38'!
tranferNet: aTransferNet 
	aTransferNet printPortfolio: self.
	accounts do: [:anAccount| anAccount tranferNet: aTransferNet ].! !

!Portfolio methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 16:34:48'!
treeStructure: aTreeStructure 

	aTreeStructure printPortfolio: self.	
	accounts do: [:anAccount| anAccount treeStructure: aTreeStructure ].! !

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

!ReceptiveAccount methodsFor: 'transactions' stamp: 'AC 10/23/2021 15:17:42'!
addedTo: anAccount
! !

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


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 15:14:25'!
affectReport: anAccountReporter

	transactions do: [:aTransaction | aTransaction affectReport: anAccountReporter].! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 15:54:44'!
transfer: aValue to: aReceptiveAccount
 
	^Transfer transfer: aValue from: self to: aReceptiveAccount.! !


!classDefinition: #AccountReporter category: 'Portfolio-Solucion'!
Object subclass: #AccountReporter
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountReporter methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 11:31:28'!
addFromDeposit: anAmount
	
	self subclassResponsibility.! !

!AccountReporter methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 11:31:39'!
addFromTransferDestination: anAmount
	
	self subclassResponsibility.! !

!AccountReporter methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 11:31:47'!
addFromTransferSource: anAmount
	
	self subclassResponsibility.! !

!AccountReporter methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 11:31:58'!
addFromWithdraw: anAmount
	
	self subclassResponsibility.! !


!classDefinition: #AccountSummary category: 'Portfolio-Solucion'!
AccountReporter subclass: #AccountSummary
	instanceVariableNames: 'report'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 15:53:51'!
addFromDeposit: aDeposit
	
	report add: 'Depósito por ', aDeposit value asString, '.'.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 15:53:56'!
addFromTransferDestination: anAmount

	report add: 'Entrada por transferencia de ', anAmount value asString, '.'

! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 15:54:00'!
addFromTransferSource: anAmount

	report add: 'Salida por transferencia de ', anAmount value asString, '.'.
! !

<<<<<<< HEAD
!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:49:18'!
name

	^name copy.! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 11:37:51'!
tranferNet: aTransferNet 
=======
!AccountSummary methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 15:54:03'!
addFromWithdraw: aWithdraw
>>>>>>> f13b8e25ad9d5e52e057018391322afbd43c04b2
	
	report add: 'Extracción por ', aWithdraw value asString, '.'.
	! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 15:14:01'!
initializeFor: anAccount
	
	report := OrderedCollection new.
	anAccount affectReport: self.
	report add: 'Balance = ', anAccount balance asString.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'MS 10/22/2021 16:37:04'!
report

	^report.	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'MS 10/22/2021 16:25:18'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
AccountReporter subclass: #TransferNet
	instanceVariableNames: 'account transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'MS 10/23/2021 11:26:03'!
addFromDeposit: anAmount! !

!TransferNet methodsFor: 'initialization' stamp: 'AC 10/23/2021 15:53:34'!
addFromTransferDestination: anTransferToDestination

	transferNet := transferNet + anTransferToDestination value.! !

!TransferNet methodsFor: 'initialization' stamp: 'AC 10/23/2021 15:53:28'!
addFromTransferSource: aTransferFromSource

	transferNet := transferNet - aTransferFromSource value.! !

!TransferNet methodsFor: 'initialization' stamp: 'MS 10/23/2021 11:26:15'!
addFromWithdraw: anAmount! !

!TransferNet methodsFor: 'initialization' stamp: 'AC 10/23/2021 15:14:01'!
initializeWith: anAccount 
	transferNet := 0.
	anAccount affectReport: self.
	^transferNet.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferNet class' category: 'Portfolio-Solucion'!
TransferNet class
	instanceVariableNames: ''!

!TransferNet class methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 10:30:26'!
for: anAccount
	^self new initializeWith: anAccount .! !

!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 16:32:00'!
treeStructure: aTreeStructure 
	
	aTreeStructure printReceptiveAccount: self.
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

!AccountTransaction methodsFor: 'balance' stamp: 'AC 10/23/2021 15:14:25'!
affectReport: anAccountReporter
	self subclassResponsibility! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'AC 10/23/2021 15:50:24'!
for: aValue

	^ self new initializeFor: aValue ! !

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


!Deposit methodsFor: 'value' stamp: 'AC 10/23/2021 13:38:32'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'AC 10/23/2021 13:38:58'!
affectBalance: aBalance

	^aBalance + self value ! !

!Deposit methodsFor: 'balance' stamp: 'AC 10/23/2021 15:14:25'!
affectReport: anAccountReporter
	anAccountReporter addFromDeposit: self! !


!classDefinition: #TransferToDestination category: 'Portfolio-Solucion'!
Deposit subclass: #TransferToDestination
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferToDestination methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 15:14:25'!
affectReport: anAccountReporter
	anAccountReporter addFromTransferDestination: self! !

!TransferToDestination methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 13:31:28'!
initializeFor: aTransfer

	transfer := aTransfer ! !

!TransferToDestination methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 16:05:34'!
other
	^transfer source.! !

!TransferToDestination methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 13:31:57'!
value
	
	^transfer value.! !


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


!Withdraw methodsFor: 'balance' stamp: 'AC 10/23/2021 13:39:06'!
affectBalance: aBalance

	^aBalance - self value! !

!Withdraw methodsFor: 'balance' stamp: 'AC 10/23/2021 15:14:25'!
affectReport: anAccountReporter
	anAccountReporter addFromWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Report class' category: 'Portfolio-Solucion'!
Report class
	instanceVariableNames: ''!

!Report class methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:15:32'!
for: anAccount
	^self new initializeWith: anAccount .! !


!classDefinition: #TransferFromSource category: 'Portfolio-Solucion'!
Withdraw subclass: #TransferFromSource
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferFromSource methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 15:14:25'!
affectReport: anAccountReporter
	anAccountReporter addFromTransferSource: self! !

!TransferFromSource methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 13:31:28'!
initializeFor: aTransfer

	transfer := aTransfer ! !

!TransferFromSource methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 16:04:15'!
other
	^transfer destination .! !

!TransferFromSource methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 13:31:57'!
value
	
<<<<<<< HEAD
	^report add: 'Extracción por ', anAmount asString, '.'.
	! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:16:35'!
initializeWith: anAccount

	report := OrderedCollection new.
	anAccount accountSummary: self.
	report add: 'Balance = ', anAccount balance asString.! !

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'MS 10/22/2021 16:37:04'!
report

	^report.	! !


!classDefinition: #TransferNet category: 'Portfolio-Solucion'!
Report subclass: #TransferNet
	instanceVariableNames: 'transferNet'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferNet methodsFor: 'initialization' stamp: 'MS 10/23/2021 11:26:03'!
addFromDeposit: anAmount! !

!TransferNet methodsFor: 'initialization' stamp: 'MS 10/23/2021 11:23:47'!
addFromTransferDestination: anAmount

	^transferNet := transferNet + anAmount.! !

!TransferNet methodsFor: 'initialization' stamp: 'MS 10/23/2021 11:23:58'!
addFromTransferSource: anAmount

	^transferNet := transferNet - anAmount.! !

!TransferNet methodsFor: 'initialization' stamp: 'MS 10/23/2021 11:26:15'!
addFromWithdraw: anAmount! !

!TransferNet methodsFor: 'initialization' stamp: 'MS 10/23/2021 14:05:23'!
initializeWith: anAccount 
	transferNet := 0.
	anAccount tranferNet: self.
	! !

!TransferNet methodsFor: 'initialization' stamp: 'MS 10/23/2021 14:05:38'!
report
	^transferNet.! !


!classDefinition: #TreeStructure category: 'Portfolio-Solucion'!
Report subclass: #TreeStructure
	instanceVariableNames: 'report indentation sizeOfLevels'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TreeStructure methodsFor: 'initialization' stamp: 'MS 10/23/2021 16:52:35'!
initializeWith: aPortfolio 
	
	sizeOfLevels := OrderedCollection with: 1.
	report := OrderedCollection new.
	indentation := ''.
	aPortfolio treeStructure: self.

	
	! !


!TreeStructure methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 18:02:20'!
printPortfolio: aPortfolio

	report add: indentation , aPortfolio name.
	(aPortfolio accountsSize = 0) ifFalse: [indentation := indentation , '   '].
	sizeOfLevels at: (sizeOfLevels size) put: (sizeOfLevels last -1 ).
	sizeOfLevels addLast: aPortfolio accountsSize.
	
	(sizeOfLevels last = 0) ifTrue: [
		sizeOfLevels removeLast.
	].

	sizeOfLevels isEmpty ifFalse: [
		(sizeOfLevels last = 0) ifTrue: [
			indentation := indentation copyFrom: 1 to: (indentation size -3).
			sizeOfLevels removeLast.
		].
	].! !

!TreeStructure methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 17:57:15'!
printReceptiveAccount: aReceptiveAccount

	report add: indentation, aReceptiveAccount name.
	sizeOfLevels at: (sizeOfLevels size) put: (sizeOfLevels last -1 ).
	
	(sizeOfLevels last = 0) ifTrue: [
		indentation := indentation copyFrom: 1 to: (indentation size -3).
		sizeOfLevels removeLast.
	].

	sizeOfLevels isEmpty ifFalse: [
		(sizeOfLevels last = 0) ifTrue: [
			indentation := indentation copyFrom: 1 to: (indentation size -3).
			sizeOfLevels removeLast.
		].
	].! !

!TreeStructure methodsFor: 'as yet unclassified' stamp: 'MS 10/23/2021 14:21:46'!
report
	^report.! !
=======
	^transfer value.! !
>>>>>>> f13b8e25ad9d5e52e057018391322afbd43c04b2


!classDefinition: #Transfer category: 'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value source destination'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 15:31:35'!
destination

	^destination! !

!Transfer methodsFor: 'as yet unclassified' stamp: 'AC 10/23/2021 13:41:37'!
initializeFor: anAmount from: aSourceReceptiveAccount to: aDestinationReceptiveAccount
	
	value := anAmount.
	source := TransferFromSource for: self.
	destination :=  TransferToDestination for: self.
	
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

!Transfer class methodsFor: 'instance creation' stamp: 'MS 10/20/2021 16:25:15'!
transfer: anAmount from: aSourceReceptiveAccount to: aDestinationReceptiveAccount
	
	anAmount <= 0 ifTrue: [self error: self transferCannotBeNull].
	(aSourceReceptiveAccount = aDestinationReceptiveAccount) ifTrue: [self error: self cannotTransferToSourceAccountErrorMesssage].
	
	
	^self new initializeFor: anAmount from: aSourceReceptiveAccount to: aDestinationReceptiveAccount .
! !


!Transfer class methodsFor: 'error message' stamp: 'Ch.A 10/18/2021 20:43:40'!
transferCannotBeNull
	^ 'Transfer cannot be null'! !


!Transfer class methodsFor: 'as yet unclassified' stamp: 'MS 10/20/2021 15:13:25'!
cannotTransferToSourceAccountErrorMesssage
	^'An account cannot transfer to himself'.! !
