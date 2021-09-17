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
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!


!classDefinition: #OOStack category: 'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:54:53'!
initialize
	stack := OrderedCollection new.
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'Alejandro 9/16/2021 21:24:09'!
isEmpty
	^ stack isEmpty.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:54:27'!
pop
	"stack isEmpty ifTrue:[^self error: OOStack stackEmptyErrorDescription] ifFalse:[^stack removeLast.]"
	
	| closure |
	closure:=(OOStackStateHandler initialiaze: self size) stackPop.
	
	^ self perform:closure value asSymbol.
	
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:43:07'!
push: aThing
	stack addLast: aThing.
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:26:34'!
safePop
	"stack isEmpty ifTrue:[^self error: OOStack stackEmptyErrorDescription] ifFalse:[^stack removeLast.]"
	
	^stack removeLast. 
	
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:57:52'!
safeTop
	"stack isEmpty ifTrue:[^self error: OOStack stackEmptyErrorDescription] ifFalse:[^stack removeLast.]"
	
	^stack at:1. 
	
	! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'Alejandro 9/16/2021 21:33:06'!
size
	^stack size.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:56:43'!
top
	"stack isEmpty ifTrue:[^self error: OOStack stackEmptyErrorDescription] ifFalse:[^stack at:1.]"
	
	| closure |
	closure:=(OOStackStateHandler initialiaze: self size) stackTop.
	
	^ self perform:closure value asSymbol.
	! !

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

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateHandler class' category: 'Stack-Exercise'!
OOStackStateHandler class
	instanceVariableNames: ''!

!OOStackStateHandler class methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:51:33'!
initialiaze: aStackSize

"aStackSize=0 ifTrue: [^ Empty new].

^NotEmpty new."

^(self subclasses detect:[ :aStackClass | aStackClass isFor:aStackSize]) new.! !


!classDefinition: #Empty category: 'Stack-Exercise'!
OOStackStateHandler subclass: #Empty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!Empty methodsFor: 'as yet unclassified' stamp: 'goc 9/16/2021 23:55:10'!
stackPop
	^[self error: OOStack stackEmptyErrorDescription].! !

!Empty methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:57:06'!
stackTop
	^[self error: OOStack stackEmptyErrorDescription].! !

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


!classDefinition: #NotEmpty category: 'Stack-Exercise'!
OOStackStateHandler subclass: #NotEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!NotEmpty methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:32:13'!
stackPop
	
	^['safePop'].! !

!NotEmpty methodsFor: 'as yet unclassified' stamp: 'goc 9/17/2021 13:57:21'!
stackTop
	
	^['safeTop'].! !

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


!classDefinition: #SentenceFinderByPrefix category: 'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!
