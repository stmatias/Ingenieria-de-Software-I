!classDefinition: #I category: 'Numeros Naturales'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: 'Numeros Naturales'!
I class
	instanceVariableNames: ''!

!I class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 13:56:13'!
* aMultiplier

	^aMultiplier.! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 13:54:29'!
+ anAddend

	^anAddend next.! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 13:55:10'!
- aSubtrahend

	^self error: self descripcionDeErrorDeNumerosNegativosNoSoportados.! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 12:49:40'!
/ aDivisor

	aDivisor = I
		ifTrue: [^I]
		ifFalse: [^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor]! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 12:39:13'!
<= aNaturalNumber

	^true.! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 12:42:12'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No es posible dividir por un numero mayor'! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 12:43:06'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No es posible realizar esta resta en el dominio de los naturales'! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 8/26/2021 20:42:51'!
next 

	^II! !

!I class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 14:01:39'!
substractFrom: aMinuend 
	^aMinuend previous.! !


!classDefinition: #II category: 'Numeros Naturales'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: 'Numeros Naturales'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 13:56:20'!
* aMultiplier

	^ aMultiplier + (aMultiplier * self previous) .! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 13:54:37'!
+ anAddend

	^self previous + anAddend next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 14:02:15'!
- aSubtrahend
 
	^ aSubtrahend substractFrom: self.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 13:50:02'!
/ aDivisor

	|res|

	aDivisor <= self 
		ifFalse:[^self error: self descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor].
		
	res := I.
	[(res*aDivisor) <= self] whileTrue:[
			res := res next
			].
	^res previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 12:38:57'!
<= aNaturalNumber

	aNaturalNumber = I 
		ifTrue:[^false]
		ifFalse:[^self previous <= aNaturalNumber previous] ! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 12:46:55'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^'No es posible dividir por un numero mayor'! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 14:04:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := III.
	previous := I.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 8/30/2021 12:53:29'!
next

	next ifNotNil:[^next].  
	next _ II createChildNamed: self name, 'I'.
	next previous: self.
	^next.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 8/30/2021 12:51:39'!
previous
	^previous.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 8/30/2021 13:32:25'!
previous: aNaturalNumber 
	previous _ aNaturalNumber.! !

!II class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 14:02:25'!
substractFrom: aMinuend
	^self previous substractFrom: aMinuend previous.! !


!classDefinition: #III category: 'Numeros Naturales'!
II subclass: #III
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'III class' category: 'Numeros Naturales'!
III class
	instanceVariableNames: ''!

!III class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 14:04:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIII.
	previous := II.! !


!classDefinition: #IIII category: 'Numeros Naturales'!
II subclass: #IIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIII class' category: 'Numeros Naturales'!
IIII class
	instanceVariableNames: ''!

!IIII class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 14:04:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIII.
	previous := III.! !


!classDefinition: #IIIII category: 'Numeros Naturales'!
II subclass: #IIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIII class' category: 'Numeros Naturales'!
IIIII class
	instanceVariableNames: ''!

!IIIII class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 14:04:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIII.
	previous := IIII.! !


!classDefinition: #IIIIII category: 'Numeros Naturales'!
II subclass: #IIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIII class' category: 'Numeros Naturales'!
IIIIII class
	instanceVariableNames: ''!

!IIIIII class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 14:04:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIII.
	previous := IIIII.! !


!classDefinition: #IIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIII class' category: 'Numeros Naturales'!
IIIIIII class
	instanceVariableNames: ''!

!IIIIIII class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 14:04:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := IIIIIIII.
	previous := IIIIII.! !


!classDefinition: #IIIIIIII category: 'Numeros Naturales'!
II subclass: #IIIIIIII
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros Naturales'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IIIIIIII class' category: 'Numeros Naturales'!
IIIIIIII class
	instanceVariableNames: ''!

!IIIIIIII class methodsFor: 'as yet unclassified' stamp: 'MS 9/1/2021 14:04:24'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := IIIIIII.! !

II initializeAfterFileIn!
III initializeAfterFileIn!
IIII initializeAfterFileIn!
IIIII initializeAfterFileIn!
IIIIII initializeAfterFileIn!
IIIIIII initializeAfterFileIn!
IIIIIIII initializeAfterFileIn!