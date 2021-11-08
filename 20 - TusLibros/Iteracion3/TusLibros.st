!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: 'TusLibros'!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #TusLibrosFacadeTest category: 'TusLibros'!
TestCase subclass: #TusLibrosFacadeTest
	instanceVariableNames: 'interface testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosFacadeTest methodsFor: 'as yet unclassified' stamp: 'goc 11/8/2021 11:58:19'!
setUp
	|catalog validUsersAndPasswords|
	
	validUsersAndPasswords := Dictionary new at:'ValidUser1' put:'ValidPassword1' ; at:'ValidUser2' put:'ValidPassword2' ; yourself.
	
	catalog:= StoreTestObjectsFactory new defaultCatalog.
	
	interface := TusLibrosFacade withUsers: validUsersAndPasswords	 withCatalog: catalog withSalesBook: OrderedCollection new withMerchantProcessor: self.
	
	testObjectsFactory := StoreTestObjectsFactory new.! !

!TusLibrosFacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 11/8/2021 17:53:55'!
test01cannotCreateCartWithInvalidUser
	
	| anInvalidUser aPassword|
	
	anInvalidUser := 'InvalidUser'.
	aPassword := 'pw'.
	
	self should:[ interface createCartFor: anInvalidUser with: aPassword ]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[ : anError | self assert: anError messageText equals: interface invalidUserOrPasswordErrorDescription]
	
	
	! !

!TusLibrosFacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 11/8/2021 17:54:10'!
test02cannotCreateCartWithInvalidPassword
	
	| aValidUser anInvalidPassword|
	
	aValidUser := 'ValidUser1'.
	anInvalidPassword := 'InvalidPassword1'.
	
	self should:[ interface createCartFor: aValidUser with: anInvalidPassword ]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[ : anError | self assert: anError messageText equals: interface invalidUserOrPasswordErrorDescription]
	
	
	! !

!TusLibrosFacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 11/8/2021 17:54:54'!
test03anEmptyCartHasZeroItems
	
	| aValidUser aValidPassword cartId|
	
	aValidUser := 'ValidUser1'.
	aValidPassword := 'ValidPassword1'.
	
	cartId := interface createCartFor: aValidUser with: aValidPassword.
	
	self assert: (interface listCart: cartId) isEmpty.
	
	
	
	! !

!TusLibrosFacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 11/8/2021 17:56:09'!
test04addingAnInvalidBookToCartShouldThrowError
	
	| aValidUser aValidPassword cartId|
	
	aValidUser := 'ValidUser1'.
	aValidPassword := 'ValidPassword1'.
	
	cartId := interface createCartFor: aValidUser with: aValidPassword.
	
	
	
	self should:[ interface addToCart: cartId book:'anInvalidBook' bookQuantity:1 ]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[ : anError |
		self assert: anError messageText equals: interface invalidItemErrorMessage.
		self assert: (interface listCart: cartId) isEmpty.]
	
	
	
	
	! !

!TusLibrosFacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 11/8/2021 18:00:08'!
test05addingAValidBookToInvalidCartIdShouldThrowError
	
	
	self should:[ interface addToCart: -50 book:'validBook' bookQuantity:1 ]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[ : anError |
		self assert: anError messageText equals: interface invalidCartIdErrorMessage.
		]
	
	
	
	
	! !

!TusLibrosFacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 11/8/2021 17:59:52'!
test06listingACartWithValidCartIdReturnsItsItems
	
	| aValidUser aValidPassword cartId booksInCart bag|
	
	aValidUser := 'ValidUser1'.
	aValidPassword := 'ValidPassword1'.
	
	cartId := interface createCartFor: aValidUser with: aValidPassword.
	
	interface addToCart: cartId book:'validBook' bookQuantity:1.
	
	booksInCart := interface listCart: cartId.
	
	bag := Bag new.
	bag add:'validBook'.
	
	self assert: bag equals: booksInCart.
	
	
	
	
	
	
	
	
	! !

!TusLibrosFacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 11/8/2021 18:05:25'!
test07listingACartWithValidCartIdReturnsItsThreeItems
	
	| aValidUser aValidPassword cartId booksInCart bag|
	
	aValidUser := 'ValidUser1'.
	aValidPassword := 'ValidPassword1'.
	
	cartId := interface createCartFor: aValidUser with: aValidPassword.
	
	interface addToCart: cartId book:'validBook' bookQuantity:3.
	
	booksInCart := interface listCart: cartId.
	
	bag := Bag new.
	bag add:'validBook'.
	bag add:'validBook'.
	bag add:'validBook'.
	
	self assert: bag equals: booksInCart.
	
	
	
	
	
	
	
	
	! !

!TusLibrosFacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 11/8/2021 18:06:55'!
test08listingACartWithValidCartIdReturnsItsFiveItems
	
	| aValidUser aValidPassword cartId booksInCart bag|
	
	aValidUser := 'ValidUser1'.
	aValidPassword := 'ValidPassword1'.
	
	cartId := interface createCartFor: aValidUser with: aValidPassword.
	
	interface addToCart: cartId book:'validBook' bookQuantity:2.
	interface addToCart: cartId book:'validBook2' bookQuantity:3.
	
	booksInCart := interface listCart: cartId.
	
	bag := Bag new.
	bag add:'validBook' withOccurrences:2.
	bag add:'validBook2' withOccurrences:3.
	
	
	self assert: bag equals: booksInCart.
	
	
	
	
	
	
	
	
	! !

!TusLibrosFacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 11/8/2021 18:08:02'!
test09cannotCheckoutWithInvalidCartId
	
	self should:[ interface checkOut: -50 withCreditCardNumber: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[ : anError |
		self assert: anError messageText equals: interface invalidCartIdErrorMessage.
		]
	
	
	
	
	
	
	
	
	! !

!TusLibrosFacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 11/8/2021 18:08:26'!
test10cannotCheckoutEmptyCart
	| aValidUser aValidPassword cartId |
	
	aValidUser := 'ValidUser1'.
	aValidPassword := 'ValidPassword1'.
	
	cartId := interface createCartFor: aValidUser with: aValidPassword.
	
	
	self should:[ interface checkOut: cartId withCreditCardNumber: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[ : anError |
		self assert: anError messageText equals: interface cartCanNotBeEmptyErrorMessage.
		]
	
	
	
	
	
	
	
	
	! !

!TusLibrosFacadeTest methodsFor: 'as yet unclassified' stamp: 'AC 11/8/2021 18:08:46'!
test11cannotCheckoutWithAnExpiredCreditCard
	| aValidUser aValidPassword cartId |
	
	aValidUser := 'ValidUser1'.
	aValidPassword := 'ValidPassword1'.
	
	cartId := interface createCartFor: aValidUser with: aValidPassword.
	interface addToCart: cartId book:'validBook'  bookQuantity: 1.
	
	self should:[ interface checkOut: cartId withCreditCardNumber: testObjectsFactory expiredCreditCard on: testObjectsFactory today]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[ : anError |
		self assert: anError messageText equals: interface canNotChargeAnExpiredCreditCardErrorMessage.
		]
	
	
	
	
	
	
	
	
	! !

!TusLibrosFacadeTest methodsFor: 'as yet unclassified' stamp: 'goc 11/8/2021 20:24:22'!
test12
	
	| aValidUser aValidPassword cartId bag purchases|
	
	aValidUser := 'ValidUser1'.
	aValidPassword := 'ValidPassword1'.
	
	cartId := interface createCartFor: aValidUser with: aValidPassword.
	
	interface addToCart: cartId book:'validBook' bookQuantity:5.
	interface addToCart: cartId book:'validBook2' bookQuantity:5.
	
	bag := Bag new.
	bag add:'validBook' withOccurrences:5.
	bag add:'validBook2' withOccurrences:5.
	
	interface checkOut: cartId withCreditCardNumber: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	
	purchases :=interface listPurchases: aValidUser withPassword: aValidPassword.
	
	self assert: purchases equals: bag.
	
	
	
	
	
	
	
	
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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'goc 11/8/2021 11:27:09'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'goc 11/8/2021 11:21:53'!
getItems

	^ items copy.! !

!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


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


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total customer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'goc 11/8/2021 20:08:36'!
createSale

	^ Sale of: total withUser: customer.
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

!Cashier methodsFor: 'initialization' stamp: 'goc 11/8/2021 20:07:12'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook withUser: aUsername
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	customer := aUsername.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !

!Cashier class methodsFor: 'instance creation' stamp: 'goc 11/8/2021 20:08:00'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook withUser: aUsername
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook withUser: aUsername.! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration customerName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'goc 11/8/2021 19:51:52'!
customerName

	^ customerName .! !

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total customer itemsBought'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'goc 11/8/2021 20:20:05'!
isFrom: aUser
	
	^ aUser == customer.! !

!Sale methodsFor: 'total' stamp: 'goc 11/8/2021 20:22:48'!
itemsBought
	
	^ itemsBought! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

!Sale methodsFor: 'initialization' stamp: 'goc 11/8/2021 20:13:13'!
initializeTotal: aTotal withUser: aUsername

	total := aTotal.
	customer := aUsername.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !

!Sale class methodsFor: 'instance creation' stamp: 'goc 11/8/2021 20:13:47'!
of: aTotal withUser: aUsername

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal withUser: aUsername! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'goc 11/8/2021 11:48:46'!
anotherItemSellByTheStore
	
	^ 'validBook2'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'goc 11/8/2021 11:48:59'!
anotherItemSellByTheStorePrice
	
	^ 20! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'goc 11/8/2021 11:48:27'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		at: self anotherItemSellByTheStore put: self anotherItemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #TusLibrosFacade category: 'TusLibros'!
Object subclass: #TusLibrosFacade
	instanceVariableNames: 'catalog salesBook merchantProcessor validUsers cartIdCounter cartIdToCart transactionsId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosFacade methodsFor: 'error handling' stamp: 'goc 11/8/2021 12:31:04'!
canNotChargeAnExpiredCreditCardErrorMessage
	^ Cashier canNotChargeAnExpiredCreditCardErrorMessage.! !

!TusLibrosFacade methodsFor: 'error handling' stamp: 'goc 11/8/2021 12:37:54'!
cartCanNotBeEmptyErrorMessage
	^ Cashier cartCanNotBeEmptyErrorMessage.! !

!TusLibrosFacade methodsFor: 'error handling' stamp: 'goc 11/4/2021 21:03:40'!
invalidCartIdErrorMessage
	^ 'Invalid CartId'.! !

!TusLibrosFacade methodsFor: 'error handling' stamp: 'goc 11/4/2021 20:56:30'!
invalidItemErrorMessage
	^ 'Invalid item'.! !

!TusLibrosFacade methodsFor: 'error handling' stamp: 'goc 11/4/2021 20:28:57'!
invalidUserOrPasswordErrorDescription
	^ 'Invalid user or password'.! !


!TusLibrosFacade methodsFor: 'unclassified' stamp: 'goc 11/8/2021 11:40:40'!
addToCart: cartId book: aBook bookQuantity: aQuantity 
	
	|cart|
	
	"(self isValidCartId: cartId) ifFalse:[^ self error: self invalidCartIdErrorMessage]."
	
	cart := cartIdToCart at: cartId ifAbsent:[^ self error: self invalidCartIdErrorMessage].
	
	catalog at: aBook ifAbsent:[^ self error: self invalidItemErrorMessage].
	
	
	
	
	
	cart add: aQuantity of: aBook.
	
	
	
	
	
	
	
	
	 ! !

!TusLibrosFacade methodsFor: 'unclassified' stamp: 'goc 11/8/2021 20:01:10'!
checkOut: cartId withCreditCardNumber: aCreditCard on: aDate
	
	|cart cashier |
	
	cart := cartIdToCart at: cartId ifAbsent:[^ self error: self invalidCartIdErrorMessage].
	
	(cart isEmpty) ifTrue:[^self error: self cartCanNotBeEmptyErrorMessage].
	
	"self error: self canNotChargeAnExpiredCreditCardErrorMessage."
	"toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook"
	cashier := Cashier toCheckout: cart charging: aCreditCard  throught: merchantProcessor on: aDate registeringOn: salesBook.

	! !

!TusLibrosFacade methodsFor: 'unclassified' stamp: 'goc 11/8/2021 11:15:05'!
createCartFor: aUser with: aUserPassword 
	
	|password cart|
	
	validUsers at: aUser ifAbsent:[self error: self invalidUserOrPasswordErrorDescription].
	
	password := validUsers at: aUser.
	
	( password = aUserPassword ) ifFalse:[self error: self invalidUserOrPasswordErrorDescription].
	
	cartIdCounter := cartIdCounter + 1.
	
	cart := Cart acceptingItemsOf: catalog.
	
	cartIdToCart at: cartIdCounter put:cart.
	
	^cartIdCounter.
	! !

!TusLibrosFacade methodsFor: 'unclassified' stamp: 'goc 11/8/2021 11:05:08'!
initializeWith: usersWithPasswords withCatalog: aCatalog withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor 
	
	validUsers := usersWithPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	cartIdToCart := Dictionary new.
	cartIdCounter := 0.! !

!TusLibrosFacade methodsFor: 'unclassified' stamp: 'goc 11/4/2021 21:12:43'!
isValidCartId: aCartId 
	
	
	^ (aCartId <= cartIdCounter) and: (aCartId > 0) .! !

!TusLibrosFacade methodsFor: 'unclassified' stamp: 'goc 11/8/2021 11:22:44'!
listCart: aCartId 
	
	^ (cartIdToCart at: aCartId) getItems.! !

!TusLibrosFacade methodsFor: 'unclassified' stamp: 'goc 11/8/2021 20:23:06'!
listPurchases: aUser withPassword: aPassword 
	|salesByUser items|
	
	"bag:= Bag new.
	bag add: 'validBook'.
	^bag."
	
	salesByUser := salesBook select:[:aSale| aSale isFrom:aUser].
	items:= Bag new.
	salesByUser do:[:aSale| items add: aSale itemsBought ].
	
	^ items.
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosFacade class' category: 'TusLibros'!
TusLibrosFacade class
	instanceVariableNames: ''!

!TusLibrosFacade class methodsFor: 'class initialization' stamp: 'goc 11/4/2021 20:22:29'!
withUsers: usersWithPasswords withCatalog: aCatalog withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor 
	
	^ self new initializeWith: usersWithPasswords withCatalog: aCatalog withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor.! !
