!classDefinition: #MarsRoverTest category: 'MarsRover'!
TestCase subclass: #MarsRoverTest
	instanceVariableNames: 'North East South West'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRoverTest methodsFor: 'setup' stamp: 'MS 10/6/2021 12:45:24'!
setUp
	
	North := NorthDirection new.
	South := SouthDirection new.
	East := EastDirection new.
	West := WestDirection new.	
	! !


!MarsRoverTest methodsFor: 'assertions' stamp: 'Alejandro 10/6/2021 17:56:12'!
assertThat: aMarsRover isIn: aPosition heading: aCardinalPoint

	self assert: aPosition equals: aMarsRover position.
		
	self assert: aCardinalPoint name equals: aMarsRover direction name.! !


!MarsRoverTest methodsFor: 'single command' stamp: 'MS 10/7/2021 10:52:19'!
test02MarsRoverMovesForwardCorrectlyWhenHeadingNorth

	| marsRover |
		
	marsRover := MarsRover isAt: 1@2 heading:North.
	
	marsRover process: 'f'.
	
	self assertThat: marsRover isIn: 1@3 heading: North.! !

!MarsRoverTest methodsFor: 'single command' stamp: 'MS 10/7/2021 10:53:09'!
test03MarsRoverMovesBackwardCorrectlyWhenHeadingNorth

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: North.
	
	marsRover process: 'b'.
	
	self assertThat: marsRover isIn: 1@1 heading: North.! !

!MarsRoverTest methodsFor: 'single command' stamp: 'MS 10/7/2021 10:53:22'!
test04MarsRoverMovesForwardCorrectlyWhenHeadingSouth

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading:South.
	
	marsRover process: 'f'.
	
	self assertThat: marsRover isIn: 1@1 heading: South.! !

!MarsRoverTest methodsFor: 'single command' stamp: 'MS 10/7/2021 11:01:33'!
test05MarsRoverMovesBackwardsCorrectlyWhenHeadingSouth

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading:South.
	
	marsRover process: 'b'.
	
	self assertThat: marsRover isIn: 1@3 heading: South.! !

!MarsRoverTest methodsFor: 'single command' stamp: 'MS 10/7/2021 11:01:44'!
test06MarsRoverMovesForwardCorrectlyWhenHeadingWest

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: West.
	
	marsRover process: 'f'.
	
	self assertThat: marsRover isIn: 0@2 heading: West.! !

!MarsRoverTest methodsFor: 'single command' stamp: 'MS 10/7/2021 11:02:40'!
test07MarsRoverMovesBackwardsCorrectlyWhenHeadingWest

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: West.
	
	marsRover process: 'b'.
	
	self assertThat: marsRover isIn: 2@2 heading: West.! !

!MarsRoverTest methodsFor: 'single command' stamp: 'MS 10/7/2021 11:02:49'!
test08MarsRoverMovesForwardCorrectlyWhenHeadingEast

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: East.
	
	marsRover process: 'f'.
	
	self assertThat: marsRover isIn: 2@2 heading: East.! !

!MarsRoverTest methodsFor: 'single command' stamp: 'MS 10/7/2021 11:03:34'!
test09MarsRoverMovesBackwardsCorrectlyWhenHeadingEast

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: East.
	
	marsRover process: 'b'.
	
	self assertThat: marsRover isIn: 0@2 heading: East.! !

!MarsRoverTest methodsFor: 'single command' stamp: 'MS 10/7/2021 11:04:18'!
test10MarsRoverTurnsLeftCorrectlyWhenHeadingNorth

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: North.
	
	marsRover process: 'l'.
	
	self assertThat: marsRover isIn: 1@2 heading: West.

! !

!MarsRoverTest methodsFor: 'single command' stamp: 'MS 10/7/2021 11:04:56'!
test11MarsRoverTurnsRightCorrectlyWhenHeadingNorth

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: North.
	
	marsRover process: 'r'.
	
	self assertThat: marsRover isIn: 1@2 heading: East.

! !

!MarsRoverTest methodsFor: 'single command' stamp: 'MS 10/7/2021 11:05:26'!
test12MarsRoverTurnsLeftCorrectlyWhenHeadingEast

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading:East.
	
	marsRover process: 'l'.
	
	self assertThat: marsRover isIn: 1@2 heading: North.

! !

!MarsRoverTest methodsFor: 'single command' stamp: 'MS 10/7/2021 11:05:55'!
test13MarsRoverTurnsLeftCorrectlyWhenHeadingWest

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: West.
	
	marsRover process: 'l'.
	
	self assertThat: marsRover isIn: 1@2 heading: South.

! !

!MarsRoverTest methodsFor: 'single command' stamp: 'MS 10/7/2021 11:06:20'!
test14MarsRoverTurnsRightCorrectlyWhenHeadingSouth

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: South.
	
	marsRover process: 'r'.
	
	self assertThat: marsRover isIn: 1@2 heading: West.

! !


!MarsRoverTest methodsFor: 'multiple commands' stamp: 'MS 10/7/2021 11:08:22'!
test15MarsRoverMovesCorrectlyWithMultipleCommands

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: North.
	
	marsRover process: 'fbffbbbfff'.
	
	self assertThat: marsRover isIn: 1@4 heading: North.! !

!MarsRoverTest methodsFor: 'multiple commands' stamp: 'MS 10/7/2021 11:08:31'!
test16MarsRoverMovesAndTurnsCorrectlyWithMultipleCommands

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: North.
	
	marsRover process: 'ffffbfl'.
	
	self assertThat: marsRover isIn: 1@6 heading: West.! !


!MarsRoverTest methodsFor: 'error' stamp: 'MS 10/7/2021 11:09:09'!
test17MarsRoverDoesNotDoAnythingWithInvalidCommand

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: North.
	
	self
		should: [marsRover process: 'c']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover errorInvalidCommand].
	
	self assertThat: marsRover isIn: 1@2 heading: North.! !

!MarsRoverTest methodsFor: 'error' stamp: 'MS 10/7/2021 11:09:51'!
test18MarsRoverMovesCorrectlyUntilInvalidCommand

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: North.
	
	self
		should: [marsRover process: 'ffc']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover errorInvalidCommand].
		
	self assertThat: marsRover isIn: 1@4 heading: North.! !

!MarsRoverTest methodsFor: 'error' stamp: 'MS 10/7/2021 11:12:32'!
test19MarsRoverDoesNotDoAnythingSinceInvalidCommand

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: North.
	
	self
		should: [marsRover process: 'ffcff']
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover errorInvalidCommand].
		
	self assertThat: marsRover isIn: 1@4 heading: North.! !


!MarsRoverTest methodsFor: 'no commands' stamp: 'MS 10/7/2021 10:49:12'!
test01ShouldStayInTheSamePositionWhenCommandStringIsEmpty

	| marsRover |
		
	marsRover := MarsRover isAt: 1@2 heading:North.
	
	marsRover process: ''.
	
	self assertThat: marsRover isIn: 1@2 heading: North.

! !


!classDefinition: #CardinalDirection category: 'MarsRover'!
Object subclass: #CardinalDirection
	instanceVariableNames: 'marsRover'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:32:05'!
initializeFor: aMarsRover

	marsRover := aMarsRover.

! !

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 11:52:39'!
moveBackwards

	self subclassResponsibility.! !

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 11:52:47'!
moveForward

	self subclassResponsibility.! !

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 11:52:53'!
turnLeft

	self subclassResponsibility.! !

!CardinalDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 11:52:56'!
turnRight

	self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CardinalDirection class' category: 'MarsRover'!
CardinalDirection class
	instanceVariableNames: ''!

!CardinalDirection class methodsFor: 'instance creation' stamp: 'MS 10/6/2021 11:51:26'!
for: aMarsRover

	^ self new initializeFor: aMarsRover.
	
	! !


!classDefinition: #EastDirection category: 'MarsRover'!
CardinalDirection subclass: #EastDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!EastDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:03:32'!
moveBackwards

	marsRover moveToWest.! !

!EastDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:03:42'!
moveForward

	marsRover moveToEast.! !

!EastDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:05:14'!
turnLeft

	marsRover turnToNorth.! !

!EastDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:05:24'!
turnRight

	marsRover turnToSouth.! !


!classDefinition: #NorthDirection category: 'MarsRover'!
CardinalDirection subclass: #NorthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!NorthDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:02:38'!
moveBackwards

	marsRover moveToSouth.

	! !

!NorthDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:02:24'!
moveForward

	marsRover moveToNorth.

	! !

!NorthDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:06:36'!
turnLeft

	marsRover turnToWest.! !

!NorthDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:06:29'!
turnRight

	marsRover turnToEast.! !


!classDefinition: #SouthDirection category: 'MarsRover'!
CardinalDirection subclass: #SouthDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!SouthDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:01:31'!
moveBackwards

	marsRover moveToNorth.! !

!SouthDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:02:57'!
moveForward

	marsRover moveToSouth.! !

!SouthDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:06:08'!
turnLeft

	marsRover turnToEast.! !

!SouthDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:06:16'!
turnRight

	marsRover turnToWest.! !


!classDefinition: #WestDirection category: 'MarsRover'!
CardinalDirection subclass: #WestDirection
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!WestDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:03:20'!
moveBackwards

	marsRover moveToEast.! !

!WestDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:03:10'!
moveForward

	marsRover moveToWest.! !

!WestDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:05:47'!
turnLeft

	marsRover turnToSouth.! !

!WestDirection methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:05:37'!
turnRight

	marsRover turnToNorth.! !


!classDefinition: #MarsRover category: 'MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'position direction'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'MarsRover'!

!MarsRover methodsFor: 'initialize' stamp: 'MS 10/6/2021 12:44:15'!
initializeAt: aPosition heading: aCardinalPoint

	position := aPosition.
	direction := aCardinalPoint initializeFor: self.! !


!MarsRover methodsFor: 'proccessing' stamp: 'MS 10/7/2021 10:42:55'!
process: aSequenceOfCommands
	aSequenceOfCommands do: [:aCommand| 
		(self isInvalidCommand: aCommand) ifTrue: [MarsRover error: MarsRover errorInvalidCommand].
		self processSingleCommand: aCommand.].
	! !

!MarsRover methodsFor: 'proccessing' stamp: 'MS 10/7/2021 10:44:02'!
processSingleCommand: aCommand
	
	aCommand = $f ifTrue: [direction moveForward ]	. 
	aCommand = $b ifTrue: [direction moveBackwards ].
	aCommand = $l ifTrue: [direction turnLeft ].
	aCommand = $r ifTrue: [direction turnRight ].
	! !


!MarsRover methodsFor: 'testing' stamp: 'MS 10/7/2021 10:48:03'!
isInvalidCommand: aCommand

	^ aCommand ~= $l 
		and: [aCommand ~= $r 
			and: [	aCommand ~= $f 
				and: [	aCommand ~= $b] ] ].! !


!MarsRover methodsFor: 'moving private' stamp: 'MS 10/6/2021 12:08:52'!
moveToEast
	
	^position := position + (1@0).! !

!MarsRover methodsFor: 'moving private' stamp: 'MS 10/6/2021 12:07:56'!
moveToNorth

	^position := position + (0@1).
	
	! !

!MarsRover methodsFor: 'moving private' stamp: 'MS 10/6/2021 12:08:14'!
moveToSouth

	^position := position - (0@1).
	
	! !

!MarsRover methodsFor: 'moving private' stamp: 'MS 10/6/2021 12:08:39'!
moveToWest
	^position := position - (1@0).! !


!MarsRover methodsFor: 'accessing' stamp: 'MS 10/6/2021 11:10:41'!
direction

	^direction! !

!MarsRover methodsFor: 'accessing' stamp: 'MS 10/6/2021 10:42:24'!
position

	^position! !


!MarsRover methodsFor: 'turning private' stamp: 'MS 10/6/2021 12:53:20'!
turnToEast
	
	^direction := EastDirection for: self.! !

!MarsRover methodsFor: 'turning private' stamp: 'MS 10/6/2021 12:53:32'!
turnToNorth
	
	^direction := NorthDirection for: self.! !

!MarsRover methodsFor: 'turning private' stamp: 'MS 10/6/2021 12:53:42'!
turnToSouth
	
	^direction := SouthDirection for: self.! !

!MarsRover methodsFor: 'turning private' stamp: 'MS 10/6/2021 12:53:55'!
turnToWest
	
	^direction := WestDirection for: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'error' stamp: 'Alejandro 10/6/2021 18:21:16'!
errorInvalidCommand
	^'This is not a valid command.'! !


!MarsRover class methodsFor: 'instance creation' stamp: 'MS 10/6/2021 10:36:40'!
isAt: aPosition heading: aCardinalPoint.

	^self new initializeAt: aPosition heading: aCardinalPoint. ! !
