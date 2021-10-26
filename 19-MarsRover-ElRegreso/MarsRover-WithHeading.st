!classDefinition: #MarsRoverTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:21:23'!
test01DoesNotMoveWhenNoCommand

	self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: '' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:12'!
test02IsAtFailsForDifferentPosition

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@2 heading: self north)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:31'!
test03IsAtFailsForDifferentHeading

	| marsRover |
	
	marsRover := MarsRover at: 1@1 heading: self north . 
	
	self deny: (marsRover isAt: 1@1 heading: self south)! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:17'!
test04IncrementsYAfterMovingForwardWhenHeadingNorth

	self 
		assertIsAt: 1@3 
		heading: self north 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:30:11'!
test06DecrementsYAfterMovingBackwardsWhenHeadingNorth

	self 
		assertIsAt: 1@1 
		heading: self north 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:59'!
test07PointToEashAfterRotatingRightWhenHeadingNorth

	self 
		assertIsAt: 1@2 
		heading: self east 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:51'!
test08PointsToWestAfterRotatingLeftWhenPointingNorth

	self 
		assertIsAt: 1@2 
		heading: self west 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:45'!
test09DoesNotProcessInvalidCommand

	| marsRover |
	
	marsRover := MarsRover at: 1@2 heading: self north.
	
	self 
		should: [ marsRover process: 'x' ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText equals: marsRover invalidCommandErrorDescription.
			self assert: (marsRover isAt: 1@2 heading: self north) ]! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:39'!
test10CanProcessMoreThanOneCommand

	self 
		assertIsAt: 1@4 
		heading: self north 
		afterProcessing: 'ff' 
		whenStartingAt: 1@2 
		heading: self north 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:31'!
test11IncrementsXAfterMovingForwareWhenHeadingEast

	self 
		assertIsAt: 2@2 
		heading: self east 
		afterProcessing: 'f' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:19'!
test12DecrementsXAfterMovingBackwardWhenHeadingEast

	self 
		assertIsAt: 0@2 
		heading: self east 
		afterProcessing: 'b' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:14'!
test13PointsToSouthAfterRotatingRightWhenHeadingEast

		self 
		assertIsAt: 1@2 
		heading: self south 
		afterProcessing: 'r' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:05'!
test14PointsToNorthAfterRotatingLeftWhenPointingEast

		self 
		assertIsAt: 1@2 
		heading: self north 
		afterProcessing: 'l' 
		whenStartingAt: 1@2 
		heading: self east 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:29:00'!
test15ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingSouth

	self 
		assertIsAt: 1@1 
		heading: self west 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self south 
! !

!MarsRoverTest methodsFor: 'tests' stamp: 'HAW 10/7/2021 20:28:52'!
test16ForwardBackwardsAndRotateRightWorkAsExpectedWhenPointingWest

	self 
		assertIsAt: 0@2 
		heading: self north 
		afterProcessing: 'ffblrr' 
		whenStartingAt: 1@2 
		heading: self west 
! !


!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:31'!
east

	^ MarsRoverHeadingEast ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:38'!
north

	^ MarsRoverHeadingNorth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:45'!
south

	^ MarsRoverHeadingSouth ! !

!MarsRoverTest methodsFor: 'headings' stamp: 'HAW 10/7/2021 20:09:54'!
west

	^ MarsRoverHeadingWest ! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'HAW 10/7/2021 20:20:47'!
assertIsAt: newPosition heading: newHeadingType afterProcessing: commands whenStartingAt: startPosition heading: startHeadingType

	| marsRover |
	
	marsRover := MarsRover at: startPosition heading: startHeadingType. 
	
	marsRover process: commands.
	
	self assert: (marsRover isAt: newPosition heading: newHeadingType)! !


!classDefinition: #TestXxx category: 'MarsRover-WithHeading'!
TestCase subclass: #TestXxx
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/25/2021 22:18:06'!
test01
	| marsRover logReadStream x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self trackPositionChangesOf: marsRover.
	
	marsRover process: 'f'.
	
	logReadStream _ ReadStream on: x contents.
	
	self assert:'1@2' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/25/2021 22:28:31'!
test02
	| marsRover logReadStream x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self trackPositionChangesOf: marsRover.
	
	marsRover process: 'b'.
	
	logReadStream _ ReadStream on: x contents.
	
	self assert:'1@0' equals: logReadStream nextLine.
	self assert: logReadStream atEnd.! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/25/2021 22:37:55'!
test03
	| marsRover logReadStream x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self trackHeadingChangesOf: marsRover.
	
	marsRover process: 'ff'.
	
	logReadStream _ ReadStream on: x contents.
	
	self assert: logReadStream atEnd.! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/25/2021 22:37:04'!
test04
	| marsRover logReadStream x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self trackHeadingChangesOf: marsRover.
	
	marsRover process: 'ffr'.
	
	logReadStream _ ReadStream on: x contents.
	
	self assert: 'East' equals: logReadStream nextLine .
	self assert: logReadStream atEnd.! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/25/2021 22:49:52'!
test05
	| marsRover logReadStream x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self trackPositionAndHeadingChangesOf: marsRover.
	
	marsRover process: 'ffr'.
	
	logReadStream _ ReadStream on: x contents.
	
	
	self assert: '1@2' equals: logReadStream nextLine.
	self assert: '1@3' equals: logReadStream nextLine.
	self assert: 'East' equals: logReadStream nextLine .
	self assert: logReadStream atEnd.! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/25/2021 23:02:48'!
test06
	| marsRover logReadStream x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	
	x _ self trackPositionAndHeadingChangesOf: marsRover.
	
	marsRover process: 'frfrfr'.
	
	logReadStream _ ReadStream on: x contents.
	
	
	self assert: '2@1' equals: logReadStream nextLine.
	self assert: 'South' equals: logReadStream nextLine .
	self assert: '2@0' equals: logReadStream nextLine.
	self assert: 'West' equals: logReadStream nextLine .
	self assert: '1@0' equals: logReadStream nextLine .
	self assert: 'North' equals: logReadStream nextLine .
	self assert: logReadStream atEnd.! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/26/2021 12:33:13'!
test07
	| marsRover x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self trackInStatusViewPositionChangesOf: marsRover.
	
	marsRover process: 'ffr'.
	
	self assert: '1@3' equals: x getPositionTextFieldModel.
	"self assert: MarsRoverHeadingEast equals: x headingTextFieldModel."
	! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/26/2021 12:50:42'!
test08
	| marsRover x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self trackInStatusViewHeadingChangesOf: marsRover.
	
	marsRover process: 'ffr'.
	
	self assert: 'East' equals: x getHeadingTextFieldModel printString.
	! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/26/2021 12:55:14'!
test09
	| marsRover x |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	x _ self trackInStatusViewPositionAndHeadingChangesOf: marsRover.
	
	marsRover process: 'ffr'.
	
	self assert: '1@3' equals: x getPositionTextFieldModel .
	self assert: 'East' equals: x getHeadingTextFieldModel printString.
	! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/25/2021 22:33:22'!
trackHeadingChangesOf: aMarsRover 
	| logger |
	
	logger _ WriteStream on: ''.
	aMarsRover trackHeadingChangesTo: logger.
	
	^logger.! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/26/2021 12:38:09'!
trackInStatusViewHeadingChangesOf: aMarsRover 
	|x|
	
	x _ MarsRoverStatusView new.
	aMarsRover trackHeadingChangesToStatusView: x.
	
	^x.! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/26/2021 12:53:47'!
trackInStatusViewPositionAndHeadingChangesOf: aMarsRover 
	| x |
	
	x _ MarsRoverStatusView new.
	
	aMarsRover  trackPositionAndHeadingChangesToStatusView: x.
	
	^ x.! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/26/2021 12:32:26'!
trackInStatusViewPositionChangesOf: aMarsRover 
	|x|
	
	x _ MarsRoverStatusView new.
	aMarsRover  trackPositionChangesToStatusView: x.
	
	^ x.! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/26/2021 12:21:46'!
trackInWindowPositionAndHeadingChangesOf: aMarsRover 
	self shouldBeImplemented.! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/25/2021 22:51:22'!
trackPositionAndHeadingChangesOf: aMarsRover 
	
	| logger|
	
	logger _ WriteStream on: ''.
	aMarsRover  trackHeadingChangesTo: logger.
	aMarsRover  trackPositionChangesTo: logger.
	
	^logger.! !

!TestXxx methodsFor: 'as yet unclassified' stamp: 'goc 10/25/2021 22:19:53'!
trackPositionChangesOf: aMarsRover 
	| logger |
	
	logger _ WriteStream on: ''.
	aMarsRover trackPositionChangesTo: logger.
	
	^ logger.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head positionChangesLogger headingChangesLogger positionChangesStatusView headingChangesStatusView'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:10:49'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self ! !


!MarsRover methodsFor: 'heading' stamp: 'goc 10/26/2021 12:41:03'!
changeHeadTo: aMarsRoverHeadingaDirection
	
	head := aMarsRoverHeadingaDirection.
	
	headingChangesLogger ifNotNil:[ headingChangesLogger nextPutAll: head printString; newLine ].
	headingChangesStatusView ifNotNil:[headingChangesStatusView headingTextFieldModel: head].! !

!MarsRover methodsFor: 'heading' stamp: 'goc 10/25/2021 22:59:44'!
headEast
	
	self changeHeadTo: (MarsRoverHeadingEast for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'goc 10/25/2021 22:59:54'!
headNorth
	
	self changeHeadTo: (MarsRoverHeadingNorth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'goc 10/25/2021 23:00:01'!
headSouth
	
	self changeHeadTo: (MarsRoverHeadingSouth for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'goc 10/25/2021 23:00:10'!
headWest
	
	self changeHeadTo: (MarsRoverHeadingWest for: self).! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	head rotateLeft! !

!MarsRover methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	head rotateRight! !


!MarsRover methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:16:32'!
isAt: aPosition heading: aHeadingType

	^position = aPosition and: [ head isHeading: aHeadingType ]! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:51'!
isBackwardCommand: aCommand

	^aCommand = $b! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:16:19'!
isForwardCommand: aCommand

	^aCommand = $f ! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:51'!
isRotateLeftCommand: aCommand

	^aCommand = $l! !

!MarsRover methodsFor: 'testing' stamp: 'HAW 7/6/2018 18:17:21'!
isRotateRightCommand: aCommand

	^aCommand = $r! !


!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	head moveBackward! !

!MarsRover methodsFor: 'moving' stamp: 'goc 10/25/2021 22:56:45'!
moveEast
	
	self movePositionWith: (1@0).! !

!MarsRover methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	head moveForward! !

!MarsRover methodsFor: 'moving' stamp: 'goc 10/25/2021 22:57:05'!
moveNorth
	
	self movePositionWith: (0@1).
	
	! !

!MarsRover methodsFor: 'moving' stamp: 'goc 10/26/2021 12:31:14'!
movePositionWith: anOffset
	
	position := position + anOffset .
	
	positionChangesLogger  ifNotNil:[positionChangesLogger nextPutAll: position printString; newLine].
	positionChangesStatusView ifNotNil:[positionChangesStatusView positionTextFieldModel: position].
	! !

!MarsRover methodsFor: 'moving' stamp: 'goc 10/25/2021 22:57:17'!
moveSouth
	
	self movePositionWith: (0@-1).
	
	! !

!MarsRover methodsFor: 'moving' stamp: 'goc 10/25/2021 22:57:28'!
moveWest
	
	self movePositionWith: (-1@0).! !


!MarsRover methodsFor: 'command processing' stamp: 'HAW 6/30/2018 19:48:26'!
process: aSequenceOfCommands

	aSequenceOfCommands do: [:aCommand | self processCommand: aCommand ]
! !

!MarsRover methodsFor: 'command processing' stamp: 'HAW 8/22/2019 12:08:50'!
processCommand: aCommand

	(self isForwardCommand: aCommand) ifTrue: [ ^ self moveForward ].
	(self isBackwardCommand: aCommand) ifTrue: [ ^ self moveBackward ].
	(self isRotateRightCommand: aCommand) ifTrue: [ ^ self rotateRight ].
	(self isRotateLeftCommand: aCommand) ifTrue: [ ^ self rotateLeft ].

	self signalInvalidCommand.! !


!MarsRover methodsFor: 'unclassified' stamp: 'goc 10/25/2021 22:34:31'!
trackHeadingChangesTo: aLogger 
	
	headingChangesLogger _ aLogger.! !

!MarsRover methodsFor: 'unclassified' stamp: 'goc 10/26/2021 12:38:54'!
trackHeadingChangesToStatusView: aMarsRoverStatusView 
	
	headingChangesStatusView _ aMarsRoverStatusView .! !

!MarsRover methodsFor: 'unclassified' stamp: 'goc 10/26/2021 12:54:41'!
trackPositionAndHeadingChangesToStatusView: aMarsRoverStatusView 
	
	positionChangesStatusView _ aMarsRoverStatusView .
	headingChangesStatusView _ aMarsRoverStatusView .! !

!MarsRover methodsFor: 'unclassified' stamp: 'goc 10/25/2021 22:21:56'!
trackPositionChangesTo: aLogger
	
	positionChangesLogger _ aLogger.! !

!MarsRover methodsFor: 'unclassified' stamp: 'goc 10/26/2021 12:25:35'!
trackPositionChangesToStatusView: aMarsRoverStatusView 
	
	positionChangesStatusView _ aMarsRoverStatusView.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover-WithHeading'!
MarsRover class
	instanceVariableNames: 'headings'!

!MarsRover class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:10:30'!
at: aPosition heading: aHeadingType
	
	^self new initializeAt: aPosition heading: aHeadingType! !


!classDefinition: #MarsRoverHeading category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverHeading
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'testing' stamp: 'HAW 10/7/2021 20:15:38'!
isHeading: aHeadingType

	^self isKindOf: aHeadingType ! !

!MarsRoverHeading methodsFor: 'testing' stamp: 'goc 10/25/2021 22:47:28'!
printString

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	self subclassResponsibility ! !

!MarsRoverHeading methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward

	self subclassResponsibility ! !


!MarsRoverHeading methodsFor: 'initialization' stamp: 'HAW 10/7/2021 20:11:59'!
initializeFor: aMarsRover 
	
	marsRover := aMarsRover.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverHeading class' category: 'MarsRover-WithHeading'!
MarsRoverHeading class
	instanceVariableNames: ''!

!MarsRoverHeading class methodsFor: 'instance creation' stamp: 'HAW 10/7/2021 20:11:35'!
for: aMarsRover 
	
	^self new initializeFor: aMarsRover ! !


!classDefinition: #MarsRoverHeadingEast category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingEast
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveWest! !

!MarsRoverHeadingEast methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveEast! !


!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headNorth! !

!MarsRoverHeadingEast methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headSouth! !


!MarsRoverHeadingEast methodsFor: 'as yet unclassified' stamp: 'goc 10/25/2021 22:47:59'!
printString

	^'East'.! !


!classDefinition: #MarsRoverHeadingNorth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingNorth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveSouth! !

!MarsRoverHeadingNorth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveNorth! !


!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headWest! !

!MarsRoverHeadingNorth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headEast! !


!MarsRoverHeadingNorth methodsFor: 'as yet unclassified' stamp: 'goc 10/25/2021 22:48:13'!
printString

	^'North'.! !


!classDefinition: #MarsRoverHeadingSouth category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingSouth
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward
	
	^marsRover moveNorth! !

!MarsRoverHeadingSouth methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveSouth! !


!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headEast! !

!MarsRoverHeadingSouth methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headWest! !


!MarsRoverHeadingSouth methodsFor: 'as yet unclassified' stamp: 'goc 10/25/2021 22:48:22'!
printString

	^'South'.! !


!classDefinition: #MarsRoverHeadingWest category: 'MarsRover-WithHeading'!
MarsRoverHeading subclass: #MarsRoverHeadingWest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:24'!
moveBackward

	^marsRover moveEast! !

!MarsRoverHeadingWest methodsFor: 'moving' stamp: 'HAW 10/7/2021 20:13:53'!
moveForward
	
	^marsRover moveWest! !


!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:20'!
rotateLeft
	
	^marsRover headSouth! !

!MarsRoverHeadingWest methodsFor: 'heading' stamp: 'HAW 10/7/2021 20:14:44'!
rotateRight
	
	^marsRover headNorth! !


!MarsRoverHeadingWest methodsFor: 'as yet unclassified' stamp: 'goc 10/25/2021 22:48:31'!
printString

	^'West'.! !


!classDefinition: #MarsRoverStatusView category: 'MarsRover-WithHeading'!
Object subclass: #MarsRoverStatusView
	instanceVariableNames: 'positionTextFieldModel headingTextFieldModel'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusView methodsFor: 'unclassified' stamp: 'goc 10/26/2021 12:42:17'!
getHeadingTextFieldModel
	^ headingTextFieldModel.! !

!MarsRoverStatusView methodsFor: 'unclassified' stamp: 'goc 10/26/2021 12:35:45'!
getPositionTextFieldModel
	^ positionTextFieldModel printString.! !

!MarsRoverStatusView methodsFor: 'unclassified' stamp: 'goc 10/26/2021 12:41:54'!
headingTextFieldModel: aMarsRoverHeading
	
	headingTextFieldModel _ aMarsRoverHeading.! !

!MarsRoverStatusView methodsFor: 'unclassified' stamp: 'goc 10/26/2021 12:28:08'!
positionTextFieldModel: aPosition
	
	positionTextFieldModel _ aPosition.! !
