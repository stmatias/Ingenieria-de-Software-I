!classDefinition: #PortfolioTest category: 'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 13:50:25'!
test01

	| portfolio |
	portfolio := Portfolio new.
	self assert: 0 equals: (portfolio balance).
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 19:23:05'!
test02

	| portfolio account1 |
	portfolio := Portfolio new.
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	portfolio addAccount: account1.
	self assert: 100 equals: (portfolio balance).
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 19:23:05'!
test03

	| portfolio account1 account2 |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account2.
	
	portfolio := Portfolio new.
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	self assert: 200 equals: (portfolio balance).
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 19:23:05'!
test04

	| portfolio account1 account2 account3 |
	
	account1 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account2.
	account3 := ReceptiveAccount new.
	Deposit register: 100 on: account3.
	
	portfolio := Portfolio new.
	portfolio addAccount: account1.
	portfolio addAccount: account2.
	portfolio addAccount: account3.
	self assert: 300 equals: (portfolio balance).
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 19:23:05'!
test05

	|portfolio account|
	
	
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolio := Portfolio new.
	portfolio addAccount: account.
	
	self 
	should: [portfolio addAccount: account.]
	raise: Error 
	withMessageText: Portfolio duplicateAccountErrorDescription.! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 19:23:05'!
test06

	|portfolioParent portfolioChild account |
	
	portfolioParent := Portfolio new.
	portfolioChild := Portfolio new.
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	
	portfolioChild addAccount: account.
	portfolioParent addPortfolio: portfolioChild.
	
	self assert: portfolioChild balance equals: 	portfolioParent balance.
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 19:23:05'!
test07

	|portfolio account transaction |
	
	portfolio := Portfolio new.
	
	account := ReceptiveAccount new.
	transaction := (Deposit for: 100).
	account register: transaction.
	
	portfolio addAccount: account.
	
	self assert: (portfolio hasRegistered: transaction).
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 19:23:05'!
test08

	|rootPortfolio childPortfolio account1 account2 transaction1 transaction2 |
	
	rootPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transaction1 := (Deposit for: 100).
	transaction2 := (Withdraw for: 50).
	
	account1 register: transaction1.
	account2 register: transaction2.
	
	rootPortfolio addAccount: account1.
	childPortfolio addAccount: account2 .
	
	self assert: (rootPortfolio hasRegistered: transaction1).
	self assert: (childPortfolio hasRegistered: transaction2 ).
	self deny: (rootPortfolio hasRegistered: transaction2).
	self deny: (childPortfolio hasRegistered: transaction1 ).
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 19:23:05'!
test09

	|portfolio1 portfolio2 account |
	
	portfolio1 := Portfolio new.
	portfolio2 := Portfolio new.
	
	account := ReceptiveAccount new.

	portfolio1 addAccount: account.
	portfolio2 addAccount: account.
	
	self assert: (portfolio1 hasAccount: account).
	self assert: (portfolio2 hasAccount: account).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 18:56:53'!
test10

	|rootPortfolio1 rootPortfolio2 childPortfolio |
	
	rootPortfolio1 := Portfolio new.
	rootPortfolio2 := Portfolio new.
	childPortfolio := Portfolio new.
	
	rootPortfolio1 addPortfolio: childPortfolio .
	rootPortfolio2 addPortfolio: childPortfolio .
	
	self assert: (rootPortfolio1 hasPortfolio: childPortfolio ).
	self assert: (rootPortfolio2 hasPortfolio: childPortfolio ).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 19:00:27'!
test11

	|portfolio |
	
	portfolio := Portfolio new.
	self 
	should: [portfolio addPortfolio: portfolio]
	raise: Error 
	withMessageText: Portfolio cantAddPortfolioErrorDescription.
		
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 19:15:04'!
test12

	|rootPortfolio childPortfolio |
	
	rootPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	rootPortfolio addPortfolio: childPortfolio.
	self 
	should: [rootPortfolio addPortfolio: childPortfolio ]
	raise: Error 
	withMessageText: Portfolio cantAddPortfolioErrorDescription.
		
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'Ch.A 10/16/2021 21:31:41'!
test13

	|rootPortfolio childPortfolio |
	
	rootPortfolio := Portfolio new.
	childPortfolio := Portfolio new.
	
	rootPortfolio addPortfolio: childPortfolio.
	self 
	should: [childPortfolio addPortfolio: rootPortfolio]
	raise: Error 
	withMessageText: Portfolio cantAddPortfolioErrorDescription.
		
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


!classDefinition: #Portfolio category: 'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accounts childrenPortfolios parentPortfolios'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'balance' stamp: 'Ch.A 10/16/2021 21:17:52'!
balance
	|res|
	
	res := accounts sum: [:anAccount | anAccount balance] ifEmpty: [0].

	res := res + (childrenPortfolios sum: [:aPortfolio | aPortfolio balance] ifEmpty: [0]).
	
	^res.! !


!Portfolio methodsFor: 'initialization' stamp: 'Ch.A 10/16/2021 21:49:01'!
initialize
	accounts := OrderedCollection new.
	childrenPortfolios := OrderedCollection new.
	parentPortfolios := OrderedCollection new.! !


!Portfolio methodsFor: 'addingAccountsOrPortfolios' stamp: 'Ch.A 10/16/2021 19:26:14'!
addAccount: anAccount

	(accounts includes: anAccount) ifTrue: [^self error: self class duplicateAccountErrorDescription.].
	accounts add: anAccount.! !

!Portfolio methodsFor: 'addingAccountsOrPortfolios' stamp: 'Ch.A 10/16/2021 21:48:44'!
addParentPortfolio: aPortfolio 
	
	parentPortfolios add: aPortfolio.! !

!Portfolio methodsFor: 'addingAccountsOrPortfolios' stamp: 'Ch.A 10/16/2021 21:54:48'!
addPortfolio: aPortfolio 
	
	self = aPortfolio ifTrue: [self error: self class cantAddPortfolioErrorDescription ].
	
	(self hasPortfolio: aPortfolio) ifTrue: [self error: self class cantAddPortfolioErrorDescription ].
	(parentPortfolios includes: aPortfolio) ifTrue: [self error: self class cantAddPortfolioErrorDescription].
	
	childrenPortfolios add: aPortfolio.
	
	aPortfolio addParentPortfolio: self.! !


!Portfolio methodsFor: 'unclassified' stamp: 'Ch.A 10/16/2021 19:19:34'!
hasAccount: anAccount 
	accounts detect: [:account | account = anAccount ] ifNone: [^false].
	^true.! !

!Portfolio methodsFor: 'unclassified' stamp: 'Ch.A 10/16/2021 19:18:21'!
hasPortfolio: aPortfolio 
	childrenPortfolios detect: [:portfolio | portfolio = aPortfolio  ] ifNone: [^false].
	^true.! !

!Portfolio methodsFor: 'unclassified' stamp: 'Ch.A 10/16/2021 18:51:12'!
hasRegistered: aTransaction
	accounts detect: [:anAccount | anAccount hasRegistered: aTransaction] ifNone:[^false].
	^true.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'error messages' stamp: 'Ch.A 10/16/2021 19:01:01'!
cantAddPortfolioErrorDescription
	^'Porfolio cant be added'.! !

!Portfolio class methodsFor: 'error messages' stamp: 'Ch.A 10/16/2021 18:28:08'!
duplicateAccountErrorDescription
	^'Account is duplicate'.! !


!classDefinition: #ReceptiveAccount category: 'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


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
