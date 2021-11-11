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

!CashierTest methodsFor: 'tests' stamp: 'MS 11/10/2021 20:27:53'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn: salesBook
			with: testObjectsFactory transactionID ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'MS 11/10/2021 20:28:32'!
test02CalculatedTotalIsCorrect

	| cart cashier salesBook |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	salesBook := Dictionary new.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: salesBook
		with: testObjectsFactory transactionID.
		
	self assert: (salesBook at: cashier checkOut) total  = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'MS 11/10/2021 20:28:36'!
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
				registeringOn: salesBook
				with: testObjectsFactory transactionID ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'MS 11/10/2021 20:30:29'!
test04CheckoutRegistersASale

	| cart cashier salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := Dictionary new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		with: testObjectsFactory transactionID.
		
	cashier checkOut.
					
	self assert: salesBook size = 1."
	self assert: salesBook first total = total."! !

!CashierTest methodsFor: 'tests' stamp: 'MS 11/10/2021 20:31:49'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook transactionId creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := Dictionary new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook
		with: testObjectsFactory transactionID.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	transactionId := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = (salesBook at: transactionId) total.! !

!CashierTest methodsFor: 'tests' stamp: 'MS 11/10/2021 20:28:51'!
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
		registeringOn: salesBook
		with: testObjectsFactory transactionID.
		
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


!classDefinition: #RestInterfaceTest category: 'TusLibros'!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'interface testObjectsFactory debitBehavior clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'test: create cart' stamp: 'MS 11/11/2021 15:50:08'!
test01cannotCreateCartWithInvalidUser
	
	self should:[ interface createCartFor: self anInvalidUser with: self aValidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ : anError | 
			self assert: anError messageText equals: interface invalidUserOrPasswordErrorDescription]
	
	
	! !

!RestInterfaceTest methodsFor: 'test: create cart' stamp: 'MS 11/11/2021 15:49:39'!
test02cannotCreateCartWithInvalidPassword
	
	self should:[ interface createCartFor: self aValidUser with: self anInvalidPassword ]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ : anError | 
			self assert: anError messageText equals: interface invalidUserOrPasswordErrorDescription]
	
	
	! !

!RestInterfaceTest methodsFor: 'test: create cart' stamp: 'MS 11/11/2021 15:50:36'!
test03anEmptyCartHasZeroItems
	
	| cartId|
		
	cartId := interface createCartFor: self aValidUser with: self aValidPassword.
	
	self assert: (interface listCart: cartId) isEmpty.
	
	
	
	! !


!RestInterfaceTest methodsFor: 'test: adding books' stamp: 'MS 11/11/2021 15:51:50'!
test04addingAnInvalidBookToCartShouldThrowError
	
	|cartId|
	
	cartId := interface createCartFor: self aValidUser with:self aValidPassword.
	
	self should:[ interface addToCart: cartId book:self anInvalidBook bookQuantity:1 ]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[ : anError |
		self assert: anError messageText equals: interface invalidItemErrorMessage.
		self assert: (interface listCart: cartId) isEmpty.]
	
	
	
	
	! !

!RestInterfaceTest methodsFor: 'test: adding books' stamp: 'MS 11/11/2021 15:52:00'!
test05addingAValidBookToInvalidCartIdShouldThrowError
	
	
	self should:[ interface addToCart: -50 book: self aValidBook bookQuantity:1 ]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[ : anError |
		self assert: anError messageText equals: interface invalidCartIdErrorMessage.
		]
	
	
	
	
	! !


!RestInterfaceTest methodsFor: 'test: list cart' stamp: 'MS 11/11/2021 15:57:30'!
test06listingACartWithValidCartIdReturnsItsItems
	
	|cartId booksInCart expected|
	
	cartId := interface createCartFor: self aValidUser with: self aValidPassword.
	
	interface addToCart: cartId book:'validBook' bookQuantity:1.
	
	booksInCart := interface listCart: cartId.
	
	expected := Bag with: self aValidBook .

	self assert: expected equals: booksInCart.! !

!RestInterfaceTest methodsFor: 'test: list cart' stamp: 'MS 11/11/2021 15:54:25'!
test07listingACartWithValidCartIdReturnsItsThreeItems
	
	| cartId booksInCart expected|
	
	cartId := interface createCartFor: self aValidUser with: self aValidPassword.
	
	interface addToCart: cartId book:'validBook' bookQuantity:3.
	
	booksInCart := interface listCart: cartId.
	
	expected := Bag new.
	expected add:'validBook' withOccurrences: 3.
	
	self assert: expected equals: booksInCart.
	
	
	
	
	
	
	
	
	! !

!RestInterfaceTest methodsFor: 'test: list cart' stamp: 'MS 11/11/2021 15:54:56'!
test08listingACartWithValidCartIdReturnsItsFiveItems
	
	| cartId booksInCart expected|
	
	cartId := interface createCartFor: self aValidUser with: self aValidPassword.
	
	interface addToCart: cartId book:'validBook' bookQuantity:2.
	interface addToCart: cartId book:'validBook2' bookQuantity:3.
	
	booksInCart := interface listCart: cartId.
	
	expected := Bag new.
	expected add:'validBook' withOccurrences:2.
	expected add:'validBook2' withOccurrences:3.
	
	self assert: expected equals: booksInCart.
	
	
	
	
	
	
	
	
	! !


!RestInterfaceTest methodsFor: 'test: checkout' stamp: 'MS 11/11/2021 16:12:47'!
test09cannotCheckoutWithInvalidCartId
	
	self should:[ interface checkOut: -50 withCreditCard: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ : anError |
			self assert: anError messageText equals: interface invalidCartIdErrorMessage.		]
	
	
	
	
	
	
	
	
	! !

!RestInterfaceTest methodsFor: 'test: checkout' stamp: 'MS 11/11/2021 16:12:47'!
test10cannotCheckoutEmptyCart
	| cartId |
	
	cartId := interface createCartFor: self aValidUser with:  self aValidPassword.
	
	self should:[ interface checkOut: cartId withCreditCard: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today]
	raise: Error - MessageNotUnderstood
	withExceptionDo:[ : anError |
		self assert: anError messageText equals: interface cartCanNotBeEmptyErrorMessage.
		]
	
	
	
	
	
	
	
	
	! !

!RestInterfaceTest methodsFor: 'test: checkout' stamp: 'MS 11/11/2021 16:12:47'!
test11canNotCheckoutWithAnExpiredCreditCard
	| cartId |
	
	cartId := interface createCartFor: self aValidUser with: self aValidPassword.
	interface addToCart: cartId book: self aValidBook  bookQuantity: 1.
	
	self should:[ interface checkOut: cartId withCreditCard: testObjectsFactory expiredCreditCard on: testObjectsFactory today]
		raise: Error - MessageNotUnderstood
		withExceptionDo:[ : anError |
			self assert: anError messageText equals: interface canNotChargeAnExpiredCreditCardErrorMessage.]
	
	
	
	
	
	
	
	
	! !


!RestInterfaceTest methodsFor: 'test: list purchase' stamp: 'MS 11/11/2021 16:12:47'!
test12listPurchasesReturnsEveryBookAndTotalPrice
	
	| cartId expected purchases|
	
	cartId := interface createCartFor: self aValidUser with: self aValidPassword.
	
	interface addToCart: cartId book:'validBook' bookQuantity:2.
	interface addToCart: cartId book:'validBook2' bookQuantity:5.
	
	interface checkOut: cartId withCreditCard: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today.
	
	purchases := interface listPurchases: self aValidUser withPassword: self aValidPassword.
	
	expected := Dictionary new
		at: 'validBook' put: 2;
		at: 'validBook2' put: 5;
		at: 'Total' put: (20+100);
		yourself.	
		
	self assert: expected equals: purchases .
	! !

!RestInterfaceTest methodsFor: 'test: list purchase' stamp: 'MS 11/11/2021 16:13:38'!
test13canNotListPurchaseOfAnInvalidCustomer
	
	self
		should: [interface listPurchases: self anInvalidUser withPassword: self aValidPassword]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: interface invalidUserOrPasswordErrorDescription ]! !

!RestInterfaceTest methodsFor: 'test: list purchase' stamp: 'MS 11/11/2021 16:14:01'!
test14canNotListPurchaseOfAValidUserWithInvalidPassword
	
	self
		should: [interface listPurchases: self aValidUser  withPassword: self anInvalidPassword  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: interface invalidUserOrPasswordErrorDescription ]! !


!RestInterfaceTest methodsFor: 'setup' stamp: 'MS 11/11/2021 15:51:41'!
aValidBook
	
	^'validBook' ! !

!RestInterfaceTest methodsFor: 'setup' stamp: 'MS 11/11/2021 15:49:55'!
aValidPassword
	
	^'ValidPassword1'.
	! !

!RestInterfaceTest methodsFor: 'setup' stamp: 'MS 11/11/2021 15:48:03'!
aValidUser
	
	^'ValidUser1'.
	! !

!RestInterfaceTest methodsFor: 'setup' stamp: 'MS 11/11/2021 15:51:25'!
anInvalidBook
	
	^'anInvalidBook'.! !

!RestInterfaceTest methodsFor: 'setup' stamp: 'MS 11/11/2021 15:49:20'!
anInvalidPassword
	
	^'InvalidPassword1'.
		
! !

!RestInterfaceTest methodsFor: 'setup' stamp: 'MS 11/11/2021 15:48:28'!
anInvalidUser
	
	^'InvalidUser'.
	! !

!RestInterfaceTest methodsFor: 'setup' stamp: 'MS 11/10/2021 20:49:44'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !

!RestInterfaceTest methodsFor: 'setup' stamp: 'MS 11/11/2021 16:29:47'!
setUp
	|catalog validUsersAndPasswords|
	
	validUsersAndPasswords := Dictionary new 
		at:'ValidUser1' put:'ValidPassword1' ; 
		at:'ValidUser2' put:'ValidPassword2' ; 
		yourself.
	
	catalog:= StoreTestObjectsFactory new defaultCatalog.
	
	testObjectsFactory := StoreTestObjectsFactory new.
	clock := Clock for: testObjectsFactory today.	
	
	interface := RestInterface withUsers: validUsersAndPasswords	 withCatalog: catalog withSalesBook: Dictionary new withMerchantProcessor: self withClock: clock.
	
	
	
	debitBehavior := [ :anAmount :aCreditCard | ].
	
! !


!RestInterfaceTest methodsFor: 'test: session expired' stamp: 'MS 11/11/2021 16:32:07'!
test15canNotAddToCartWhenSessionIsExpired

	| cartId |

	cartId := interface createCartFor: self aValidUser with: self aValidPassword.
	clock advanceTime: (interface sessionDuration + 1 minutes) .
	self
		should: [interface addToCart: cartId book: self aValidBook  bookQuantity: 1.]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: interface sessionHasExpiredErrorDescription.
			clock resetTime: interface sessionDuration.
			self assert: (interface listCart: cartId) isEmpty ]! !

!RestInterfaceTest methodsFor: 'test: session expired' stamp: 'MS 11/11/2021 15:59:12'!
test16canNotListCartWhenSessionIsExpired

	| cartId |

	cartId := interface createCartFor: self aValidUser with: self aValidPassword.
	clock advanceTime: (interface sessionDuration + 1 minutes) .
	self
		should: [interface listCart: cartId]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: interface sessionHasExpiredErrorDescription ]! !

!RestInterfaceTest methodsFor: 'test: session expired' stamp: 'MS 11/11/2021 16:12:47'!
test17canNotCheckOutCartWhenSessionIsExpired

	| cartId purchase expectedPurchase |

	cartId := interface createCartFor: self aValidUser with: self aValidPassword.
	interface addToCart: cartId book: self aValidBook bookQuantity: 2.
	clock advanceTime: (interface sessionDuration + 1 minutes) .
	self
		should: [interface checkOut: cartId withCreditCard: testObjectsFactory notExpiredCreditCard on: testObjectsFactory today]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: interface sessionHasExpiredErrorDescription.
			purchase := interface listPurchases: self aValidUser withPassword: self aValidPassword.
			expectedPurchase := Dictionary new at: 'Total' put: 0; yourself.
			self assert: expectedPurchase equals: purchase ]! !


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

!Cart methodsFor: 'adding' stamp: 'MS 11/11/2021 16:26:56'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.
	
	items add: anItem withOccurrences: aQuantity .! !


!Cart methodsFor: 'detail' stamp: 'MS 11/10/2021 22:18:32'!
detail
	| detail |
	
	detail := OrderedDictionary new.

	items do: [ :item |detail at: item put: (items occurrencesOf: item)		].
	
	^ detail! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: 'TusLibros'!
Object subclass: #CartSession
	instanceVariableNames: 'cart owner interface lastTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'adding' stamp: 'MS 11/11/2021 15:44:43'!
add: anAmount of: aBook 
	
	self assertCartHasNotExpired .

	^cart add: anAmount of: aBook .! !


!CartSession methodsFor: 'initialization' stamp: 'MS 11/11/2021 16:30:28'!
initializedWith: aCart ownedBy: aCustomer with: anInterface

	cart := aCart.
	owner := aCustomer .
	interface := anInterface.
	lastTime := anInterface now.
! !


!CartSession methodsFor: 'total' stamp: 'MS 11/11/2021 14:41:27'!
total
	
	^cart total! !


!CartSession methodsFor: 'assertion' stamp: 'MS 11/11/2021 16:30:15'!
assertCartHasNotExpired

	(lastTime + interface sessionDuration) < interface now ifTrue: [ self signalCartSessionExpired ].	
! !


!CartSession methodsFor: 'signal' stamp: 'MS 11/11/2021 16:30:15'!
signalCartSessionExpired

	self error: interface sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'items' stamp: 'MS 11/11/2021 14:41:43'!
detail
	
	^cart detail.! !

!CartSession methodsFor: 'items' stamp: 'MS 11/11/2021 15:44:55'!
getItems
	
	self assertCartHasNotExpired.
	^cart getItems! !

!CartSession methodsFor: 'items' stamp: 'MS 11/11/2021 14:41:04'!
isEmpty
	
	^cart isEmpty ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: 'TusLibros'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'as yet unclassified' stamp: 'MS 11/10/2021 19:23:26'!
for: aCart ownedBy: aCustomer with: aSystemFacade

	^self new initializedWith: aCart ownedBy: aCustomer with: aSystemFacade.! !


!classDefinition: #Cashier category: 'TusLibros'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total customer transactionsIDs'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'MS 11/11/2021 15:43:07'!
createSale

	^ Sale for:cart detail with: total .
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'MS 11/10/2021 20:21:31'!
registerSale

	| sale transactionID |
	sale := self createSale.
	transactionID := transactionsIDs nextTransactionId .
	
	salesBook at: transactionID put: sale.
	
	^transactionID.
! !


!Cashier methodsFor: 'checkout' stamp: 'MS 11/10/2021 20:04:03'!
checkOut

	| sale |
	self calculateTotal.
	self debitTotal.
	sale := self registerSale.

	^ sale! !


!Cashier methodsFor: 'initialization' stamp: 'MS 11/10/2021 20:23:13'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook with: aTransactionID
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	transactionsIDs := aTransactionID.! !

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


!Cashier class methodsFor: 'instance creation' stamp: 'MS 11/10/2021 20:28:11'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook with: aTransactionId 
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook with: aTransactionId! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #Clock category: 'TusLibros'!
Object subclass: #Clock
	instanceVariableNames: 'now'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Clock methodsFor: 'moving time' stamp: 'MS 11/11/2021 13:53:43'!
advanceTime: aDuration 
	
	now := now + aDuration ! !

!Clock methodsFor: 'moving time' stamp: 'MS 11/11/2021 16:32:07'!
resetTime: aDuration

	now := now - aDuration  ! !


!Clock methodsFor: 'now' stamp: 'MS 11/11/2021 13:51:42'!
now

	^now.! !


!Clock methodsFor: 'initialization' stamp: 'MS 11/11/2021 13:51:16'!
initializeWith: aTime

	now := aTime ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Clock class' category: 'TusLibros'!
Clock class
	instanceVariableNames: ''!

!Clock class methodsFor: 'as yet unclassified' stamp: 'MS 11/11/2021 13:51:31'!
for: aTime

	^self new initializeWith: aTime! !


!classDefinition: #CreditCard category: 'TusLibros'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration customerName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

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


!classDefinition: #RestInterface category: 'TusLibros'!
Object subclass: #RestInterface
	instanceVariableNames: 'catalog salesBook merchantProcessor users cartIdCounter cartSessions transactionID cartToClient clientsTransactions clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'error handling' stamp: 'MS 11/11/2021 14:40:01'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^ Cashier canNotChargeAnExpiredCreditCardErrorMessage.! !

!RestInterface methodsFor: 'error handling' stamp: 'MS 11/11/2021 14:33:17'!
cartCanNotBeEmptyErrorMessage
	
	^ Cashier cartCanNotBeEmptyErrorMessage.! !

!RestInterface methodsFor: 'error handling' stamp: 'goc 11/4/2021 21:03:40'!
invalidCartIdErrorMessage
	^ 'Invalid CartId'.! !

!RestInterface methodsFor: 'error handling' stamp: 'goc 11/4/2021 20:56:30'!
invalidItemErrorMessage
	^ 'Invalid item'.! !

!RestInterface methodsFor: 'error handling' stamp: 'goc 11/4/2021 20:28:57'!
invalidUserOrPasswordErrorDescription
	^ 'Invalid user or password'.! !


!RestInterface methodsFor: 'initialization' stamp: 'MS 11/11/2021 15:07:39'!
initializeWith: usersWithPasswords withCatalog: aCatalog withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor withClock: aClock  
	
	users := usersWithPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.

	cartSessions := Dictionary new.
	cartIdCounter := 0.
	
	transactionID := 1.
	
	cartToClient := Dictionary new.
	
	clientsTransactions := Dictionary new.
	clock := aClock.! !


!RestInterface methodsFor: 'check out' stamp: 'MS 11/11/2021 16:22:02'!
checkOut: cartId withCreditCard: aCreditCard on: aDate
	
	|cart cashier transactionId client |
	
	cart := cartSessions at: cartId ifAbsent:[self error: self invalidCartIdErrorMessage].
	
	(cart isEmpty) ifTrue:[self error: self cartCanNotBeEmptyErrorMessage].
	
	cart assertCartHasNotExpired.
	
	cashier := Cashier 
		toCheckout: cart 
		charging: aCreditCard  
		throught: merchantProcessor 
		on: aDate 
		registeringOn: salesBook
		with: self.
		
	transactionId := cashier checkOut .
	
	client := cartToClient removeKey: cartId.
	
	self updateClienTransactions: client with: transactionId.
	
	^transactionId.
	
	
	! !

!RestInterface methodsFor: 'check out' stamp: 'MS 11/11/2021 16:21:25'!
updateClienTransactions: aClient with: aTransactionID

	|clientTransactions|
	
	clientTransactions := clientsTransactions at: aClient ifAbsent: [ OrderedCollection new ].
	clientTransactions add: aTransactionID .
	clientsTransactions at: aClient put: clientTransactions .
	
	
	
	! !


!RestInterface methodsFor: 'adding' stamp: 'MS 11/10/2021 19:31:55'!
addToCart: cartId book: aBook bookQuantity: aQuantity 
	 
	|cart|
	cart := cartSessions at: cartId ifAbsent:[^ self error: self invalidCartIdErrorMessage].
	
	catalog at: aBook ifAbsent:[^ self error: self invalidItemErrorMessage].
	
	cart add: aQuantity of: aBook.! !


!RestInterface methodsFor: 'unclassified' stamp: 'MS 11/11/2021 16:05:32'!
createCartFor: aUser with: aUserPassword 
	
	| cart|
	
	self assert: aUser with: aUserPassword.
	
	cartIdCounter := cartIdCounter + 1.
	
	cart := CartSession for: (Cart acceptingItemsOf: catalog) ownedBy: aUser with: self.
	
	cartSessions at: cartIdCounter put:cart.
	
	cartToClient at: cartIdCounter put: aUser.
	
	^cartIdCounter.
	! !

!RestInterface methodsFor: 'unclassified' stamp: 'MS 11/10/2021 19:29:59'!
listCart: aCartId 
	
	^ (cartSessions at: aCartId) getItems.! !

!RestInterface methodsFor: 'unclassified' stamp: 'MS 11/11/2021 16:23:03'!
listPurchases: aUser withPassword: aPassword 
	
	|clientTransactions items total sales |
	
	self assert: aUser with: aPassword.
	
	clientTransactions := clientsTransactions at: aUser ifAbsent: [OrderedCollection new.].
	sales := clientTransactions collect: [:aTransactionID | salesBook at: aTransactionID ].
	
	total := 0.
	items:= Dictionary new.
	
	sales do:[:aSale| 
		aSale items associationsDo: [:aSaleItem | | aQuantity |
			aQuantity := items at: aSaleItem key ifAbsent: [0].
			items at: aSaleItem key put: aQuantity + aSaleItem value
			].
		total := total + aSale total.
	].
	items at: 'Total' put: total. 
	
	^ items.
	
	! !


!RestInterface methodsFor: 'session' stamp: 'MS 11/11/2021 13:59:03'!
now

	^clock now! !

!RestInterface methodsFor: 'session' stamp: 'MS 11/11/2021 13:53:09'!
sessionDuration
	
	^30 minutes.! !

!RestInterface methodsFor: 'session' stamp: 'MS 11/11/2021 14:05:00'!
sessionHasExpiredErrorDescription

	^'The cart session is expired'! !


!RestInterface methodsFor: 'assertions' stamp: 'MS 11/11/2021 16:04:49'!
assert: validUser with: validPassword
	
	|password|
	
	users at: validUser ifAbsent:[self error: self invalidUserOrPasswordErrorDescription].
	
	password := users at: validUser.
	
	( password = validPassword ) ifFalse:[self error: self invalidUserOrPasswordErrorDescription].
	
	! !


!RestInterface methodsFor: 'transaction' stamp: 'MS 11/10/2021 21:01:13'!
nextTransactionId
	
	transactionID := transactionID +1.
	
	^transactionID -1.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: 'TusLibros'!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'class initialization' stamp: 'MS 11/11/2021 14:23:23'!
withUsers: usersWithPasswords withCatalog: aCatalog withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor withClock: aClock
	
	^ self new initializeWith: usersWithPasswords withCatalog: aCatalog withSalesBook: aSalesBook withMerchantProcessor: aMerchantProcessor withClock: aClock.! !


!classDefinition: #Sale category: 'TusLibros'!
Object subclass: #Sale
	instanceVariableNames: 'total items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'MS 11/10/2021 22:18:56'!
items
	
	^ items ! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'MS 11/10/2021 22:15:40'!
initializeWith: someItems andTotal: aTotal

	total := aTotal.
	items := someItems .
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'MS 11/11/2021 15:43:07'!
for: someItems with: aTotal

	^self new initializeWith: someItems andTotal: aTotal
! !


!classDefinition: #StoreTestObjectsFactory category: 'TusLibros'!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today transactionID'
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


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'MS 11/10/2021 20:19:19'!
initialize

	today := DateAndTime now.
	transactionID := 1.! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!StoreTestObjectsFactory methodsFor: 'transaction' stamp: 'MS 11/10/2021 20:20:13'!
nextTransactionId

	transactionID := transactionID +1.
	
	^transactionID-1.! !

!StoreTestObjectsFactory methodsFor: 'transaction' stamp: 'MS 11/10/2021 20:26:52'!
transactionID

	^self.! !
