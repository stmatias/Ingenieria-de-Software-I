!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'MS 11/4/2021 14:53:06'!
defaultCatalog
	
	"^ Array with: self itemSellByTheStore"
	
	^ Dictionary new
		at: 'validBook' put:  100;
		yourself! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'validCard expiredCard cardWithEmptyName cardWithInvalidNumber cardWithInvalidName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'setup' stamp: 'MS 11/4/2021 16:31:38'!
setUp
	
	|aValidDate anExpiredDate|
	
	aValidDate := GregorianMonthOfYear yearNumber: (GregorianMonthOfYear current year number) +1 monthNumber: GregorianMonthOfYear current monthNumber.
	
	anExpiredDate := GregorianMonthOfYear yearNumber: (GregorianMonthOfYear current year number) -1 monthNumber: GregorianMonthOfYear current monthNumber.
	
	validCard := CreditCard withNumber: 1111222233334444  expirationOn: aValidDate  ownedBy: 'Hernan'.
	expiredCard := CreditCard withNumber: 1111222233334444 expirationOn: anExpiredDate  ownedBy: 'Hernan'.
	
	cardWithEmptyName := CreditCard withNumber: 1111222233334444  expirationOn: aValidDate  ownedBy: ''.
	cardWithInvalidNumber := CreditCard withNumber: 1  expirationOn: aValidDate  ownedBy: ''.
	cardWithInvalidName := CreditCard withNumber: 1111222233334444  expirationOn: aValidDate  ownedBy: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'.
	
	
	 ! !


!CashierTest methodsFor: 'as yet unclassified' stamp: 'MS 11/1/2021 19:27:28'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog.! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:11:09'!
defaultCatalog
	
	^ Dictionary new
		at: 'validBook' put:  100;
		yourself! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:33:38'!
test01canNotCheckOutWithEmptyCart

	|cart |
	
	cart := self createCart.
	
	self 
		should: [Cahsier for:cart payingWith: validCard .]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
				self assert: anError messageText = 'The cart is empty' .]
	
	
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:33:41'!
test02canNotCheckOutWithExpiredCard

	|cart |
	
	cart := self createCart.
	cart add: 'validBook'.
	
	self 
		should: [Cahsier  for:cart  payingWith: expiredCard  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'The card is expired'.]
	
	
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:33:44'!
test03checkOutReturnsTotalAmountToPay

	|cart creditCard cashier checkOut|
	
	cart := self createCart.
	cart add: 'validBook'.
	creditCard := validCard .
	cashier := Cahsier  for:cart  payingWith:creditCard .
	
	checkOut := cashier checkOut: cart with: creditCard.
	
	self assert: 100 equals: checkOut.
	
	
	
	
		! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:33:47'!
test04canNotCheckOutWithCreditCardWithEmptyName

	|cart|
	
	cart := self createCart.
	cart add: 'validBook'.
		
	self 
		should: [Cahsier  for:cart  payingWith: cardWithEmptyName  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Can not create a card with empty name'.]
	
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:33:49'!
test05canNotCheckOutWithCreditCardWithInvalidNumber

	|cart|
	
	cart := self createCart.
	cart add: 'validBook'.
		
	self 
		should: [Cahsier  for:cart  payingWith: cardWithInvalidNumber  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Invalid credit card numer'.]
	
	! !

!CashierTest methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:33:53'!
test06canNotCheckOutWithCreditCardWithTooLongName

	|cart|
	
	cart := self createCart.
	cart add: 'validBook'.
		
	self 
		should: [Cahsier  for:cart  payingWith: cardWithInvalidName  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'The name of the owner of the credit card can not exceed 30 digits'.]
	
	! !


!classDefinition: #Cahsier category: 'TusLibros'!
Object subclass: #Cahsier
	instanceVariableNames: 'cart creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cahsier methodsFor: 'initialization' stamp: 'MS 11/4/2021 15:23:32'!
initializeWith: aCart payingWith: aCreditCard

	cart := aCart.
	creditCard := aCreditCard .! !


!Cahsier methodsFor: 'check out' stamp: 'MS 11/4/2021 15:50:15'!
checkOut: aCart with: aCreditCard
	
	^ aCart total.
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cahsier class' category: 'TusLibros'!
Cahsier class
	instanceVariableNames: ''!

!Cahsier class methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:04:52'!
EmptyCreditCardNameErrorMessage

	^'Can not create a card with empty name'.



	! !

!Cahsier class methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:00:30'!
InvalidCreditCardNumber

	^'Invalid credit card numer'.



	! !

!Cahsier class methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:23:06'!
assertCartIsNotEmpty: aCart.
	
	aCart isEmpty ifTrue: [self error: self emptyCartErrorMessage].
	
	



	! !

!Cahsier class methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:21:41'!
assertCreditCardIs16DigitLength: aCreditCard.

	(aCreditCard number decimalDigitLength = 16) ifFalse: [self error: self InvalidCreditCardNumber].

	

	



	! !

!Cahsier class methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:20:39'!
assertCreditCardIsNotExpired: aCreditCard.
	
	( aCreditCard expirationDate < GregorianMonthOfYear current) ifTrue: [self error: self expiredCardErrorMessage ].
	

	! !

!Cahsier class methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:30:01'!
assertCreditCardNameIsNoLongerThan30Digits: aCreditCard.
	
	^ self assert: (aCreditCard owner size <= 30) description: [self error: self invalidCreditCardNameErrorMessage].




	! !

!Cahsier class methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:22:35'!
assertCreditCardNameIsNotEmpty: aCreditCard.	

	(aCreditCard owner = '') ifTrue: [self error: self EmptyCreditCardNameErrorMessage ].
	
	



	! !

!Cahsier class methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 15:21:04'!
emptyCartErrorMessage

	^'The cart is empty'.



	! !

!Cahsier class methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 15:21:15'!
expiredCardErrorMessage

	^'The card is expired'.



	! !

!Cahsier class methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:24:02'!
for: aCart payingWith: aCreditCard 

	self assertCreditCardIsNotExpired: aCreditCard.
	self assertCreditCardIs16DigitLength: aCreditCard.
	self assertCreditCardNameIsNotEmpty: aCreditCard.
	self assertCreditCardNameIsNoLongerThan30Digits: aCreditCard.
	
	
	self assertCartIsNotEmpty: aCart.	
	
	^self new initializeWith: aCart payingWith: aCreditCard.
	



	! !

!Cahsier class methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:30:01'!
invalidCreditCardNameErrorMessage

	^'The name of the owner of the credit card can not exceed 30 digits'.

	




	! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'MS 11/4/2021 14:54:49'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'MS 11/4/2021 15:24:27'!
items

	^items copy.! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !

!Cart methodsFor: 'queries' stamp: 'MS 11/4/2021 15:49:48'!
total

	^items sum: [:anItem | catalog at: anItem].! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'number expirationDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MS 11/3/2021 18:36:11'!
expirationDate

	^expirationDate 
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MS 11/3/2021 18:36:51'!
initializeWith: aCreditCardNumber expirationOn: anExpirationDate ownedBy: aPerson

	number := aCreditCardNumber.
	expirationDate := anExpirationDate.
	owner := aPerson.
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MS 11/3/2021 18:36:04'!
number

	^number.
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'MS 11/3/2021 18:36:29'!
owner

	^owner.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 15:59:40'!
InvalidCreditCardName

	^'Can not create a card with empty name'.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'MS 11/1/2021 20:13:29'!
InvalidCreditCardNumber

	^'Invalid credit card numer'.! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'MS 11/3/2021 18:31:42'!
signalInvalidCreditCardName

	self error: self InvalidCreditCardName! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'MS 11/1/2021 20:13:15'!
signalInvalidCreditCardNumber

	self error: self InvalidCreditCardNumber! !

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'MS 11/4/2021 16:07:03'!
withNumber: aCreditCardNumber expirationOn: anExpirationDate ownedBy: aPerson

	"(aCreditCardNumber decimalDigitLength = 16) ifFalse: [self signalInvalidCreditCardNumber].
	(aPerson = '') ifTrue: [self signalInvalidCreditCardName ].
"
	
	^self new initializeWith: aCreditCardNumber expirationOn: anExpirationDate ownedBy: aPerson.! !
