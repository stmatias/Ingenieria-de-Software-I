!classDefinition: #CantSuspend category: 'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: 'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: 'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'asserts' stamp: 'goc 9/9/2021 13:26:28'!
assertThatIn: customerBook ThereIsJustOneCustomerNamed: customerName

	self assert: customerBook numberOfCustomers = 1.
	self assert: (customerBook includesCustomerNamed: customerName)! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'MS 9/8/2021 12:17:11'!
assertThatIn: aCustomerBook theNumberOfActiveCustomersIs: aNumberOfActiveCustomers theNumberOfSuspendedCustomersIs: aNumberOfSuspendedCustomers

	self assert: aNumberOfActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aNumberOfSuspendedCustomers equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aNumberOfActiveCustomers+aNumberOfSuspendedCustomers equals: aCustomerBook numberOfCustomers.
	
	
	
	! !

!CustomerBookTest methodsFor: 'asserts' stamp: 'MS 9/8/2021 15:00:33'!
assertThatTheExecutionTimeOf: aBlock takesLessThan: miliseconds 

	|millisecondsBeforeRunning millisecondsAfterRunning|
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aBlock value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < miliseconds .
	
	
	
	! !


!CustomerBookTest methodsFor: 'testing' stamp: 'MS 9/8/2021 15:01:04'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	|customerBook|
	
	customerBook := CustomerBook new.
	
	self assertThatTheExecutionTimeOf: [customerBook addCustomerNamed: 'John Lennon'.] takesLessThan: (50 * millisecond).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MS 9/8/2021 15:05:31'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := self createCustomerBookWithOneCustomerCalled: paulMcCartney.
	
	self assertThatTheExecutionTimeOf: [customerBook removeCustomerNamed: paulMcCartney.] takesLessThan: (50 * millisecond).
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Chen 9/8/2021 21:13:40'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook errorMessage |
			
	customerBook := CustomerBook new.
		
	errorMessage := self checkIfThereIsThisErrorMessage: Error with: [customerBook addCustomerNamed: ''.].
	self assert: errorMessage messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
	self assert: customerBook isEmpty.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'goc 9/9/2021 13:30:47'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
	johnLennon := 'John Lennon'.

	customerBook := self createCustomerBookWithOneCustomerCalled: johnLennon.
	

	self checkIfThereIsThisErrorMessage: NotFound with: [customerBook removeCustomerNamed: 'Paul McCartney'.].
	self assertThatIn: customerBook ThereIsJustOneCustomerNamed: johnLennon.
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MS 9/8/2021 15:07:45'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	paulMcCartney := 'Paul McCartney'.

	customerBook := self createCustomerBookWithOneSuspendedCustomerCalled: paulMcCartney.

	self assertThatIn: customerBook theNumberOfActiveCustomersIs: 0 theNumberOfSuspendedCustomersIs: 1.
	
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'MS 9/8/2021 15:09:01'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	paulMcCartney := 'Paul McCartney'.
	
	customerBook := self createCustomerBookWithOneSuspendedCustomerCalled: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertThatIn: customerBook theNumberOfActiveCustomersIs: 0 theNumberOfSuspendedCustomersIs: 0.

	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'goc 9/9/2021 13:28:12'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
	johnLennon := 'John Lennon'.
	
	customerBook := self createCustomerBookWithOneCustomerCalled: johnLennon .

	self checkIfThereIsThisErrorMessage: CantSuspend with: [customerBook suspendCustomerNamed: 'George Harrison'.].
	self assertThatIn: customerBook ThereIsJustOneCustomerNamed: johnLennon.! !

!CustomerBookTest methodsFor: 'testing' stamp: 'goc 9/9/2021 13:30:09'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
	johnLennon := 'John Lennon'.
	
	customerBook := self createCustomerBookWithOneSuspendedCustomerCalled: johnLennon .
	
	self checkIfThereIsThisErrorMessage: CantSuspend with: [customerBook suspendCustomerNamed: johnLennon.].
	self assertThatIn: customerBook ThereIsJustOneCustomerNamed: johnLennon.! !


!CustomerBookTest methodsFor: 'creation' stamp: 'MS 9/8/2021 15:02:47'!
createCustomerBookWithOneCustomerCalled: aCostumer
	
	|customerBook|
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCostumer.
	^customerBook .

	
	
	
	! !

!CustomerBookTest methodsFor: 'creation' stamp: 'MS 9/8/2021 15:06:57'!
createCustomerBookWithOneSuspendedCustomerCalled: aCostumer
	
	|customerBook|
	
	customerBook := CustomerBook new.
	customerBook addCustomerNamed: aCostumer.
	customerBook suspendCustomerNamed: aCostumer.
	
	^customerBook .

	
	
	
	! !


!CustomerBookTest methodsFor: 'checkErrorMessage' stamp: 'Chen 9/8/2021 21:06:53'!
checkIfThereIsThisErrorMessage: anErrorMessage with: aBlockClosure 
	[aBlockClosure value.
	self fail.]
	on: anErrorMessage
	do: [:ErrorMessage| ^ErrorMessage].! !


!classDefinition: #CustomerBook category: 'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 9/17/2020 07:23:04'!
initialize

	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'MS 9/8/2021 14:34:53'!
removeCustomer: aCostumer from: aCostumerCollection 
 
	1 to: aCostumerCollection size do: 
	[ :index |
		aCostumer= (aCostumerCollection at: index)
			ifTrue: [
				aCostumerCollection removeAt: index.
				^ true. 
			] 
	].
	^false.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'MS 9/8/2021 14:32:46'!
removeCustomerNamed: aName 
 
	(self removeCustomer:aName  from:active)
		ifFalse: [(self removeCustomer:aName from: suspended)
			ifFalse: [^NotFound signal]].! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: 'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:13'!
customerAlreadyExistsErrorMessage

	^'customer already exists!!!!!!'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/12/2021 16:39:09'!
customerCanNotBeEmptyErrorMessage

	^'customer name cannot be empty!!!!!!'! !
