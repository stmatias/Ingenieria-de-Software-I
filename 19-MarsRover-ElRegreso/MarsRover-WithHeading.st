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


!classDefinition: #MarsRoverTracker category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTracker
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTracker methodsFor: 'changing' stamp: 'MS 10/28/2021 16:22:04'!
changeHeading: aHeading

	self subclassResponsibility .! !

!MarsRoverTracker methodsFor: 'changing' stamp: 'MS 10/28/2021 16:22:16'!
changePosition: aPosition

	self subclassResponsibility .! !


!MarsRoverTracker methodsFor: 'initialization' stamp: 'MS 10/28/2021 14:43:30'!
initializeInstances

	self subclassResponsibility .! !

!MarsRoverTracker methodsFor: 'initialization' stamp: 'MS 10/28/2021 14:43:16'!
initializeWith: aMarsRover

	marsRover := aMarsRover.
	aMarsRover add: self.
	self initializeInstances.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRoverTracker class' category: 'MarsRover-WithHeading'!
MarsRoverTracker class
	instanceVariableNames: ''!

!MarsRoverTracker class methodsFor: 'as yet unclassified' stamp: 'MS 10/28/2021 14:51:15'!
for: aMarsRover

	^self new initializeWith: aMarsRover.! !


!classDefinition: #MarsRoverLogs category: 'MarsRover-WithHeading'!
MarsRoverTracker subclass: #MarsRoverLogs
	instanceVariableNames: 'log'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverLogs methodsFor: 'adding' stamp: 'MS 10/27/2021 15:47:37'!
add: aHeading

	log add: aHeading .! !


!MarsRoverLogs methodsFor: 'log' stamp: 'MS 10/27/2021 15:46:53'!
log
	^log.! !


!MarsRoverLogs methodsFor: 'changing' stamp: 'MS 10/28/2021 16:18:07'!
changeHeading: aHeading

	self subclassResponsibility .! !

!MarsRoverLogs methodsFor: 'changing' stamp: 'MS 10/28/2021 16:17:58'!
changePosition: aPosition

	self subclassResponsibility .! !


!MarsRoverLogs methodsFor: 'initialization' stamp: 'MS 10/28/2021 14:43:54'!
initializeInstances

	log := OrderedCollection new.! !


!classDefinition: #MarsRoverHeadingLog category: 'MarsRover-WithHeading'!
MarsRoverLogs subclass: #MarsRoverHeadingLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingLog methodsFor: 'changing' stamp: 'MS 10/28/2021 14:53:41'!
changeHeading: aHeading

	log add: aHeading.! !

!MarsRoverHeadingLog methodsFor: 'changing' stamp: 'MS 10/28/2021 14:54:21'!
changePosition: aPosition
! !


!classDefinition: #MarsRoverPositionHeadingLog category: 'MarsRover-WithHeading'!
MarsRoverLogs subclass: #MarsRoverPositionHeadingLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionHeadingLog methodsFor: 'changing' stamp: 'MS 10/28/2021 13:23:19'!
changeHeading: aHeading

	log add: aHeading.! !

!MarsRoverPositionHeadingLog methodsFor: 'changing' stamp: 'MS 10/28/2021 13:23:03'!
changePosition: aPosition

	log add: aPosition.! !


!classDefinition: #MarsRoverPositionLog category: 'MarsRover-WithHeading'!
MarsRoverLogs subclass: #MarsRoverPositionLog
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionLog methodsFor: 'changing' stamp: 'MS 10/28/2021 14:53:17'!
changeHeading: aHeading

	! !

!MarsRoverPositionLog methodsFor: 'changing' stamp: 'MS 10/28/2021 14:53:18'!
changePosition: aPosition

	log add: aPosition.! !


!classDefinition: #MarsRoverStatusView category: 'MarsRover-WithHeading'!
MarsRoverTracker subclass: #MarsRoverStatusView
	instanceVariableNames: 'window'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverStatusView methodsFor: 'initialization' stamp: 'MS 10/28/2021 14:44:43'!
initializeInstances
	
	self subclassResponsibility.
	! !


!MarsRoverStatusView methodsFor: 'window' stamp: 'MS 10/28/2021 14:56:09'!
window

	^window.! !


!MarsRoverStatusView methodsFor: 'changing' stamp: 'MS 10/28/2021 16:17:22'!
changeHeading: aHeading

	self subclassResponsibility.! !

!MarsRoverStatusView methodsFor: 'changing' stamp: 'MS 10/28/2021 16:17:40'!
changePosition: aPosition

	self subclassResponsibility.! !


!classDefinition: #MarsRoverHeadingStatusView category: 'MarsRover-WithHeading'!
MarsRoverStatusView subclass: #MarsRoverHeadingStatusView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverHeadingStatusView methodsFor: 'initialization' stamp: 'MS 10/28/2021 14:55:27'!
initializeInstances
	! !


!MarsRoverHeadingStatusView methodsFor: 'changing' stamp: 'MS 10/28/2021 14:21:01'!
changeHeading: aHeading

	window := aHeading.

	! !

!MarsRoverHeadingStatusView methodsFor: 'changing' stamp: 'MS 10/28/2021 14:20:34'!
changePosition: aPosition

	! !


!classDefinition: #MarsRoverPositionAndHeadingStatusView category: 'MarsRover-WithHeading'!
MarsRoverStatusView subclass: #MarsRoverPositionAndHeadingStatusView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionAndHeadingStatusView methodsFor: 'initialization' stamp: 'MS 10/28/2021 14:47:03'!
initializeInstances

	window := Array new: 2.! !


!MarsRoverPositionAndHeadingStatusView methodsFor: 'changing' stamp: 'MS 10/28/2021 15:05:54'!
changeHeading: aHeading

	window at: 2 put: aHeading.! !

!MarsRoverPositionAndHeadingStatusView methodsFor: 'changing' stamp: 'MS 10/28/2021 15:05:57'!
changePosition: aPosition

	window at: 1  put: aPosition .! !


!classDefinition: #MarsRoverPositionStatusView category: 'MarsRover-WithHeading'!
MarsRoverStatusView subclass: #MarsRoverPositionStatusView
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverPositionStatusView methodsFor: 'initialization' stamp: 'MS 10/28/2021 14:55:33'!
initializeInstances
! !


!MarsRoverPositionStatusView methodsFor: 'changing' stamp: 'MS 10/28/2021 14:22:21'!
changeHeading: aHeading

! !

!MarsRoverPositionStatusView methodsFor: 'changing' stamp: 'MS 10/28/2021 14:22:17'!
changePosition: aPosition

	window := aPosition.! !


!classDefinition: #MarsRoverTrackerTest category: 'MarsRover-WithHeading'!
TestCase subclass: #MarsRoverTrackerTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRoverTrackerTest methodsFor: 'log position' stamp: 'MS 10/28/2021 16:03:25'!
test00logForPositionWithoutMovingReturnsEmptyCollection
	| marsRover expected positionLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionLog _ MarsRoverPositionLog for: marsRover .
	
	expected := OrderedCollection new.
	
	self assert: expected equals: positionLog log.! !

!MarsRoverTrackerTest methodsFor: 'log position' stamp: 'MS 10/28/2021 16:03:35'!
test01logForPositionWithForwardCommandReturnsCorrectCollection
	| marsRover expected positionLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionLog _ MarsRoverPositionLog for: marsRover .
	
	marsRover process: 'f'.
	
	expected _ OrderedCollection with: 1@2.
	
	self assert: expected equals: positionLog log.
! !

!MarsRoverTrackerTest methodsFor: 'log position' stamp: 'MS 10/28/2021 16:03:42'!
test02logForPositionWithBackwardCommandReturnsCorrectCollection
	| marsRover expected positionLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionLog _ MarsRoverPositionLog for: marsRover .
	
	marsRover process: 'b'.
	
	expected _ OrderedCollection with: 1@0.
	
	self assert: expected equals: positionLog log.
! !

!MarsRoverTrackerTest methodsFor: 'log position' stamp: 'MS 10/28/2021 16:03:53'!
test03logForPositionWithMultiplePositionCommandsReturnsCorrectCollection
	| marsRover expected positionLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionLog _ MarsRoverPositionLog for: marsRover .
	
	marsRover process: 'ffbf'.
	
	expected _ OrderedCollection with: 1@2 with:1@3 with:1@2 with:1@3.
	
	self assert: expected equals: positionLog log.! !

!MarsRoverTrackerTest methodsFor: 'log position' stamp: 'MS 10/28/2021 16:04:03'!
test04logForPositionDoesNotIncludeHeadingChanges
	| marsRover expected positionLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionLog _ MarsRoverPositionLog for: marsRover.
	
	marsRover process: 'ffrrb'.
	
	expected _ OrderedCollection with: 1@2 with:1@3 with:1@4.
	
	self assert: expected equals: positionLog log.! !


!MarsRoverTrackerTest methodsFor: 'log position heading' stamp: 'MS 10/28/2021 16:05:58'!
test10logForPositionAndHeadingWithoutMovingReturnsEmptyCollection
	| marsRover expected positionHeadingLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingEast.
	
	positionHeadingLog _ MarsRoverPositionHeadingLog for: marsRover .
		
	expected _ OrderedCollection new.
	
	self assert: expected equals: positionHeadingLog log.! !

!MarsRoverTrackerTest methodsFor: 'log position heading' stamp: 'MS 10/28/2021 16:11:55'!
test11logForPositionAndHeadingIncludeBothPositionAndHeadingChanges
	| marsRover expected positionHeadingLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionHeadingLog _ MarsRoverPositionHeadingLog for: marsRover .
	
	marsRover process: 'ffr'.
	
	expected _ OrderedCollection with: 1@2 with: 1@3 with: 'East'.
	
	self assert: expected equals: positionHeadingLog log.! !


!MarsRoverTrackerTest methodsFor: 'status view' stamp: 'MS 10/28/2021 16:12:00'!
test12windowForPositionReturnsNillIfMarsRoverDidNotMove
	| marsRover positionStatusView |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionStatusView _ MarsRoverPositionStatusView for: marsRover.
	
	self assert: nil equals: positionStatusView window.
	! !

!MarsRoverTrackerTest methodsFor: 'status view' stamp: 'MS 10/28/2021 16:12:06'!
test13windowForHeadingReturnsNillIfMarsRoverDidNotMove
	| marsRover headingStatusView |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingStatusView _ MarsRoverHeadingStatusView for: marsRover.
	
	self assert: nil equals: headingStatusView window.
	! !

!MarsRoverTrackerTest methodsFor: 'status view' stamp: 'MS 10/28/2021 16:12:11'!
test14windowForPositionReturnsCurrentPosition
	| marsRover positionStatusView |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionStatusView _ MarsRoverPositionStatusView for: marsRover.
	
	marsRover process: 'ffbfbbfflrrr'.
	
	self assert: 1@3 equals: positionStatusView window.
	! !

!MarsRoverTrackerTest methodsFor: 'status view' stamp: 'MS 10/28/2021 16:12:21'!
test15windowForHeadingReturnsCurrentHeading
	| marsRover headingStatusView |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingStatusView _ MarsRoverHeadingStatusView for: marsRover .
	
	marsRover process: 'fflrlrbbflbrr'.
	
	self assert: 'East' equals: headingStatusView window.
	! !

!MarsRoverTrackerTest methodsFor: 'status view' stamp: 'MS 10/28/2021 16:12:28'!
test16windowsForPositionAndHeadingReturnsPositionAndHeading
	| marsRover positionAndHeadingStatusView expected |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionAndHeadingStatusView _ MarsRoverPositionAndHeadingStatusView for: marsRover.
	
	marsRover process: 'ffbfbflrllrrr'.
	
	expected := Array with: 1@3 with: 'East'.
	
	self assert: expected equals: positionAndHeadingStatusView window.! !


!MarsRoverTrackerTest methodsFor: 'multiple trackers' stamp: 'MS 10/28/2021 16:12:33'!
test17marsRoverSupportsManyEqualLogs
	| marsRover positionLog1 positionLog2 expected|
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionLog1 _ MarsRoverPositionLog for: marsRover.
	positionLog2 _ MarsRoverPositionLog for: marsRover.
	
	marsRover process: 'fffr'.
	
	expected _ OrderedCollection with: 1@2 with: 1@3 with: 1@4.
	
	self assert: expected equals: positionLog1 log.
	self assert: expected equals: positionLog2 log.
	! !

!MarsRoverTrackerTest methodsFor: 'multiple trackers' stamp: 'MS 10/28/2021 16:12:37'!
test18marsRoverSupportsManyDifferentLogs
	| marsRover positionLog headingLog expectedPositionLog expectedHeadingLog|
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionLog _ MarsRoverPositionLog for: marsRover.
	headingLog _ MarsRoverHeadingLog for: marsRover.
	
	marsRover process: 'fffr'.
	
	expectedPositionLog _ OrderedCollection with: 1@2 with: 1@3 with: 1@4.
	expectedHeadingLog := OrderedCollection with: 'East'.
	
	self assert: expectedPositionLog equals: positionLog log.
	self assert: expectedHeadingLog equals: headingLog log.
	! !

!MarsRoverTrackerTest methodsFor: 'multiple trackers' stamp: 'MS 10/28/2021 16:12:45'!
test19marsRoverSupportsManyDifferentLogsAndWindonws
	| marsRover positionLog positionStatusView expectedPositionLog expectedPositionStatusView|
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	positionLog _ MarsRoverPositionLog for: marsRover.
	positionStatusView _ MarsRoverPositionStatusView for: marsRover.
	
	marsRover process: 'fffr'.
	
	expectedPositionLog _ OrderedCollection with: 1@2 with: 1@3 with: 1@4.
	expectedPositionStatusView := 1@4.
	
	self assert: expectedPositionLog equals: positionLog log.
	self assert: expectedPositionStatusView equals: positionStatusView window.
	! !


!MarsRoverTrackerTest methodsFor: 'log heading' stamp: 'MS 10/28/2021 16:04:18'!
test05logForHeadingWithoutMovingReturnsEmptyCollection
	| marsRover expected headingLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingLog _ MarsRoverHeadingLog for: marsRover .

	expected := OrderedCollection new.
		
	self assert: expected equals: headingLog log.
	! !

!MarsRoverTrackerTest methodsFor: 'log heading' stamp: 'MS 10/28/2021 16:04:49'!
test06logForHeadingWithRightCommandReturnsCorrectCollection
	 | marsRover expected headingLog |

	marsRover :=  MarsRover at: 1@1 heading: MarsRoverHeadingNorth.

	headingLog := MarsRoverHeadingLog for: marsRover .

	marsRover process: 'r'.

	expected _ OrderedCollection with: 'East'.
	
	self assert: expected equals: headingLog log.	
	
! !

!MarsRoverTrackerTest methodsFor: 'log heading' stamp: 'MS 10/28/2021 16:05:08'!
test07logForHeadingWithLeftCommandReturnsCorrectCollection
	 | marsRover expected headingLog |

	marsRover :=  MarsRover at: 1@1 heading: MarsRoverHeadingNorth.

	headingLog := MarsRoverHeadingLog for: marsRover .

	marsRover process: 'l'.

	expected _ OrderedCollection with: 'West'.
	
	self assert: expected equals: headingLog log.	
	
! !

!MarsRoverTrackerTest methodsFor: 'log heading' stamp: 'MS 10/28/2021 16:05:17'!
test08logForHeadingWithMultipleHeadingCommandsReturnsCorrectCollection
	| marsRover expected headingLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingLog _ MarsRoverHeadingLog for: marsRover .
	
	marsRover process: 'rlrrr'.
	
	expected _ OrderedCollection with: 'East' with: 'North' with: 'East' with: 'South' with: 'West'.
	
	self assert: expected equals: headingLog log.! !

!MarsRoverTrackerTest methodsFor: 'log heading' stamp: 'MS 10/28/2021 16:05:38'!
test09logForHeadingDoesNotIncludePositionChanges
	| marsRover expected headingLog |
	
	marsRover _ MarsRover at: 1@1 heading: MarsRoverHeadingNorth.
	
	headingLog _ MarsRoverHeadingLog for: marsRover .
	
	marsRover process: 'rffrfbfr'.
	
	expected _ OrderedCollection with: 'East'with: 'South' with: 'West'.
	
	self assert: expected equals: headingLog log.! !


!classDefinition: #MarsRover category: 'MarsRover-WithHeading'!
Object subclass: #MarsRover
	instanceVariableNames: 'position head trackers'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover-WithHeading'!

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:48:45'!
invalidCommandErrorDescription
	
	^'Invalid command'! !

!MarsRover methodsFor: 'exceptions' stamp: 'HAW 6/30/2018 19:50:26'!
signalInvalidCommand
	
	self error: self invalidCommandErrorDescription ! !


!MarsRover methodsFor: 'initialization' stamp: 'MS 10/28/2021 11:10:40'!
initializeAt: aPosition heading: aHeadingType

	position := aPosition.
	head := aHeadingType for: self. 
	trackers := OrderedCollection new.! !


!MarsRover methodsFor: 'heading' stamp: 'MS 10/28/2021 12:51:00'!
add: aTracker

	trackers add: aTracker .! !

!MarsRover methodsFor: 'heading' stamp: 'MS 10/28/2021 15:08:01'!
changeHeadTo: aHeading

	head := aHeading.

	trackers do: [:aTracker | aTracker changeHeading: head printString].! !

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

!MarsRover methodsFor: 'moving' stamp: 'MS 10/28/2021 15:08:12'!
movePositionWith: anOffset
	
	position := position + anOffset .
	
	trackers do: [:aTracker | aTracker changePosition: position].! !

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
