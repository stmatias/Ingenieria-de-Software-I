!classDefinition: #CartTest category: 'TusLibros'!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'error' stamp: 'MS 11/1/2021 11:36:51'!
test02canNotAddABookThatIsNotInTheCatalogue

	|cart catalogue |
	
	catalogue := OrderedCollection new.
	
	cart := Cart for: catalogue.
	
	self
		should: [cart add: 'Smalltalk80' withQuantity: 1]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = 'Cant add a book that is not in the collection'].
	
	! !

!CartTest methodsFor: 'error' stamp: 'MS 11/1/2021 11:38:28'!
test05canNotAddZeroBooks

	|cart bookCollection |
	
	bookCollection := OrderedCollection with: 'Smalltalk80'.
	
	cart := Cart for: bookCollection.
	
	self
		should: [cart add: 'Smalltalk80' withQuantity: 0]
		raise: Error
		withMessageText: Cart bookCanNotBeAddedANonNaturalNumberOfTimesErrorDescription. 
		
	
	! !

!CartTest methodsFor: 'error' stamp: 'MS 11/1/2021 11:39:02'!
test06canNotAddANegativeAmountOfBooks

	|cart bookCollection |
	
	bookCollection := OrderedCollection with: 'Smalltalk80'.
	
	cart := Cart for: bookCollection.
	
	self
		should: [cart add: 'Smalltalk80' withQuantity: -2]
		raise: Error
		withMessageText: Cart bookCanNotBeAddedANonNaturalNumberOfTimesErrorDescription. 
		
	
	! !

!CartTest methodsFor: 'error' stamp: 'MS 11/1/2021 11:38:54'!
test07canNotAddNonNaturalAmountOfBooks

	|cart bookCollection |
	
	bookCollection := OrderedCollection with: 'Smalltalk80'.
	
	cart := Cart for: bookCollection.
	
	self
		should: [cart add: 'Smalltalk80' withQuantity: 1.9]
		raise: Error
		withMessageText: Cart bookCanNotBeAddedANonNaturalNumberOfTimesErrorDescription. 
		
	
	! !


!CartTest methodsFor: 'test' stamp: 'MS 11/1/2021 11:36:05'!
test01aCartContainsEmptyCollectionOfBooksWhenCreated

	|cart bookCollection |
	
	bookCollection := OrderedCollection new.
	
	cart := Cart for: bookCollection.
	
	self assert: (OrderedCollection new) equals: cart list.
	
	! !

!CartTest methodsFor: 'test' stamp: 'MS 11/1/2021 11:37:28'!
test03aBookInTheCatalogueIsSuccesfullyAdded

	|cart catalogue expected|
	
	catalogue := OrderedCollection with: 'Smalltalk80'.
	
	cart := Cart for: catalogue.
	
	cart add: 'Smalltalk80' withQuantity: 1.
	
	expected := OrderedCollection with: 'Smalltalk80'.
	self assert: expected equals: cart list.! !

!CartTest methodsFor: 'test' stamp: 'MS 11/1/2021 11:37:48'!
test04canAddMultipleTimesABookThatIsInTheCatalogue

	|cart bookCollection expected|
	
	bookCollection := OrderedCollection with: 'Smalltalk80'.
	
	cart := Cart for: bookCollection.
	
	cart add: 'Smalltalk80' withQuantity: 2.

	expected := OrderedCollection with: 'Smalltalk80' with: 'Smalltalk80'.
	self assert: expected equals: cart list.! !

!CartTest methodsFor: 'test' stamp: 'MS 11/1/2021 11:39:58'!
test08canAddMultipleBooksThatAreInTheCatalogue

	|cart bookCollection expected|
	
	bookCollection := OrderedCollection with: 'Smalltalk80' with: '1984'.
	
	cart := Cart for: bookCollection.
	
	cart add: 'Smalltalk80' withQuantity: 1.
	cart add: '1984' withQuantity: 1.

	expected := OrderedCollection with: 'Smalltalk80' with: '1984'.
	self assert: expected equals: cart list.! !


!classDefinition: #Cart category: 'TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'list catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'initialization' stamp: 'MS 11/1/2021 11:21:14'!
initializeWith: aBookCollection

	list := OrderedCollection new.
	catalog := aBookCollection.! !


!Cart methodsFor: 'signal' stamp: 'MS 11/1/2021 11:31:00'!
signalBookCanNotBeAddedANonNaturalNumberOfTimes

	^ self error: self class bookCanNotBeAddedANonNaturalNumberOfTimesErrorDescription.! !

!Cart methodsFor: 'signal' stamp: 'MS 11/1/2021 11:30:51'!
signalBookNotInCollection
	
	^self error: self class errorBookNotInCollection.! !


!Cart methodsFor: 'assertions' stamp: 'MS 11/1/2021 11:42:31'!
assertAmountIsNatural: anAmount.
	
	(anAmount isInteger and: [anAmount>0]) ifFalse: 
		[self signalBookCanNotBeAddedANonNaturalNumberOfTimes ].
	
	
	
	
	! !

!Cart methodsFor: 'assertions' stamp: 'MS 11/1/2021 11:43:23'!
assertBookInInCatalog: aBook.
	
	(catalog includes: aBook ) ifFalse: [self signalBookNotInCollection].
	
	
	! !


!Cart methodsFor: 'list' stamp: 'MS 10/28/2021 21:07:54'!
list
	
	^list! !


!Cart methodsFor: 'add' stamp: 'MS 11/1/2021 11:43:34'!
add: aBook withQuantity: anAmount
	
	self assertBookInInCatalog: aBook.
	self assertAmountIsNatural: anAmount.
	
	list add: aBook withOccurrences: anAmount .
	
	
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'as yet unclassified' stamp: 'MS 11/1/2021 11:30:17'!
bookCanNotBeAddedANonNaturalNumberOfTimesErrorDescription
	
	^'Books can not be added a non natural number of times'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'MS 10/28/2021 21:17:15'!
errorBookNotInCollection
	
	^'Cant add a book that is not in the collection'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'MS 10/28/2021 21:05:59'!
for: aBookCollection

	^self new initializeWith: aBookCollection.! !
