!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'single portfolio' stamp: 'MS 10/18/2021 12:42:11'!
test03aPortfolioWithOneAccountHasItsBalance

	| portfolio account1 |
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	portfolio add: account1.
	self assert: 100 equals: (portfolio balance).
	! !

!PortfolioTest methodsFor: 'single portfolio' stamp: 'MS 10/18/2021 12:43:04'!
test04aPortfolioWithOneAccountHasItsTransactions

	| portfolio account1 |
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	portfolio add: account1.
	self assert: 100 equals: (portfolio balance).
	! !

!PortfolioTest methodsFor: 'single portfolio' stamp: 'MS 10/18/2021 12:46:23'!
test05aPortfolioWithOneAccountHasRegisteredItsTransactions

	|portfolio account transaction |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	transaction := (Deposit for: 100).
	account register: transaction.
	
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: transaction).
	! !

!PortfolioTest methodsFor: 'single portfolio' stamp: 'MS 10/18/2021 12:47:26'!
test06portfolioWithMultipleAccountsHasItsTransactions

	|portfolio account transaction1 transaction2 |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	transaction1 := Deposit register: 100 on: account.
	transaction2 := Withdraw register: 50 on: account.
	
	portfolio add: account.
	
	self assert: (OrderedCollection with: transaction1 with: transaction2) equals: portfolio transactions .	
	! !

!PortfolioTest methodsFor: 'single portfolio' stamp: 'MS 10/18/2021 12:51:24'!
test07portfolioWithMultipleAccountsHasRegisteredItsTransactions

	|portfolio account transaction1 transaction2 |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	transaction1 := Deposit register: 100 on: account.
	transaction2 := Withdraw register: 50 on: account.
	
	portfolio add: account.
	
	self assert: (portfolio hasRegistered: transaction1).
	self assert: (portfolio hasRegistered: transaction2).
	
	! !

!PortfolioTest methodsFor: 'single portfolio' stamp: 'MS 10/18/2021 12:44:56'!
test08aPortfolioWithMultipleAccountsHasItsBalance

	| portfolio account1 account2 account3 |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account2.
	account3 := ReceptiveAccount new.
	Deposit register: 100 on: account3.
	
	portfolio := Portfolio new.
	portfolio add: account1.
	portfolio add: account2.
	portfolio add: account3.
	self assert: 300 equals: (portfolio balance).
	! !

!PortfolioTest methodsFor: 'single portfolio' stamp: 'MS 10/18/2021 14:52:38'!
test09cannontAddTheSameAccountToAPortfolioTwice

	|portfolio account|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio new.
	portfolio add: account.
	
	self 
	should: [portfolio add: account.]
	raise: Error 
	withMessageText: Portfolio accountIsAlreadyInHierarchyErrorDescription.! !


!PortfolioTest methodsFor: 'multiple portfolios' stamp: 'MS 10/18/2021 13:07:32'!
test10AnAccountCanBeInTwoPortfolios

	|portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.

	portfolio1 add: account.
	portfolio2 add: account.
	
	self assert: (portfolio1 has: account).
	self assert: (portfolio2 has: account).! !

!PortfolioTest methodsFor: 'multiple portfolios' stamp: 'MS 10/18/2021 12:55:16'!
test11aPortfolioWithOnePortfolioHasItsBalance

	|portfolioParent portfolioChild account |
	
	portfolioParent := Portfolio new.
	portfolioChild := Portfolio new.
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolioChild add: account.
	portfolioParent add: portfolioChild.
	
	self assert: portfolioChild balance equals: 	portfolioParent balance.
	! !

!PortfolioTest methodsFor: 'multiple portfolios' stamp: 'MS 10/18/2021 14:09:05'!
test12aPortfolioWithOnePortfolioHasItsTransactions

	|portfolioParent portfolioChild account |
	
	portfolioParent := Portfolio new.
	portfolioChild := Portfolio new.
	
	account := ReceptiveAccount new.
	
	portfolioChild add: account.
	portfolioParent add: portfolioChild.
	
	self assert: portfolioChild transactions equals: 	portfolioParent transactions .
	! !

!PortfolioTest methodsFor: 'multiple portfolios' stamp: 'MS 10/18/2021 14:10:22'!
test13aPortfolioWithOnePortfolioHasItsTransactionsRegistered

	|portfolioParent portfolioChild account transaction |
	
	portfolioParent := Portfolio new.
	portfolioChild := Portfolio new.
	
	account := ReceptiveAccount new.
	transaction := Deposit register: 100  on: account .
	portfolioChild add: account.
	portfolioParent add: portfolioChild.
	
	self assert: (portfolioChild hasRegistered: transaction ).
	! !

!PortfolioTest methodsFor: 'multiple portfolios' stamp: 'MS 10/18/2021 14:55:37'!
test14APortfolioCannotAddItself

	|portfolio |
	
	portfolio := Portfolio new.
	self 
	should: [portfolio add: portfolio]
	raise: Error 
	withMessageText: Portfolio portfolioIsAlreadyInHierarchyErrorDescription .
		
	! !

!PortfolioTest methodsFor: 'multiple portfolios' stamp: 'MS 10/18/2021 14:56:48'!
test15AChildPortfolioCannotAddItsParent

	|parentPortfolio childPortfolio |
	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	parentPortfolio add: childPortfolio.
	self 
	should: [childPortfolio add: parentPortfolio]
	raise: Error 
	withMessageText: Portfolio portfolioIsAlreadyInHierarchyErrorDescription .
		
	! !

!PortfolioTest methodsFor: 'multiple portfolios' stamp: 'MS 10/18/2021 15:01:39'!
test16CannotAddAChildPortfolioTwiceToTheSameParentPortfolio

	|parentPortfolio childPortfolio |
	
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	parentPortfolio add: childPortfolio.
	self 
	should: [parentPortfolio add: childPortfolio ]
	raise: Error 
	withMessageText: Portfolio portfolioIsAlreadyInHierarchyErrorDescription .
		
	! !

!PortfolioTest methodsFor: 'multiple portfolios' stamp: 'MS 10/18/2021 14:19:54'!
test17AChildPortfolioCanBeInTwoParentPortfolios

	|rootPortfolio1 rootPortfolio2 childPortfolio |
	
	rootPortfolio1 := Portfolio new.
	rootPortfolio2 := Portfolio new.
	childPortfolio := Portfolio new.
	
	rootPortfolio1 add: childPortfolio .
	rootPortfolio2 add: childPortfolio .
	
	self assert: (rootPortfolio1 has: childPortfolio ).
	self assert: (rootPortfolio2 has: childPortfolio ).! !

!PortfolioTest methodsFor: 'multiple portfolios' stamp: 'MS 10/18/2021 14:27:40'!
test18portfolioWithPortfolioWithPortfolioSumsTheirBalance

	|rootPortfolio childPortfolio grandchildPortfolio account1 account2 account3 |
	
	rootPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	grandchildPortfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	Deposit register: 100  on: account1.
	Deposit register: 100  on: account2.
	Deposit register: 100  on: account3.
	
	rootPortfolio add: account1.
	childPortfolio add:account2.
	grandchildPortfolio add: account3.
	
	rootPortfolio add: childPortfolio.
	childPortfolio add: grandchildPortfolio.
	
	self assert: (100+100+100) equals: rootPortfolio balance .
	! !

!PortfolioTest methodsFor: 'multiple portfolios' stamp: 'MS 10/18/2021 14:26:43'!
test19portfolioWithPortfolioWithPortfolioHasItsTransactions

	|rootPortfolio childPortfolio grandchildPortfolio account1 account2 account3 transaction1 transaction2 transaction3 transactions |
	
	rootPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	grandchildPortfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	account3 := ReceptiveAccount new.
	
	transaction1 := Deposit register: 100  on: account1 .
	transaction2 := Deposit register: 100  on: account2.
	transaction3 := Deposit register: 100  on: account3.
	
	transactions := OrderedCollection with: transaction1 with: transaction2 with: transaction3.
	
	rootPortfolio add: account1.
	childPortfolio add:account2.
	grandchildPortfolio add: account3.
	
	rootPortfolio add: childPortfolio.
	childPortfolio add: grandchildPortfolio.
	
	self assert: transactions  equals: rootPortfolio transactions .
! !

!PortfolioTest methodsFor: 'multiple portfolios' stamp: 'MS 10/18/2021 15:02:22'!
test20aPortfolioCannotAddItsGrandfather

	|grandparentPortfolio parentPortfolio childPortfolio |
	
	grandparentPortfolio := Portfolio new.
	parentPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	grandparentPortfolio add: parentPortfolio .
	parentPortfolio add: childPortfolio.
	self 
	should: [childPortfolio add: grandparentPortfolio ]
	raise: Error 
	withMessageText: Portfolio portfolioIsAlreadyInHierarchyErrorDescription .
		
	! !


!PortfolioTest methodsFor: 'empty portfolio' stamp: 'Ch.A 10/17/2021 18:11:52'!
test01EmptyPortfolioHasCeroBalance

	| portfolio |
	portfolio := Portfolio new.
	self assert: 0 equals: (portfolio balance).
	! !

!PortfolioTest methodsFor: 'empty portfolio' stamp: 'MS 10/18/2021 12:33:41'!
test02emptyPortfolioHasNoTransactions

	|portfolio |
	
	portfolio := Portfolio new.
	
	self assert: portfolio transactions isEmpty.	
	! !


!classDefinition: #ReceptiveAccountTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:44'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:48'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance.
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:13:52'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance.
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 5/17/2021 17:29:53'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| deposit withdraw account |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 200.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'NR 11/2/2020 17:14:01'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 50 on: account1.
		
	self assert: 1 equals: account1 transactions size.
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: 'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'Alejandro 10/7/2021 20:38:05'!
balance
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'Alejandro 10/7/2021 20:38:13'!
balance
	^value.! !

!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: 'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'Alejandro 10/7/2021 20:43:18'!
balance
	^0 - value.! !

!Withdraw methodsFor: 'initialization' stamp: 'Alejandro 10/7/2021 20:33:04'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #PortfolioEntry category: 'Portfolio-Ejercicio'!
Object subclass: #PortfolioEntry
	instanceVariableNames: 'services'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioEntry methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 23:22:01'!
balance
	self subclassResponsibility.! !

!PortfolioEntry methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 23:22:21'!
hasRegistered: aTransaction
	self subclassResponsibility.! !

!PortfolioEntry methodsFor: 'as yet unclassified' stamp: 'MS 10/18/2021 12:12:08'!
transactions
	self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
PortfolioEntry subclass: #Portfolio
	instanceVariableNames: 'ancestors portfoliosEntries'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'Ch.A 10/16/2021 23:40:28'!
balance
	
	^portfoliosEntries sum: [:aPortfolioEntry | aPortfolioEntry balance] ifEmpty: [0]
	
! !


!Portfolio methodsFor: 'initialization' stamp: 'MS 10/18/2021 14:42:16'!
initialize
	portfoliosEntries := OrderedCollection new.
	ancestors := OrderedCollection new.! !


!Portfolio methodsFor: 'addingAccountsOrPortfolios' stamp: 'MS 10/18/2021 14:34:57'!
add: aPortfolioEntry
	
	aPortfolioEntry addToPortfolio: self.! !

!Portfolio methodsFor: 'addingAccountsOrPortfolios' stamp: 'MS 10/18/2021 15:01:06'!
addAncestor: aPortfolio

	ancestors add: aPortfolio.! !

!Portfolio methodsFor: 'addingAccountsOrPortfolios' stamp: 'MS 10/18/2021 16:31:40'!
addPortfolio: aPortfolio

	self assertThatPortfolioCanBeAdded: aPortfolio.

	aPortfolio addAncestor: self.
	portfoliosEntries add: aPortfolio.! !

!Portfolio methodsFor: 'addingAccountsOrPortfolios' stamp: 'MS 10/18/2021 14:54:33'!
addReceptiveAccount: anAccount
	
	(portfoliosEntries anySatisfy: [:account | account = anAccount ]) ifTrue: [self error: Portfolio accountIsAlreadyInHierarchyErrorDescription].
	
	portfoliosEntries add: anAccount.! !

!Portfolio methodsFor: 'addingAccountsOrPortfolios' stamp: 'MS 10/18/2021 14:36:42'!
addToPortfolio: aPortfolio

	aPortfolio addPortfolio: self.! !

!Portfolio methodsFor: 'addingAccountsOrPortfolios' stamp: 'MS 10/18/2021 16:30:20'!
assertThatPortfolioCanBeAdded: aPortfolio
	(self mainAncestors anySatisfy: [:aPortfolioAncestor| aPortfolio cannotBeAddedTo: aPortfolioAncestor ]) 
		ifTrue: [self error: self class portfolioIsAlreadyInHierarchyErrorDescription ].
	! !

!Portfolio methodsFor: 'addingAccountsOrPortfolios' stamp: 'MS 10/18/2021 16:44:49'!
cannotBeAddedTo: aPortfolio
	^(aPortfolio hasThePortfolio: self ) or: 
		[ portfoliosEntries anySatisfy: [ :portfolioService | portfolioService cannotBeAddedTo: aPortfolio] ].
	! !

!Portfolio methodsFor: 'addingAccountsOrPortfolios' stamp: 'MS 10/18/2021 16:48:40'!
hasThePortfolio: aPortfolio

	^(portfoliosEntries anySatisfy: [:aPortfolioEntry| aPortfolioEntry hasThePortfolio: aPortfolio ]) 
		or: [	(aPortfolio = self)].
	
	
	! !


!Portfolio methodsFor: 'unclassified' stamp: 'Ch.A 10/17/2021 00:11:15'!
has: aPortfolioEntry
	self = aPortfolioEntry ifTrue:[^true].
	portfoliosEntries detect: [:PortfolioEntry | PortfolioEntry has: aPortfolioEntry  ] ifNone: [^false].
	^true.! !

!Portfolio methodsFor: 'unclassified' stamp: 'MS 10/18/2021 12:11:22'!
hasRegistered: aTransaction
	
	^portfoliosEntries anySatisfy: [:aPortfolioEntry | aPortfolioEntry hasRegistered: aTransaction].
	! !

!Portfolio methodsFor: 'unclassified' stamp: 'MS 10/18/2021 15:15:46'!
isRoot

	^ancestors isEmpty.! !

!Portfolio methodsFor: 'unclassified' stamp: 'MS 10/18/2021 15:18:12'!
mainAncestors
	
	|mainAncestors|
	
	self isRoot ifTrue: [^OrderedCollection with: self].
	
	mainAncestors := OrderedCollection new.
	ancestors do: [:ancestor | mainAncestors addAll: ancestor mainAncestors].
	^mainAncestors.! !


!Portfolio methodsFor: 'as yet unclassified' stamp: 'MS 10/18/2021 12:28:31'!
transactions
	|transactions|
	
	transactions := OrderedCollection new.
	portfoliosEntries do: [:aService | transactions addAll: aService transactions ].
	^transactions.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'MS 10/18/2021 14:52:38'!
accountIsAlreadyInHierarchyErrorDescription
	^'Account already in hierarchy cannot be added'.! !

!Portfolio class methodsFor: 'error messages' stamp: 'MS 10/18/2021 14:53:15'!
portfolioIsAlreadyInHierarchyErrorDescription
	^'Portfolio already in hierarchy cannot be added'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
PortfolioEntry subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'MS 10/18/2021 16:10:08'!
cannotBeAddedTo:aPortfolio

	^aPortfolio has: self.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'MS 10/18/2021 16:48:50'!
hasThePortfolio: aPortfolio

	^false.! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'Ch.A 10/16/2021 19:26:41'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'Alejandro 10/7/2021 20:37:34'!
balance

	^transactions sum: [ :aTransaction | 
		aTransaction balance] 
	ifEmpty: [ 0 ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !


!ReceptiveAccount methodsFor: 'unclassified' stamp: 'Ch.A 10/16/2021 23:44:30'!
has: anAccount
	^self isEqualTo: anAccount.! !


!ReceptiveAccount methodsFor: 'as yet unclassified' stamp: 'MS 10/18/2021 14:43:57'!
addToPortfolio: aPortfolio 

	aPortfolio addReceptiveAccount: self.! !
