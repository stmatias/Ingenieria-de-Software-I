!classDefinition: #OOStackTest category: 'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:29:55'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:01'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:09'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'NR 9/16/2021 17:40:17'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'firstSomething'.
	secondPushedObject := 'secondSomething'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:20'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:24'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'NR 5/13/2020 13:30:31'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: 'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: 'aStack aFinder anExpectedCollection emptyStack finderInEmptyStack emptyCollection helloPrefix WinterPrefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MS 9/20/2021 15:23:13'!
test01SentenceFinderReturnsEmptyCollectionIfPrefixIsNotInStack

	self assert: (emptyCollection ) equals: (aFinder find: helloPrefix ).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MS 9/20/2021 15:23:09'!
test02SentenceFinderReturnsEmptyCollectionWhenTheStackIsEmpty

	self assert: (emptyCollection) equals: (finderInEmptyStack find: helloPrefix ).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MS 9/20/2021 15:10:37'!
test03prefixMustNotBeEmpty
	
	self 
		should:[ aFinder find:'' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [: anError | 
			self assert: anError messageText = SentenceFinderByPrefix prefixCanNotBeEmpty ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MS 9/20/2021 15:10:37'!
test04prefixMustNotHaveSpaces
	
	self 
		should:[ aFinder find:'hello there']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [: anError | 
			self assert: anError messageText = SentenceFinderByPrefix prefixCanNotContainSpaces ]! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MS 9/20/2021 15:22:53'!
test05SentenceFinderIsCaseSensitiveAndFindsAllPrefixOcurrencesInStack
	
	self assert: (anExpectedCollection ) equals: (aFinder find: WinterPrefix).! !

!SentenceFinderByPrefixTest methodsFor: 'test' stamp: 'MS 9/20/2021 15:22:42'!
test06SentenceFinderDoesNotModifyStack
	
	self assert: (anExpectedCollection ) equals: (aFinder find: WinterPrefix ).
	
	self assert: aStack size = 6.
	self assert: aStack pop = 'A girl has no name'.
	self assert: aStack pop = 'I like Winter'.
	self assert: aStack pop = 'WINTER is WINTER'.
	self assert: aStack pop = 'wiNter has gone'.
	self assert: aStack pop = 'Winter is coming'.
	self assert: aStack pop = 'Winter is here'.
	self assert: aStack size = 0.
	
	! !


!SentenceFinderByPrefixTest methodsFor: 'setup' stamp: 'MS 9/20/2021 15:20:06'!
setUp
	aStack := OOStack new.
	aStack push: 'Winter is here'.
	aStack push: 'Winter is coming'.
	aStack push: 'wiNter has gone'.
	aStack push: 'WINTER is WINTER'.
	aStack push: 'I like Winter'.
	aStack push: 'A girl has no name'. 
	
	aFinder:= SentenceFinderByPrefix new initialiazeWith: aStack .
	
	anExpectedCollection := OrderedCollection with: 'Winter is coming' with: 'Winter is here'.
	
	emptyStack  := OOStack new.
	finderInEmptyStack := SentenceFinderByPrefix new initialiazeWith: emptyStack.
	emptyCollection := OrderedCollection new.
	
	helloPrefix := 'hello'.
	WinterPrefix := 'Winter'.
	

	! !


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!OOStack methodsFor: 'initialization' stamp: 'goc 9/17/2021 13:54:53'!
initialize
	stack := OrderedCollection new.
	! !


!OOStack methodsFor: 'state' stamp: 'Alejandro 9/16/2021 21:24:09'!
isEmpty
	^ stack isEmpty.! !


!OOStack methodsFor: 'operations' stamp: 'MS 9/20/2021 15:24:21'!
pop
	
	^(OOStackStateHandler new initializeWith: stack) popFrom: stack.! !

!OOStack methodsFor: 'operations' stamp: 'goc 9/17/2021 13:43:07'!
push: aThing
	stack addLast: aThing.
	! !

!OOStack methodsFor: 'operations' stamp: 'Alejandro 9/16/2021 21:33:06'!
size
	^stack size.! !

!OOStack methodsFor: 'operations' stamp: 'MS 9/20/2021 15:24:27'!
top

	^(OOStackStateHandler new initializeWith: stack) getTheTopFrom: stack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: 'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'NR 9/16/2021 17:39:43'!
stackEmptyErrorDescription
	
	^ 'stack is empty!!!!!!'! !


!classDefinition: #OOStackStateHandler category: 'Stack-Exercise'!
Object subclass: #OOStackStateHandler
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateHandler methodsFor: 'as yet unclassified' stamp: 'goc 9/16/2021 23:55:01'!
stackPop
	self subclassResponsibility.! !

!OOStackStateHandler methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:56:56'!
stackTop
	self subclassResponsibility.! !


!OOStackStateHandler methodsFor: 'initialization' stamp: 'Alejandro 9/19/2021 15:16:16'!
initializeWith: aStack
	^(OOStackStateHandler subclasses detect:[:aStackState | aStackState isEmpty =  aStack isEmpty]) new.! !


!OOStackStateHandler methodsFor: 'operations' stamp: 'Alejandro 9/19/2021 15:19:40'!
getTheTopFrom: aStack
	self subclassResponsibility.! !

!OOStackStateHandler methodsFor: 'operations' stamp: 'Alejandro 9/19/2021 15:19:52'!
popFrom: aStack
	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateHandler class' category: 'Stack-Exercise'!
OOStackStateHandler class
	instanceVariableNames: ''!

!OOStackStateHandler class methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:51:33'!
initialiaze: aStackSize

"aStackSize=0 ifTrue: [^ Empty new].

^NotEmpty new."

^(self subclasses detect:[ :aStackClass | aStackClass isFor:aStackSize]) new.! !


!OOStackStateHandler class methodsFor: 'state' stamp: 'Alejandro 9/19/2021 15:18:20'!
isEmpty
	self subclassResponsibility.! !


!classDefinition: #Empty category: 'Stack-Exercise'!
OOStackStateHandler subclass: #Empty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Empty methodsFor: 'operations' stamp: 'Alejandro 9/19/2021 14:53:22'!
getTheTopFrom: aStack
	^OOStack error: OOStack stackEmptyErrorDescription.! !

!Empty methodsFor: 'operations' stamp: 'Alejandro 9/19/2021 14:49:02'!
popFrom: aStack
	^OOStack error: OOStack stackEmptyErrorDescription.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Empty class' category: 'Stack-Exercise'!
Empty class
	instanceVariableNames: ''!

!Empty class methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:45:19'!
isEmpty: aSizeStack

^aSizeStack =0! !

!Empty class methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:46:47'!
isFor: aSizeStack

^aSizeStack =0! !


!Empty class methodsFor: 'state' stamp: 'Alejandro 9/19/2021 15:04:58'!
isEmpty
	^true.! !


!classDefinition: #NotEmpty category: 'Stack-Exercise'!
OOStackStateHandler subclass: #NotEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmpty methodsFor: 'operations' stamp: 'Alejandro 9/19/2021 14:53:06'!
getTheTopFrom: aStack
	^aStack at:1! !

!NotEmpty methodsFor: 'operations' stamp: 'Alejandro 9/19/2021 14:49:12'!
popFrom: aStack
	^aStack removeLast.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NotEmpty class' category: 'Stack-Exercise'!
NotEmpty class
	instanceVariableNames: ''!

!NotEmpty class methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:46:34'!
isEmpty: aSizeStack

	^(aSizeStack = 0) not.! !

!NotEmpty class methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:46:39'!
isFor: aSizeStack

	^(aSizeStack = 0) not.! !


!NotEmpty class methodsFor: 'state' stamp: 'Alejandro 9/19/2021 15:05:32'!
isEmpty
	^false.! !


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'originalStack sentencesMatched backupStack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'goc 9/19/2021 11:40:48'!
initialiazeWith: anOOStack

	originalStack := anOOStack.
	sentencesMatched := OrderedCollection new.
	backupStack := OOStack new.! !


!SentenceFinderByPrefix methodsFor: 'checking' stamp: 'goc 9/19/2021 12:21:47'!
checkIsAValidPrefix: aPrefix
	
	aPrefix isEmpty ifTrue:[^self error: self class prefixCanNotBeEmpty].
	
	(aPrefix includesSubString: ' ') ifTrue:[^self error: self class prefixCanNotContainSpaces].! !


!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'goc 9/19/2021 12:00:51'!
checkIfSentenceMatchesTop: aPrefix
	|element|
	
	element:= originalStack pop.
	backupStack push: element.
	
	((element findString: aPrefix) = 1) ifTrue:[ sentencesMatched add: element].! !

!SentenceFinderByPrefix methodsFor: 'finding' stamp: 'goc 9/19/2021 11:58:15'!
find: aPrefix

	self checkIsAValidPrefix: aPrefix.
	
	[originalStack isEmpty not] whileTrue: [self checkIfSentenceMatchesTop: aPrefix].
	
	self restoreStack.
	
	^sentencesMatched.
! !


!SentenceFinderByPrefix methodsFor: 'restoring' stamp: 'goc 9/19/2021 11:57:48'!
restoreStack

	[ backupStack isEmpty not] whileTrue: [ originalStack push: (backupStack pop)].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: 'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'errors' stamp: 'goc 9/19/2021 12:18:56'!
prefixCanNotBeEmpty
	
	^'Prefix can not be empty'.! !

!SentenceFinderByPrefix class methodsFor: 'errors' stamp: 'goc 9/19/2021 12:19:12'!
prefixCanNotContainSpaces
	
	^'Prefix can not contain spaces'.! !
