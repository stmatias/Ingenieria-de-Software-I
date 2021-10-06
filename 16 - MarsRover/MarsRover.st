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


!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 11:02:55'!
assertThat: aMarsRover isIn: aPosition heading: aCardinalPoint

	self assert: aPosition equals: aMarsRover position.
		
	self assert: aCardinalPoint equals: aMarsRover direction.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:46:02'!
test01

	| marsRover |
		
	marsRover := MarsRover isAt: 1@2 heading:North.
	
	marsRover process: ''.
	
	self assertThat: marsRover isIn: 1@2 heading: North.

! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:46:06'!
test02

	| marsRover |
		
	marsRover := MarsRover isAt: 1@2 heading:North.
	
	marsRover process: 'f'.
	
	self assertThat: marsRover isIn: 1@3 heading: North.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:46:25'!
test03

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: North.
	
	marsRover process: 'b'.
	
	self assertThat: marsRover isIn: 1@1 heading: North.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:46:42'!
test04

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading:South.
	
	marsRover process: 'f'.
	
	self assertThat: marsRover isIn: 1@1 heading: South.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:47:03'!
test05

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: West.
	
	marsRover process: 'f'.
	
	self assertThat: marsRover isIn: 0@2 heading: West.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:47:16'!
test06

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: West.
	
	marsRover process: 'b'.
	
	self assertThat: marsRover isIn: 2@2 heading: West.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:48:36'!
test07

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: East.
	
	marsRover process: 'f'.
	
	self assertThat: marsRover isIn: 2@2 heading: East.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:48:02'!
test08

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: East.
	
	marsRover process: 'b'.
	
	self assertThat: marsRover isIn: 0@2 heading: East.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:48:09'!
test09

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: North.
	
	marsRover process: 'l'.
	
	self assertThat: marsRover isIn: 1@2 heading: West.

! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:48:22'!
test10

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: North.
	
	marsRover process: 'r'.
	
	self assertThat: marsRover isIn: 1@2 heading: East.

! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:47:50'!
test11

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading:East.
	
	marsRover process: 'l'.
	
	self assertThat: marsRover isIn: 1@2 heading: North.

! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:47:28'!
test12

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: West.
	
	marsRover process: 'l'.
	
	self assertThat: marsRover isIn: 1@2 heading: South.

! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:47:33'!
test13

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading:South.
	
	marsRover process: 'r'.
	
	self assertThat: marsRover isIn: 1@2 heading: West.

! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:47:38'!
test14

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: North.
	
	marsRover process: 'ff'.
	
	self assertThat: marsRover isIn: 1@4 heading: North.! !

!MarsRoverTest methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:47:42'!
test15

	| marsRover |
	
	marsRover := MarsRover isAt: 1@2 heading: North.
	
	marsRover process: 'ffffbfl'.
	
	self assertThat: marsRover isIn: 1@6 heading: West.! !


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

!CardinalDirection class methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 11:51:26'!
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


!MarsRover methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:08:52'!
moveToEast
	
	^position := position + (1@0).! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:07:56'!
moveToNorth

	^position := position + (0@1).
	
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:08:14'!
moveToSouth

	^position := position - (0@1).
	
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:08:39'!
moveToWest
	^position := position - (1@0).! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:38:38'!
pepito: aCommand
	
	
	aCommand = $f ifTrue: [direction moveForward ].
	aCommand = $b ifTrue: [direction moveBackwards ].
	aCommand = $l ifTrue: [direction turnLeft ].
	aCommand = $r ifTrue: [direction turnRight ].	
	! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 11:35:02'!
process: aSequenceOfCommands
	aSequenceOfCommands do: [:aCommand| 
		self pepito: aCommand].
	" 
	direction = #North ifTrue: [
		aSequenceOfCommands = 'f' ifTrue: [^position := position + (0@1)].
		aSequenceOfCommands = 'b' ifTrue: [^position := position - (0@1)].
		aSequenceOfCommands = 'l' ifTrue: [^direction := #West].
		aSequenceOfCommands = 'r' ifTrue: [^direction := #East].	
	].
	direction = #South ifTrue: [
		aSequenceOfCommands = 'f' ifTrue: [^position := position - (0@1)].
		aSequenceOfCommands = 'b' ifTrue: [^position := position + (0@1)].
		aSequenceOfCommands = 'l' ifTrue: [^direction := #East].
		aSequenceOfCommands = 'r' ifTrue: [^direction := #West].	
	].
	direction = #West ifTrue: [
		aSequenceOfCommands = 'f' ifTrue: [^position := position - (1@0)].
		aSequenceOfCommands = 'b' ifTrue: [^position := position + (1@0)].
		aSequenceOfCommands = 'l' ifTrue: [^direction := #South].
		aSequenceOfCommands = 'r' ifTrue: [^direction := #North].
	].
	direction = #East ifTrue: [
		aSequenceOfCommands = 'f' ifTrue: [^position := position + (1@0)].
		aSequenceOfCommands = 'b' ifTrue: [^position := position - (1@0)].
		aSequenceOfCommands = 'l' ifTrue: [^direction := #North].
		aSequenceOfCommands = 'r' ifTrue: [^direction := #South].
].		
"! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:53:20'!
turnToEast
	
	^direction := EastDirection for: self.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:53:32'!
turnToNorth
	
	^direction := NorthDirection for: self.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:53:42'!
turnToSouth
	
	^direction := SouthDirection for: self.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 12:53:55'!
turnToWest
	
	^direction := WestDirection for: self.! !


!MarsRover methodsFor: 'value' stamp: 'MS 10/6/2021 11:10:41'!
direction

	^direction! !

!MarsRover methodsFor: 'value' stamp: 'MS 10/6/2021 10:42:24'!
position

	^position! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: 'MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'MS 10/6/2021 10:36:40'!
isAt: aPosition heading: aCardinalPoint.

	^self new initializeAt: aPosition heading: aCardinalPoint. ! !
