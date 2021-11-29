!classDefinition: #TusLibrosClientWindow category: 'TusLibros-Model'!
Panel subclass: #TusLibrosClientWindow
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'MS 11/27/2021 18:00:37'!
defaultExtent

	^ 1000@485! !

!TusLibrosClientWindow methodsFor: 'as yet unclassified' stamp: 'MS 11/27/2021 17:31:31'!
initializeDefaultWindow

	TusLibrosClientWindowCreateCart open.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindow class' category: 'TusLibros-Model'!
TusLibrosClientWindow class
	instanceVariableNames: ''!

!TusLibrosClientWindow class methodsFor: 'as yet unclassified' stamp: 'MS 11/27/2021 17:31:02'!
open

	^ self new initializeDefaultWindow! !


!classDefinition: #TusLibrosClientWindowAddToCart category: 'TusLibros-Model'!
TusLibrosClientWindow subclass: #TusLibrosClientWindowAddToCart
	instanceVariableNames: 'cartListMorph quantityToAddTextBoxMorph loginWindow catalogList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosClientWindowAddToCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:37:19'!
buildCartColumn

	| removeFromCartButtonMorph checkoutButtonMorph listPurchasesButtonMorph 
		cartColumnLayout logOutButtonMorph |
	
	cartListMorph := PluggableListMorph 
		model: self model 
		listGetter: #cartList
		indexGetter: #cartListIndex 
		indexSetter: #cartListIndex:.
	cartListMorph 
		borderColor: Color skyBlue; 
		borderWidth: 1.
	cartListMorph layoutSpec 
		proportionalWidth: 100;
		proportionalHeight: 100.
		
	removeFromCartButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #removeFromCart  
		label: 'Quitar del carro'.	
		
	checkoutButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #checkOut  
		label: 'Check out'.	
		
	listPurchasesButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #listPurchases  
		label: 'Purchase history'.	
		
	logOutButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #logout  
		label: 'Log out'.	
		
	cartColumnLayout := LayoutMorph newColumn.
	cartColumnLayout 
		addMorph: (LabelMorph contents: 'Cart');
		addMorph: cartListMorph;
		addMorph: removeFromCartButtonMorph;
		addMorph: checkoutButtonMorph;
		addMorph: listPurchasesButtonMorph;
		addMorph: logOutButtonMorph.
		
	^ cartColumnLayout! !

!TusLibrosClientWindowAddToCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:37:01'!
buildCatalogColumn

	| productSelectionLayoutMorph |
	
	catalogList := PluggableListMorph 
		model: self model 
		listGetter: #catalog
		indexGetter: #catalogListIndex 
		indexSetter: #catalogListIndex:.
	catalogList 
		borderColor: Color skyBlue; 
		borderWidth: 1.
	catalogList layoutSpec 
		proportionalWidth: 100;
		proportionalHeight: 100.
		
	productSelectionLayoutMorph := LayoutMorph newColumn.
	productSelectionLayoutMorph 
		separation: 10;
		axisEdgeWeight: 0;
		addMorph: (LabelMorph contents: 'Catalog');
		addMorph: catalogList;
		addMorph: self buildQuantitySelectionRow.
		
	^ productSelectionLayoutMorph ! !

!TusLibrosClientWindowAddToCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:36:50'!
buildMorphicWindow

	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: self buildCatalogColumn;
	addMorph: self buildCartColumn.! !

!TusLibrosClientWindowAddToCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:37:53'!
buildQuantitySelectionRow

	| addProductButtonMorph quantitySelectionRowLayout |
	
	quantityToAddTextBoxMorph := TextModelMorph 
		textProvider: self model 
		textGetter: #quantityToAdd 
		textSetter: #quantityToAdd:. 
	quantityToAddTextBoxMorph innerTextMorph 
		setProperty: #keyStroke:
		toValue: [ :key | quantityToAddTextBoxMorph innerTextMorph  acceptContents ].
	quantityToAddTextBoxMorph 
		borderWidth: 1;
		borderColor: Color skyBlue.
	
	addProductButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #addToCart  
		label: 'Add to cart'.	
		
	quantitySelectionRowLayout := LayoutMorph newRow.
	quantitySelectionRowLayout
		addMorph: (LabelMorph contents: 'Quantity');
		addMorph: quantityToAddTextBoxMorph;
		addMorph: addProductButtonMorph.
		
	^ quantitySelectionRowLayout.
		
	
	
	
! !

!TusLibrosClientWindowAddToCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:33:31'!
initializeTitled: aTitle withModel: aModel from: aLoginWindow

	loginWindow := aLoginWindow.

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: aModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	
	self openInWorld.
	
	self model when: #cartHasChanged send: #refreshCart to: self.
	self model when: #purchaseDone send: #openTicketWindow to: self.
	self model when: #logoutDone send: #logout to: self.! !

!TusLibrosClientWindowAddToCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:36:25'!
logout

	self updateFields.
	self openLoginWindow.! !

!TusLibrosClientWindowAddToCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:36:15'!
openLoginWindow

	loginWindow openInWorld.
	self delete.! !

!TusLibrosClientWindowAddToCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:36:06'!
openTicketWindow

	TusLibrosClientWindowTicket openWith: self model from: loginWindow.
	self delete.! !

!TusLibrosClientWindowAddToCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:35:32'!
refreshCart
	
	cartListMorph updateList.
	catalogList setSelectionIndex: 0.! !

!TusLibrosClientWindowAddToCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:32:02'!
updateFields

	quantityToAddTextBoxMorph model actualContents: model quantityToAdd! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindowAddToCart class' category: 'TusLibros-Model'!
TusLibrosClientWindowAddToCart class
	instanceVariableNames: ''!

!TusLibrosClientWindowAddToCart class methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:31:36'!
openWith: aModel from: aLoginWindow

	^ self new initializeTitled: 'Tus Libros - Bievenido ' withModel: aModel from: aLoginWindow.! !


!classDefinition: #TusLibrosClientWindowCreateCart category: 'TusLibros-Model'!
TusLibrosClientWindow subclass: #TusLibrosClientWindowCreateCart
	instanceVariableNames: 'userNameTextBoxMorph passwordTextBoxMorph'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosClientWindowCreateCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:40:52'!
buildClientIdRow

	| clientIdRowLayoutMorph |
	
	userNameTextBoxMorph := TextModelMorph
		textProvider: self model
		textGetter: #clientId
		textSetter: #clientId:.
		
	userNameTextBoxMorph  innerTextMorph  
		setProperty: #keyStroke: 
		toValue: [ :key | userNameTextBoxMorph  innerTextMorph acceptContents ].
		
	userNameTextBoxMorph  
		borderWidth: 1; 
		borderColor: Color skyBlue; 
		morphWidth: 300.
		
	clientIdRowLayoutMorph := LayoutMorph newRow.
	clientIdRowLayoutMorph
		separation: 25;
		axisEdgeWeight: 0.5;
		addMorph: (LabelMorph contents: 'Client ID:');
		addMorph: userNameTextBoxMorph .
		
	^ clientIdRowLayoutMorph! !

!TusLibrosClientWindowCreateCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:41:22'!
buildMorphicWindow

	self 
		layoutMorph beColumn;
		separation: 15;
		axisEdgeWeight: 0;
		addMorph: self buildClientIdRow;
		addMorph: self buildPasswordRow;
		addMorph: self buildSubmitButton.! !

!TusLibrosClientWindowCreateCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:41:02'!
buildPasswordRow

	| passwordRowLayoutMorph |
	
	passwordTextBoxMorph := TextModelMorph
		textProvider: self model
		textGetter: #password
		textSetter: #password:.
		
	passwordTextBoxMorph innerTextMorph  
		setProperty: #keyStroke: 
		toValue: [ :key | passwordTextBoxMorph innerTextMorph  acceptContents ].
		
	passwordTextBoxMorph 
		borderWidth: 1; 
		borderColor: Color skyBlue; 
		morphWidth: 300.
		
	passwordRowLayoutMorph := LayoutMorph newRow.
	passwordRowLayoutMorph
		separation: 25;
		axisEdgeWeight: 0.5;
		addMorph: (LabelMorph contents: 'Password:');
		addMorph: passwordTextBoxMorph.
		
	^ passwordRowLayoutMorph! !

!TusLibrosClientWindowCreateCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:18:32'!
buildSubmitButton

	| submitButtonMorph |
	
	submitButtonMorph := PluggableButtonMorph
		model: self model
		stateGetter: nil 
		action: #login 
		label: 'Login'.
	
	^ submitButtonMorph! !

!TusLibrosClientWindowCreateCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:35:59'!
initializeWith: aTitle

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: (TusLibrosClientWindowModel new).
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
	
	self model when: #succesfulLogin send: #openMarketWindow to: self.
	self model when: #error send: #openMarketWindow to: self.
	self model when: #logout send: #update to: self.
	
		
	! !

!TusLibrosClientWindowCreateCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:09:34'!
openErrorWindow

	TusLibrosClientWindowError openWith: self model.! !

!TusLibrosClientWindowCreateCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:46:58'!
openMarketWindow
	
	TusLibrosClientWindowAddToCart openWith: self model from: self.
	self delete.! !

!TusLibrosClientWindowCreateCart methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:25:00'!
updateFields

	userNameTextBoxMorph model actualContents: model clientId.
	passwordTextBoxMorph model actualContents: model password.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindowCreateCart class' category: 'TusLibros-Model'!
TusLibrosClientWindowCreateCart class
	instanceVariableNames: ''!

!TusLibrosClientWindowCreateCart class methodsFor: 'as yet unclassified' stamp: 'MS 11/27/2021 17:28:21'!
open

	^self new initializeWith: 'Tus Libros'! !


!classDefinition: #TusLibrosClientWindowError category: 'TusLibros-Model'!
TusLibrosClientWindow subclass: #TusLibrosClientWindowError
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosClientWindowError methodsFor: 'as yet unclassified' stamp: 'MS 11/27/2021 17:54:42'!
build1stRow

	| firstColumnLayoutMorphOfSecondRow continueShoppingButtonMorph |
	
	continueShoppingButtonMorph := TextModelMorph withText: self model errorMessage.	
	
	firstColumnLayoutMorphOfSecondRow := LayoutMorph newColumn.
	firstColumnLayoutMorphOfSecondRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Error:');
	addMorph: continueShoppingButtonMorph.
	
	
	firstColumnLayoutMorphOfSecondRow layoutSpec fixedWidth: 390.
		
	^firstColumnLayoutMorphOfSecondRow.
	
	! !

!TusLibrosClientWindowError methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:42:29'!
buildMorphicWindow

	self layoutMorph 
		beColumn;
		separation: 15;
		axisEdgeWeight: 0;
		addMorph: (LabelMorph contents: self model errorMessage).
	self layoutMorph 
		layoutSpec 
		fixedHeight: 300; 
		fixedWidth: 300.! !

!TusLibrosClientWindowError methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:35:41'!
intializeWith: aTitle withModel: aModel

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: aModel .
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindowError class' category: 'TusLibros-Model'!
TusLibrosClientWindowError class
	instanceVariableNames: ''!

!TusLibrosClientWindowError class methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:11:51'!
openWith: aModel

	^ self new intializeWith: 'Error' withModel: aModel! !


!classDefinition: #TusLibrosClientWindowPurchases category: 'TusLibros-Model'!
TusLibrosClientWindow subclass: #TusLibrosClientWindowPurchases
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosClientWindowPurchases methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:22:30'!
buildMorphicWindow

	| purchaseHistoryListMorph |
	
	purchaseHistoryListMorph := PluggableListMorph 
		model: self model 
		listGetter: #purchaseHistoryList
		indexGetter: #purchaseHistoryListIndex 
		indexSetter: #purchaseHistoryListIndex:.
	purchaseHistoryListMorph 
		borderColor: Color skyBlue; 
		borderWidth: 1.
	purchaseHistoryListMorph layoutSpec 
		proportionalWidth: 100;
		proportionalHeight: 100.
	
	self layoutMorph beRow;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: purchaseHistoryListMorph.! !

!TusLibrosClientWindowPurchases methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:31:54'!
initializeWith: aTitle withPurchases: aPurchases 

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model:aPurchases .
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	self openInWorld.

			! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindowPurchases class' category: 'TusLibros-Model'!
TusLibrosClientWindowPurchases class
	instanceVariableNames: ''!

!TusLibrosClientWindowPurchases class methodsFor: 'as yet unclassified' stamp: 'MS 11/27/2021 17:53:42'!
withPurchases: aPurchases

	^ self new initializeWith: 'Tus Libros - Historial' withPurchases: aPurchases ! !


!classDefinition: #TusLibrosClientWindowTicket category: 'TusLibros-Model'!
TusLibrosClientWindow subclass: #TusLibrosClientWindowTicket
	instanceVariableNames: 'loginWindow'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosClientWindowTicket methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 22:53:56'!
build1stRow

	| firstColumnLayoutMorphOfSecondRow continueShoppingButtonMorph ticketListMorph logOutButtonMorph |
	
	continueShoppingButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #continueShoppingActionButton label: 'Realizar otra compra'.	
	
	logOutButtonMorph := PluggableButtonMorph model: self model stateGetter: nil  action: #logOutActionButton label: 'Cerrar sesion'.	
	
	ticketListMorph := PluggableListMorph model: self model listGetter: #ticket indexGetter: #ticketSelectedIndex indexSetter: #ticketSelectedIndex.
	ticketListMorph  borderColor: Color skyBlue; borderWidth: 1; morphWidth:300.
	
	firstColumnLayoutMorphOfSecondRow := LayoutMorph newColumn.
	firstColumnLayoutMorphOfSecondRow separation: 5; 
	axisEdgeWeight: 0.5;
	addMorph: (LabelMorph contents:'Ticket Tus Libros');
	addMorph: ticketListMorph;
	addMorph: continueShoppingButtonMorph;
	addMorph: logOutButtonMorph.
	
	firstColumnLayoutMorphOfSecondRow layoutSpec fixedWidth: 390.
		
	^firstColumnLayoutMorphOfSecondRow.
	! !

!TusLibrosClientWindowTicket methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:20:28'!
buildMorphicWindow

	| ticketListMorph buttonsLayoutMorph logOutButtonMorph newShoppingCartButtonMorph |
	
	ticketListMorph := PluggableListMorph 
		model: self model 
		listGetter: #ticketList
		indexGetter: #ticketListIndex 
		indexSetter: #ticketListIndex:.
	ticketListMorph 
		borderColor: Color skyBlue; 
		borderWidth: 1.
	ticketListMorph layoutSpec 
		proportionalWidth: 100;
		proportionalHeight: 100.
		
	newShoppingCartButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #newShoppingCart  
		label: 'New shopping cart'.	
	
	logOutButtonMorph := PluggableButtonMorph 
		model: self model 
		stateGetter: nil 
		action: #logout  
		label: 'Log out'.	
	
	buttonsLayoutMorph := LayoutMorph newRow.
	buttonsLayoutMorph
		separation: 10;
		axisEdgeWeight: 0.5;
		addMorph: newShoppingCartButtonMorph;
		addMorph: logOutButtonMorph.
	
	self layoutMorph beColumn;
	separation: 15;
	axisEdgeWeight: 0;
	addMorph: (LabelMorph contents: 'Purchase detail');
	addMorph: ticketListMorph;
	addMorph: buttonsLayoutMorph.! !

!TusLibrosClientWindowTicket methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:20:37'!
defaultExtent

	^ 500@700! !

!TusLibrosClientWindowTicket methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:20:53'!
initializeTitled: aTitle withModel: aModel from: aLoginWindow

	loginWindow := aLoginWindow .

	self titleMorph showButtonsNamed: #( close collapse ).
	self setLabel: aTitle.
	self model: aModel.
	self morphExtent: (self defaultExtent).
	self buildMorphicWindow.
	
	self openInWorld.
	
	self model when: #newShoppingCartCreated send: #openMarketWindow to: self.
	self model when: #logoutDone send: #openLoginWindow to: self.! !

!TusLibrosClientWindowTicket methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:21:01'!
openLoginWindow

	loginWindow openInWorld.
	self delete.! !

!TusLibrosClientWindowTicket methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:21:16'!
openMarketWindow

	TusLibrosClientWindowAddToCart openWith: self model from: loginWindow.
	self delete! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosClientWindowTicket class' category: 'TusLibros-Model'!
TusLibrosClientWindowTicket class
	instanceVariableNames: ''!

!TusLibrosClientWindowTicket class methodsFor: 'as yet unclassified' stamp: 'MS 11/27/2021 18:12:42'!
for: aCartId withUserName: anUserName withPassword: aPassword andTicket: aTicket 

	^self new initializeWith: ('Tus Libros - Ticket - ', anUserName asString) for: aCartId userName: anUserName withPassword: aPassword andTicket: aTicket.! !


!classDefinition: #AuthenticationSystem category: 'TusLibros-Model'!
Object subclass: #AuthenticationSystem
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!


!classDefinition: #Cart category: 'TusLibros-Model'!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^self class invalidItemErrorMessage ! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^self class invalidQuantityErrorMessage ! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:17'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self signalInvalidItem ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:18'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [self signalInvalidQuantity ]! !


!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:17'!
catalog

	^ catalog! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/22/2013 12:30'!
content

	^items copy! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/23/2013 12:10'!
itemsAndQuantitiesDo: aBlock

	^ items contents keysAndValuesDo: [ :anItem :aQuantity | aBlock value: anItem value: aQuantity ]! !

!Cart methodsFor: 'content' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:29'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := Bag new.! !


!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:18'!
signalInvalidItem

	self error: self invalidItemErrorMessage! !

!Cart methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:19'!
signalInvalidQuantity

	self error: self invalidQuantityErrorMessage ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty

	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/22/2013 12:31'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	items add: anItem withOccurrences: aQuantity ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: 'TusLibros-Model'!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^'Item is not in catalog'! !

!Cart class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 00:00'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !


!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #CartSession category: 'TusLibros-Model'!
Object subclass: #CartSession
	instanceVariableNames: 'owner cart lastUsedTime systemFacade'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:34'!
assertIsNotExpirtedAt: aTime

	(self isExpiredAt: aTime) ifTrue: [ self signalCartSessionExpired ]! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
isExpiredAt: aTime

	^ (lastUsedTime + systemFacade sessionDuration) < aTime! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:36'!
now

	^systemFacade now! !

!CartSession methodsFor: 'time/expiration' stamp: 'HernanWilkinson 6/17/2015 20:37'!
today

	^systemFacade today! !


!CartSession methodsFor: 'session management' stamp: 'HernanWilkinson 6/17/2015 20:35'!
do: aBlock

	| now |

	now := self now.
	self assertIsNotExpirtedAt: now.

	^ [ aBlock value: self ] ensure: [ lastUsedTime := now  ]! !


!CartSession methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2015 20:36'!
initializeOwnedBy: aCustomer with: aCart on: aSystemFacade

	owner := aCustomer.
	cart := aCart.
	systemFacade := aSystemFacade.
	lastUsedTime := self now.! !


!CartSession methodsFor: 'error signal' stamp: 'HernanWilkinson 6/17/2015 20:37'!
signalCartSessionExpired

	self error: systemFacade sessionHasExpiredErrorDescription ! !


!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:34'!
addToCart: anAmount of: aBook

	^cart add: anAmount of: aBook! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
cartContent

	^cart content! !

!CartSession methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2015 20:35'!
checkOutCartWithCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	^(Cashier
		toCheckout: cart
		ownedBy: owner
		charging: (CreditCard expiringOn: anExpirationMonthOfYear)
		throught: systemFacade merchantProcessor
		on: self today
		registeringOn: systemFacade salesBook) checkOut ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: 'TusLibros-Model'!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2015 20:37'!
ownedBy: aCustomer with: aCart on: aSystemFacade

	^self new initializeOwnedBy: aCustomer with: aCart on: aSystemFacade! !


!classDefinition: #Cashier category: 'TusLibros-Model'!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard owner ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
createLineItemOf: anItem quantity: aQuantity

	^LineItem of: anItem quantity: aQuantity total: (self totalOf: anItem quantity: aQuantity) ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:25'!
createSale

	^ Sale doneBy: owner certifiedWith: ticket
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:28'!
createTicket

	| lineItems |

	lineItems := OrderedCollection new.
	cart itemsAndQuantitiesDo: [ :anItem :aQuantity |
		lineItems add: (self createLineItemOf: anItem quantity: aQuantity)].

	ticket := Ticket of: lineItems
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:20'!
debitTotal

	merchantProcessor debit: ticket total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/22/2013 12:17'!
totalOf: anItem quantity: aQuantity

	^(cart catalog at: anItem) * aQuantity  ! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/22/2013 12:28'!
checkOut

	self createTicket.
	self debitTotal.
	self registerSale.

	^ ticket ! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:02'!
initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook

	cart := aCart.
	owner := anOwner.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: 'TusLibros-Model'!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotEmpty: aCart

	aCart isEmpty ifTrue: [self signalCartCanNotBeEmpty ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/22/2013 14:22'!
assertIsNotExpired: aCreditCard on: aDate

	(aCreditCard isExpiredOn: aDate) ifTrue: [self signalCanNotChargeAnExpiredCreditCard]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:00'!
toCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook

	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.

	^self new initializeToCheckout: aCart ownedBy: anOwner charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage

	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage

	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage

	^'Credit card has no credit'! !


!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCanNotChargeAnExpiredCreditCard

	 self error: self canNotChargeAnExpiredCreditCardErrorMessage ! !

!Cashier class methodsFor: 'error signal' stamp: 'HernanWilkinson 6/22/2013 14:22'!
signalCartCanNotBeEmpty

	self error: self cartCanNotBeEmptyErrorMessage! !


!classDefinition: #ClientInformation category: 'TusLibros-Model'!
Object subclass: #ClientInformation
	instanceVariableNames: 'clientId password creditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!ClientInformation methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 13:01:06'!
creditCard
	
	^creditCard! !

!ClientInformation methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 13:00:59'!
initializeFor: aClientId authenticatedWith: aPassword payingWith: aCreditCard 
	
	clientId := aClientId.
	password := aPassword.
	creditCard := aCreditCard.! !

!ClientInformation methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 13:01:12'!
password
	
	^password! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ClientInformation class' category: 'TusLibros-Model'!
ClientInformation class
	instanceVariableNames: ''!

!ClientInformation class methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 13:00:51'!
for: aClientId authenticatedWith: aPassword payingWith: aCreditCard 
	
	^self new initializeFor: aClientId authenticatedWith: aPassword payingWith: aCreditCard ! !


!classDefinition: #ClientInterface category: 'TusLibros-Model'!
Object subclass: #ClientInterface
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!ClientInterface methodsFor: 'as yet unclassified' stamp: 'AC 11/15/2021 21:31:04'!
createCartRequest: aUser with: aPassword

	| fieldDict resp |
	fieldDict := Dictionary newFromPairs: {'clientId' . aUser .  'password' . aPassword}.
	
	resp:= WebClient htmlSubmit: (self url,'/createCart') fields: fieldDict.
	
	resp isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((resp content) readStream)).] 
		ifFalse:[^self error: resp content].! !

!ClientInterface methodsFor: 'as yet unclassified' stamp: 'AC 11/15/2021 22:28:13'!
port
	
	^port ifNil: [port:=8093].! !

!ClientInterface methodsFor: 'as yet unclassified' stamp: 'AC 11/15/2021 21:03:59'!
url
	
	^'http://localhost:', self port asString! !


!classDefinition: #Clock category: 'TusLibros-Model'!
Object subclass: #Clock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Clock methodsFor: 'time' stamp: 'AC 11/15/2021 22:26:53'!
now

	self subclassResponsibility ! !

!Clock methodsFor: 'time' stamp: 'AC 11/15/2021 22:26:47'!
today

	self subclassResponsibility! !


!classDefinition: #CreditCard category: 'TusLibros-Model'!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!CreditCard methodsFor: 'testing' stamp: 'MS 11/29/2021 13:00:05'!
assertNameIsValid: aName

	aName isEmpty 		ifTrue: [ self error: self class invalidCreditCardrrorMessage ].
	
	aName withBlanksTrimmed isEmpty		ifTrue: [ self error: self class invalidCreditCardrrorMessage ].
	
	aName size > 30 
		ifTrue: [ self error: self class invalidCreditCardrrorMessage ].! !

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate

	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'expiration' stamp: 'MS 11/15/2021 14:28:11'!
expiration

	^ expiration ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth

	expiration := aMonth ! !


!CreditCard methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 13:02:18'!
initializeWithNumber: aCreditCardNumber of: aName expiringOn: aMonth

	self assertNameIsValid: aName.

	
	expiration := aMonth.
	number := aCreditCardNumber.
	name := aName.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: 'TusLibros-Model'!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth

	^self new initializeExpiringOn: aMonth! !

!CreditCard class methodsFor: 'instance creation' stamp: 'MS 11/29/2021 13:00:05'!
invalidCreditCardrrorMessage

	'Invalid credit card'! !

!CreditCard class methodsFor: 'instance creation' stamp: 'MS 11/29/2021 12:56:47'!
withNumber: aCreditCardNumber of: aName expiringOn: aMonth 
	
	^self new initializeWithNumber: aCreditCardNumber of: aName expiringOn: aMonth.! !


!classDefinition: #LineItem category: 'TusLibros-Model'!
Object subclass: #LineItem
	instanceVariableNames: 'item quantity total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:33'!
item

	^ item! !

!LineItem methodsFor: 'accessing' stamp: 'HernanWilkinson 6/22/2013 12:21'!
total

	^ total! !


!LineItem methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:18'!
initializeOf: anItem quantity: aQuantity total: aTotal

	item := anItem.
	quantity := aQuantity.
	total := aTotal

! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LineItem class' category: 'TusLibros-Model'!
LineItem class
	instanceVariableNames: ''!

!LineItem class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:18'!
of: anItem quantity: aQuantity total: aTotal

	^self new initializeOf: anItem quantity: aQuantity total: aTotal

! !


!classDefinition: #MerchantProcessor category: 'TusLibros-Model'!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:31'!
README

	"Aunque nadie subclasifica esta clase, esta para definir el protocolo que se espera que todo MerchantProcessor sepa responder - Hernan"! !

!MerchantProcessor methodsFor: 'debit' stamp: 'HernanWilkinson 6/22/2013 14:30'!
debit: anAmount from: aCreditCard

	self subclassResponsibility ! !


!classDefinition: #MerchantProcessorForInterface category: 'TusLibros-Model'!
MerchantProcessor subclass: #MerchantProcessorForInterface
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!MerchantProcessorForInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 13:04:09'!
debit: anAmount from: aCreditCard

	aCreditCard number = self class creditCardNumberWithoutFunds 
		ifTrue: [self error: self class creditCardWithoutFundsErrorDescription ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorForInterface class' category: 'TusLibros-Model'!
MerchantProcessorForInterface class
	instanceVariableNames: ''!

!MerchantProcessorForInterface class methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 13:03:51'!
creditCardNumberWithoutFunds

	^ 1111111111111111! !

!MerchantProcessorForInterface class methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 13:03:59'!
creditCardWithoutFundsErrorDescription

	^ 'Credit card without funds'! !


!classDefinition: #Sale category: 'TusLibros-Model'!
Object subclass: #Sale
	instanceVariableNames: 'customer ticket'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Sale methodsFor: 'testing' stamp: 'HernanWilkinson 6/22/2013 12:06'!
wasDoneBy: aCustomer

	^customer = aCustomer ! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:26'!
initializeDoneBy: aCustomer certifiedWith: aTicket

	customer := aCustomer.
	ticket := aTicket ! !


!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/22/2013 12:26'!
total

	^ ticket total! !


!Sale methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^ticket lineItemsDo: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: 'TusLibros-Model'!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:25'!
doneBy: aCustomer certifiedWith: aTicket

	^self new initializeDoneBy: aCustomer certifiedWith: aTicket ! !


!classDefinition: #Ticket category: 'TusLibros-Model'!
Object subclass: #Ticket
	instanceVariableNames: 'lineItems'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!Ticket methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2015 20:39'!
total

	^lineItems sum: [ :aLineItem | aLineItem total]! !


!Ticket methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 12:20'!
initializeOf: aCollectionOfLineItems

	lineItems := aCollectionOfLineItems ! !


!Ticket methodsFor: 'line items' stamp: 'HernanWilkinson 6/22/2013 12:33'!
lineItemsDo: aBlock

	^lineItems do: aBlock ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: 'TusLibros-Model'!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 12:20'!
of: aCollectionOfLineItems

	^self new initializeOf: aCollectionOfLineItems ! !


!classDefinition: #TusLibrosClientWindowModel category: 'TusLibros-Model'!
Object subclass: #TusLibrosClientWindowModel
	instanceVariableNames: 'cartId userName password interface errorMessage clientId restInterface quantityToAdd catalogList catalogListIndex cartList cartListIndex purchaseHistoryList ticketList'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:44:05'!
addToCart

	self doSignalingError: [ | aProduct  |
		
		aProduct := self selectedProductFromCatalog.
		
		restInterface  sendRequestForAddToCart: (self convertToNumber: quantityToAdd) of: aProduct with: cartId.
		
		self listCartCart.
		]! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:33:49'!
cartList

	^ cartList collect: [ :keyAndValue | (keyAndValue at: 1), '    ', (keyAndValue at: 2) asString ]! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:33:53'!
cartListIndex

	^ cartListIndex! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:33:58'!
cartListIndex: newIndex

	cartListIndex := newIndex! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:37:44'!
catalog
	
	^ catalogList collect: [ :productAndPrice | (productAndPrice at: 1), '    $', (productAndPrice at: 2) asString ]! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:37:38'!
catalogListIndex

	^ catalogListIndex! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:37:30'!
catalogListIndex: newIndex

	catalogListIndex := newIndex! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:27:13'!
checkOut

	self doSignalingError: [ | ticket |
	
		ticket := restInterface sendRequestForCheckoutToCart: cartId.
		
		self mapTicketResponse: ticket.
		
		self cleanCart.
		
		self triggerEvent: #purchaseDone with: self.
	]! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:34:03'!
cleanCart

	cartList removeAll.
	self cartListIndex: 0! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:34:23'!
clientId

	^ clientId! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:34:35'!
clientId: newClientId

	clientId := newClientId! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:37:18'!
convertToNumber: value

	| number errorMsg |
	
	errorMsg := 'value must be an integer greater than zero'.
	
	[ number := value asNumber.
	(number isInteger not or: [ number < 1 ]) 
		ifTrue: [self error: errorMsg ] ]
	on: Error 
	do: [:error | self error: errorMsg ].
	
	^ number! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:33:24'!
createCartRequest
	
	| catalog |
	
	[cartId _ interface sendRequestForCreateCartWithUser: userName andPassword: password]
	on: Error
	do:[:anError | | message | 
		message _ interface messageTextError: anError messageText.
		^TusLibrosClientWindowError openWith: message].
	
	catalog _ interface sendRequestForCatalog.
	
	TusLibrosClientWindowAddToCart openWith: catalog from: 	cartId .
	
	! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:52:51'!
doSignalingError: aClosure

	[^ aClosure value ] on: Error do: [ :error |
		
		self errorMessage: error messageText.
		self triggerEvent: #error with: self.
		]! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:36:03'!
doSignalingLoginError: aClosure

	[^ aClosure value ] on: Error do: [ :error |
		
		self errorMessage: error messageText.
		self triggerEvent: #loginErrorOccurred with: self.
		]! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:53:05'!
doSignalingMarketError: aClosure

	[^ aClosure value ] on: Error do: [ :error |
		
		self errorMessage: error messageText.
		self triggerEvent: #error with: self.
		]! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:34:44'!
emptyCardErrorDescription
	
	^'Empty card'! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:34:02'!
emptyCatalogErrorDescription 

	^'Empty catalog'	! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:36:13'!
errorMessage

	^ errorMessage! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:36:17'!
errorMessage: anErrorMessage

	errorMessage := anErrorMessage! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:33:05'!
initialize

	errorMessage := ''.
	clientId := ''.
	password := ''.
	restInterface := TusLibrosInterface new.
	quantityToAdd := '1'.
	catalogList := OrderedCollection new.
	catalogListIndex := 0.
	cartList := OrderedCollection new.
	cartListIndex := 0.
	purchaseHistoryList := OrderedCollection new.
	ticketList := OrderedCollection new.
! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:39:06'!
listCartCart

	self doSignalingError: [ |  cartDictionary |
	
		cartDictionary := restInterface sendListCartRequestFor: cartId.
		
		cartList removeAll.	
		cartDictionary keysAndValuesDo: [ :key :value | cartList add: {key. value}].
		
		self triggerEvent: #cartHasChanged with: self.
	]! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:38:53'!
listPurchases

	self doSignalingError: [ | purchaseHistoryDictionary |
	
		purchaseHistoryList removeAll.
		
		purchaseHistoryDictionary := restInterface sendListPurchasesRequestFor: clientId authenticatedWith: password.
		
		self mapPurchasesResponse: purchaseHistoryDictionary.
		
		TusLibrosClientWindowPurchases openWith: self.
	]! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:45:23'!
login

	self doSignalingError: [ | catalogDictionary |
	
		cartId := restInterface sendRequestForCreateCartWithUser: clientId		andPassword: password.
			
		catalogDictionary := restInterface sendRequestForListCatalog .
		
		self mapCatalogResponse: catalogDictionary.
			
		self triggerEvent: #successfulLogin with: self.
	]! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:38:05'!
logout

	self doSignalingError: [
		self initialize.
		self triggerEvent: #logoutDone with: self.
		]! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:34:57'!
mapCatalogResponse: catalogDictionary
	
	catalogList removeAll.	
	catalogDictionary keysAndValuesDo: [ :key :value | catalogList add: {key. value}].! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:35:06'!
mapPurchasesResponse: purchaseHistoryDictionary

	|  items total |
	
	purchaseHistoryList removeAll.
	
	items := purchaseHistoryDictionary at: 'items'.
	total := purchaseHistoryDictionary at: 'total'.
	
	items do: [ :itemAndQuantity | purchaseHistoryList add: (itemAndQuantity at: 'item') , '    ' , (itemAndQuantity at: 'quantity') asString ].
	purchaseHistoryList add: ('Total:   $' , total asString ).! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:35:13'!
mapTicketResponse: ticket 
	
	| ticketTotal |
	
	ticketList removeAll.
	
	ticketTotal := 0.
	
	ticket do: [ :itemAndTotal | | total | 
		total := itemAndTotal at: 'total'.
		ticketList add: (itemAndTotal at: 'item') , '    $' , total asString.
		ticketTotal := ticketTotal + total.
		].
	ticketList add: 'Total:    $' , ticketTotal asString.! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:26:43'!
newShoppingCart

	self doSignalingError: [
		cartId := restInterface sendRequestForCreateCartWithUser: clientId  andPassword: password.
		
		self triggerEvent: #newShoppingCartCreated with: self.
		]
! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:35:07'!
noSelectedCartItemErrorDescription

	^'No selected cart'! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:35:27'!
noSelectedCatalogItemErrorDescription 

	^'No selected catalog item'! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:34:41'!
password

	^ password! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:34:47'!
password: newPassword

	password := newPassword! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 19:49:37'!
passwordText
	
	^password.! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 19:49:41'!
passwordText: aSentence
	
	password := aSentence.
	^true.! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:36:41'!
purchaseHistoryList

	^ purchaseHistoryList! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:36:37'!
purchaseHistoryListIndex

	^ 0! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:37:07'!
quantityToAdd
	
	^ quantityToAdd! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:37:03'!
quantityToAdd: newQuantity
	
	quantityToAdd := newQuantity.! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:50:41'!
removeFromCart

	self doSignalingError: [
		restInterface sendRequestForRemoveToCart: self selectedProductFromCart of: cartId .
			
		self listCartCart.
		]! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:34:54'!
selectedProductFromCart

	cartList isEmpty ifTrue: [ self error: self  emptyCardErrorDescription ].
	cartListIndex < 1 ifTrue: [ self error: self  noSelectedCartItemErrorDescription ].

	^ (cartList at: cartListIndex) at: 1! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:34:02'!
selectedProductFromCatalog

	catalogList isEmpty ifTrue: [ self error: self  emptyCatalogErrorDescription ].
	catalogListIndex < 1 ifTrue: [ self error: self  noSelectedCatalogItemErrorDescription ].

	^ (catalogList at: catalogListIndex) at: 1.! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:36:51'!
ticketList

	^ ticketList! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 14:36:47'!
ticketListIndex

	^ 0! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 19:49:45'!
userNameText
	
	^userName.! !

!TusLibrosClientWindowModel methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 19:49:48'!
userNameText: aSentence
	
	userName := aSentence.
	^true.! !


!classDefinition: #TusLibrosEncoder category: 'TusLibros-Model'!
Object subclass: #TusLibrosEncoder
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosEncoder class' category: 'TusLibros-Model'!
TusLibrosEncoder class
	instanceVariableNames: ''!

!TusLibrosEncoder class methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:16:42'!
mapPurchasesDetailToResponse: aPurchasesDetail

	| items sortBlock |
	
	items := OrderedCollection new.
	aPurchasesDetail itemsAndQuantitiesDo: [ :itemAndQuantity |
		items add: (Dictionary
			with: ('item'->itemAndQuantity key)
			with: ('quantity'->itemAndQuantity value)) ].
		
	sortBlock := [ :element1 :element2 | (element1 at: 'item') <= (element2 at: 'item')].

	^ Dictionary with: ('items'->(items asSortedCollection: sortBlock) asArray) with: ('total'->aPurchasesDetail total).! !

!TusLibrosEncoder class methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:17:24'!
mapTicketToResponse: aTicket
	
	| response |
	
	response := OrderedCollection new.
	
	aTicket lineItemsDo: [ :lineItem |
		response add: (Dictionary
			with: ('item'->lineItem item)
			with: ('quantity'->lineItem quantityText )
			with: ('total'->lineItem total))
		].
		
	^ response asArray! !


!classDefinition: #TusLibrosInterface category: 'TusLibros-Model'!
Object subclass: #TusLibrosInterface
	instanceVariableNames: 'port'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:33:51'!
correctlyEncodeSpacesForUrlRequestParameter: aParameter
	
	^ aParameter copyReplaceAll: ' ' with: '%20'! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:34:03'!
errorMessageFromHtml: htmlText

	| textSeparatedByParagraphs |
	
	textSeparatedByParagraphs := htmlText findBetweenSubStrs: {'<p>'. '</p>'}.
	textSeparatedByParagraphs size > 1 
		ifTrue: [^ textSeparatedByParagraphs at: 2]
		ifFalse: [^ htmlText ]! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:34:08'!
handleJsonResponse: response

	response isSuccess 
		ifTrue:[ ^WebUtils jsonDecode: ((response content) readStream). ] 
		ifFalse:[ ^self error: (self errorMessageFromHtml: response content) ]! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:34:16'!
handleTextResponse: response

	response isSuccess 
		ifTrue:[ ^ (response content) readStream. ] 
		ifFalse:[ ^self error: (self errorMessageFromHtml: response content) ]! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:31:30'!
initialize

	port := 8080! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 19:47:32'!
messageTextError: aMessageText

	^ aMessageText copyFrom: 87 to: (aMessageText size - 19) .
	! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:31:35'!
port

	^port.! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:36:01'!
sendListPurchasesRequestFor: aClientId authenticatedWith: aPassword

	| fieldDict response urlEncodedClientId urlEncodedPassword |

	urlEncodedClientId := self 
		correctlyEncodeSpacesForUrlRequestParameter: aClientId.	
	urlEncodedPassword := self
		correctlyEncodeSpacesForUrlRequestParameter: aPassword.
	fieldDict := Dictionary 
		with: ('clientId'->urlEncodedClientId)
		with: ('password'->urlEncodedPassword).
	
	response := WebClient htmlSubmit: (self url,'/listPurchases') fields: fieldDict.
	
	^ self handleJsonResponse: response.! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 19:55:49'!
sendRequesFor: anEndpoint with: fields 
	
	| response |
	response _ WebClient htmlSubmit: (self url,anEndpoint) fields: fields .
	
	response isSuccess 
		ifTrue:[^(WebUtils jsonDecode: ((response content) readStream))] 
		ifFalse:[^self error: response content].! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 12:45:31'!
sendRequesForListCart: aCartId 
	
	| fieldDict response |

	fieldDict := Dictionary with: ('cartId'->aCartId ).

	response := WebClient htmlSubmit: (self url,'/listCart') fields: fieldDict.
	
	^ self handleJsonResponse: response.! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:33:34'!
sendRequestForAddToCart: aCartId of: anISBN with: aQuantity
	
	| fieldDict response  urlEncodedProduct |

	urlEncodedProduct := self
		correctlyEncodeSpacesForUrlRequestParameter: anISBN.
	fieldDict := Dictionary 
		with: ('quantity'->aQuantity asString)
		with: ('product'->urlEncodedProduct)
		with: ('cartId'->aCartId asString).
	
	response := WebClient htmlSubmit: (self url,'/addToCart') fields: fieldDict method: 'POST'.
	
	self handleTextResponse: response! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/27/2021 17:58:50'!
sendRequestForCatalog
	
	| fields |
	
	fields _ Dictionary new.
	
	^ self sendRequesFor: '/catalog' with: fields.! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 12:44:34'!
sendRequestForCheckoutToCart: aCartId   
	
	| fieldDict response |

	fieldDict := Dictionary with: ('cartId'->aCartId ).

	response := WebClient htmlSubmit: (self url,'/checkOutCart') fields: fieldDict.
	
	^ self handleJsonResponse: response.! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:35:18'!
sendRequestForCreateCartWithUser: anUser andPassword: aPassword
	
	| fieldDict response urlEncodedClientId urlEncodedPassword |

	urlEncodedClientId := self 
		correctlyEncodeSpacesForUrlRequestParameter: anUser.	
	urlEncodedPassword := self
		correctlyEncodeSpacesForUrlRequestParameter: aPassword.
	fieldDict := Dictionary 
		with: ('clientId'->urlEncodedClientId)
		with: ('password'->urlEncodedPassword).
	
	response := WebClient htmlSubmit: (self url,'/createCart') fields: fieldDict method: 'POST'.
	
	^ self handleJsonResponse: response.! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 12:45:59'!
sendRequestForListCatalog

	| response |
	
	response := WebClient htmlSubmit: (self url,'/listCatalog') fields: Dictionary new.
	
	^ self handleJsonResponse: response.! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 12:47:10'!
sendRequestForListPurchases: anUserName with: aPassword 

	| fieldDict response urlEncodedClientId urlEncodedPassword |

	urlEncodedClientId := self 
		correctlyEncodeSpacesForUrlRequestParameter: anUserName.	
	urlEncodedPassword := self
		correctlyEncodeSpacesForUrlRequestParameter: aPassword.
	fieldDict := Dictionary 
		with: ('clientId'->urlEncodedClientId)
		with: ('password'->urlEncodedPassword).
	
	response := WebClient htmlSubmit: (self url,'/listPurchases') fields: fieldDict.
	
	^ self handleJsonResponse: response.! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 12:47:33'!
sendRequestForRemoveToCart: aCartId of: anISBN
	
	| fieldDict response urlEncodedProduct urlEncodedCartId |

	urlEncodedProduct := self
		correctlyEncodeSpacesForUrlRequestParameter: anISBN .
	urlEncodedCartId := aCartId asString.
	
	fieldDict := Dictionary 
		with: ('product'->urlEncodedProduct)
		with: ('cartId'->urlEncodedCartId).
	
	response := WebClient htmlSubmit: (self url,'/removeFromCart') fields: fieldDict method: 'POST'.
	
	self handleTextResponse: response! !

!TusLibrosInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/27/2021 17:39:45'!
url 

	^'http://localhost:', self port asString! !


!classDefinition: #TusLibrosRestInterface category: 'TusLibros-Model'!
Object subclass: #TusLibrosRestInterface
	instanceVariableNames: 'tusLibrosFacade server port authenticationSystem'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:23:04'!
addToCart: aRequest

	self handle: aRequest with: [	 | product quantity cartId |	
		
		cartId := self getParameter: 'cartId' from: aRequest.
		product := self getParameter:  'product' from: aRequest.
		quantity := self getParameter: 'quantity' from: aRequest. 
		
		tusLibrosFacade 
			add: quantity asNumber
			of: product
			toCartIdentifiedAs: cartId asNumber.
		
		aRequest send200Response: 'OK'
	]! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:23:59'!
checkoutCart: aRequest

	self handle: aRequest with: [	 | cartId ticket response |	
		
		cartId := self getParameter: 'cartId' from: aRequest.
		
		ticket := tusLibrosFacade checkoutCart: cartId asNumber.
			.
		response := TusLibrosEncoder mapTicketToResponse: ticket.
		
		aRequest send200Response: (WebUtils jsonEncode: response).
	]! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:26:19'!
createCart: aRequest

	self handle: aRequest with: [	 | cartId clientId password |
	
		clientId := self getParameter: 'clientId' from: aRequest.
		password := self getParameter: 'password' from: aRequest.

		cartId := tusLibrosFacade createCartFor: clientId authenticatedWith: password.

		aRequest send200Response: cartId asString
		]! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:25:12'!
createCatalog

	^ Dictionary new
		at: 'Smalltalk' put: 5;
		at: 'Harry Potter' put: 10;
		at: 'C++' put: 100;
		yourself! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 16:25:04'!
createValidUsersAndClientInformation

	|  hernan pepe today notExpiredCreditCard 
	hernanInfo expiredCreditCard pepeInfo julio notExpiredWithoutFundsCreditCard julioInfo |
	
	hernan := 'Hernan'.
	pepe := 'Pepe'.
	julio := 'Julio'.
	
	today := DateAndTime now.

	notExpiredCreditCard := CreditCard 
		withNumber: 1111222211112222
		of: hernan 
		expiringOn: (Month month: today monthIndex year: today yearNumber + 1).
	hernanInfo := ClientInformation 
		for: hernan 
		authenticatedWith: '1' 
		payingWith: notExpiredCreditCard.
		
	expiredCreditCard := CreditCard 
		withNumber: 8888222288882222
		of: pepe 
		expiringOn: (Month month: today monthIndex year: today yearNumber - 1).
	pepeInfo := ClientInformation 
		for: pepe 
		authenticatedWith: '1' 
		payingWith:  expiredCreditCard.
		
	notExpiredWithoutFundsCreditCard := CreditCard 
		withNumber: MerchantProcessorForInterface creditCardNumberWithoutFunds
		of: julio 
		expiringOn: (Month month: today monthIndex year: today yearNumber + 1).
	julioInfo := ClientInformation 
		for: julio
		authenticatedWith: '1' 
		payingWith:  notExpiredWithoutFundsCreditCard.
		
	^ Dictionary new
		at: hernan put: hernanInfo;
		at: pepe put: pepeInfo;
		at: julio put: julioInfo;
		yourself! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 22:40:15'!
destroy
	
	server ifNotNil:[server destroy].! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:21:39'!
getParameter: aParameter from: aRequest

	^ aRequest fields at: aParameter ifAbsent: [ self error: self missingParameterErrorMessage ]! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:19:39'!
handle: request with: aBlock
		
	[aBlock value]
	on: Error
	do: [ :anError |
		request send400Response: (anError messageText) ]! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:58:19'!
initializeWith: aPortNumber

	tusLibrosFacade _ TusLibrosSystemFacade new createFacade.
	
	port := aPortNumber .
	
	server _ WebServer new listenOn: self port.
	
	server addService: '/createCart' action: [:request | self createCart: request ].
	server addService: '/addToCart' action: [:request | self addToCart: request].
	server addService: '/listCart' action: [:request | self listCart: request].
	server addService: '/checkoutCart' action: [:request | self checkoutCart: request].
	server addService: '/listPurchases' action: [:request | self listPurchases: request].
	server addService: '/removeToCart' action: [:request | self removeToCart: request].	
	server addService: '/catalog' action: [:request | self listCatalog: request].
	! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 12:51:13'!
listCart: aRequest

	self handle: aRequest with: [	 | catalog response |	
		
		catalog := tusLibrosFacade catalog.
		
		response := String streamContents:[ :s| WebUtils jsonMap: catalog on: s].
		
		aRequest send200Response: response.
	]! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 15:23:01'!
listCatalog: request

	self handle: request with: [	 | catalog response |	
		
		catalog := tusLibrosFacade catalog .
		
		response := String streamContents:[ :s| WebUtils jsonMap: catalog on: s].
		
		request send200Response: response.
	]! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 12:52:14'!
listPurchases: aRequest

	self handle: aRequest with: [	 | clientId password purchases response |	
		
		clientId := self getParameter: 'clientId' from: aRequest.
		password := self getParameter: 'password' from: aRequest.
		
		purchases := aRequest listPurchasesOf: clientId authenticatingWith: password.
		
		response := TusLibrosEncoder mapPurchasesDetailToResponse: purchases.
		
		aRequest send200Response: (WebUtils jsonEncode: response).
	]! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:08:02'!
merchantProcessor

	^ MerchantProcessorForInterface new.! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:21:50'!
missingParameterErrorMessage 
	
	^'Missing parameter'! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 12:49:39'!
port
	
	^port! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/29/2021 12:52:58'!
removeToCart: aRequest

	self handle: aRequest with: [	 | product cartId |	
		
		cartId := self getParameter: 'cartId' from: aRequest.
		product := self getParameter: 'product' from: aRequest.
		
		tusLibrosFacade 		 remove: product toCartIdentifiedAs: cartId asNumber.
		
		aRequest send200Response: 'OK'
	]! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 19:45:45'!
toEnconde: aTicket

	| ticketToEncode |
	
	ticketToEncode _ Dictionary new.
	aTicket lineItemsDo:[:anItem | ticketToEncode at: anItem item put: anItem total asString].
	ticketToEncode at: 'Total' put: aTicket total asString.
	
	^ ticketToEncode ! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:07:52'!
usersAndCreditCards
	
	| notExpiredDate |
	
	notExpiredDate _ StoreTestObjectsFactory new yourself; notExpiredMonthOfYear.
	
	^ Dictionary new
		at: 'validUser1' put: (CreditCard expiringOn: notExpiredDate );
		at: 'validUser2' put: (CreditCard expiringOn: notExpiredDate);
		yourself .
		! !

!TusLibrosRestInterface methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:07:11'!
validUsersAndPasswords

	^ Dictionary new
		at: 'jose' put: 'password1';
		at: 'ciro' put: 'password2';
		yourself .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosRestInterface class' category: 'TusLibros-Model'!
TusLibrosRestInterface class
	instanceVariableNames: ''!

!TusLibrosRestInterface class methodsFor: 'as yet unclassified' stamp: 'MS 11/28/2021 23:01:13'!
startIn: aPortNumber

	^self new initializeWith: aPortNumber 
	! !


!classDefinition: #TusLibrosSystemFacade category: 'TusLibros-Model'!
Object subclass: #TusLibrosSystemFacade
	instanceVariableNames: 'validUsersAndPasswords catalog lastId merchantProcessor salesBook clock cartSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros-Model'!

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:24'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 11:17'!
cartCanNotBeEmptyErrorMessage

	^Cashier cartCanNotBeEmptyErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:27'!
invalidCartIdErrorDescription

	^'Invalid cart id'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:59'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage ! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/21/2013 23:03'!
invalidUserAndOrPasswordErrorDescription

	^'Invalid user and/or password'! !

!TusLibrosSystemFacade methodsFor: 'error messages' stamp: 'HernanWilkinson 6/22/2013 13:07'!
sessionHasExpiredErrorDescription

	^'Can not use the cart after ', self sessionDuration minutes printString , ' minutes of inactivity'! !


!TusLibrosSystemFacade methodsFor: 'time' stamp: 'MS 11/29/2021 13:06:03'!
createFacade
	
	^ TusLibrosSystemFacade
		authenticatingWith: self createValidUsersAndClientInformation
		acceptingItemsOf: self createCatalog 
		registeringOn: OrderedCollection new
		debitingThrought: MerchantProcessorForInterface new
		measuringTimeWith: Clock new.! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'MS 11/29/2021 16:16:12'!
createValidUsersAndClientInformation

	|  hernan pepe today notExpiredCreditCard 
	hernanInfo expiredCreditCard pepeInfo julio notExpiredWithoutFundsCreditCard julioInfo |
	
	hernan := 'Hernan'.
	pepe := 'Pepe'.
	julio := 'Julio'.
	
	today := DateAndTime now.

	notExpiredCreditCard := CreditCard 
		withNumber: 1111222211112222
		of: hernan 
		expiringOn: (Month month: today monthIndex year: today yearNumber + 1).
	hernanInfo := ClientInformation 
		for: hernan 
		authenticatedWith: '1' 
		payingWith: notExpiredCreditCard.
		
	expiredCreditCard := CreditCard 
		withNumber: 8888222288882222
		of: pepe 
		expiringOn: (Month month: today monthIndex year: today yearNumber - 1).
	pepeInfo := ClientInformation 
		for: pepe 
		authenticatedWith: '1' 
		payingWith:  expiredCreditCard.
		
	notExpiredWithoutFundsCreditCard := CreditCard 
		withNumber: MerchantProcessorForInterface creditCardNumberWithoutFunds
		of: julio 
		expiringOn: (Month month: today monthIndex year: today yearNumber + 1).
	julioInfo := ClientInformation 
		for: julio
		authenticatedWith: '1' 
		payingWith:  notExpiredWithoutFundsCreditCard.
		
	^ Dictionary new
		at: hernan put: hernanInfo;
		at: pepe put: pepeInfo;
		at: julio put: julioInfo;
		yourself! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 13:02'!
now

	^clock now! !

!TusLibrosSystemFacade methodsFor: 'time' stamp: 'HernanWilkinson 6/22/2013 12:49'!
today

	^clock today! !


!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
does: aUser authenticatesWith: aPassword

	"Recordar que esto es solo un ejemplo. No se deben guardar passwords en un sistema de verdad sino un
	hash o similar - Hernan"

	| storedPassword |

	storedPassword := validUsersAndPasswords at: aUser ifAbsent: [ ^false ].
	^aPassword = storedPassword ! !

!TusLibrosSystemFacade methodsFor: 'authentication' stamp: 'HernanWilkinson 6/23/2013 12:18'!
if: aUser authenticatesWith: aPassword do: aBlock

	^ (self does: aUser authenticatesWith: aPassword)
		ifTrue: aBlock
		ifFalse: [ self signalInvalidUserAndOrPassword ].
	! !


!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:27'!
signalInvalidCartId

	self error: self invalidCartIdErrorDescription ! !

!TusLibrosSystemFacade methodsFor: 'error signal' stamp: 'HernanWilkinson 6/21/2013 23:02'!
signalInvalidUserAndOrPassword

	self error: self invalidUserAndOrPasswordErrorDescription! !


!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/21/2013 23:32'!
generateCartId

	"Recuerden que esto es un ejemplo, por lo que voy a generar ids numericos consecutivos, pero en una
	implementacion real no deberian se numeros consecutivos ni nada que genere problemas de seguridad - Hernan"

	lastId := lastId + 1.
	^lastId! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'MS 11/28/2021 19:45:27'!
remove: aBook toCartIdentifiedAs: aCartId
	
	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession removeToCart: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/22/2013 13:02'!
sessionDuration

	^30 minutes! !

!TusLibrosSystemFacade methodsFor: 'cart session management' stamp: 'HernanWilkinson 6/17/2015 20:50'!
withCartSessionIdentifiedAs: aCartId do: aBlock

	| cartSession |

	cartSession := cartSessions at: aCartId ifAbsent: [self signalInvalidCartId ].
	^cartSession do: aBlock
! !


!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:18:41'!
add: anAmount of: aBook toCartIdentifiedAs: aCartId

	self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession addToCart: anAmount of: aBook ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:47'!
checkOutCartIdentifiedAs: aCartId withCreditCardNumbered: aCreditCartNumber ownedBy: anOwner expiringOn: anExpirationMonthOfYear

	self
		withCartSessionIdentifiedAs: aCartId
		do: [ :cartSession | cartSession
			checkOutCartWithCreditCardNumbered: aCreditCartNumber
			ownedBy: anOwner
			expiringOn: anExpirationMonthOfYear ]
! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:52'!
createCartFor: aUser authenticatedWith: aPassword

	^ self if: aUser authenticatesWith: aPassword do: [ | cartId cartSession |

		cartId := self generateCartId.
		cartSession := CartSession ownedBy: aUser with: (Cart acceptingItemsOf: catalog) on: self..
		cartSessions at: cartId put: cartSession.

		cartId  ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'MS 11/29/2021 16:15:07'!
createCatalog

	^ Dictionary new
		at: 'Smalltalk' put: 5;
		at: 'Harry Potter' put: 10;
		at: 'C++' put: 100;
		yourself! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HernanWilkinson 6/17/2015 20:48'!
listCartIdentifiedAs: aCartId

	^ self withCartSessionIdentifiedAs: aCartId do: [ :cartSession | cartSession cartContent ]! !

!TusLibrosSystemFacade methodsFor: 'facade protocol' stamp: 'HAW 11/26/2018 20:33:49'!
listPurchasesOf: aUser authenticatingWith: aPassword

	^self if: aUser authenticatesWith: aPassword do: [ | sales |
		sales := self salesDoneBy: aUser.
		sales
			inject: Dictionary new
			into: [ :salesOrderedByBook :aSale |
				self list: aSale on: salesOrderedByBook.
				salesOrderedByBook ] ]! !


!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:49'!
merchantProcessor

	^ merchantProcessor! !

!TusLibrosSystemFacade methodsFor: 'checkout support' stamp: 'HernanWilkinson 6/17/2015 20:50'!
salesBook

	^ salesBook! !


!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:56'!
list: aSale on: salesOrderedByBook

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	aSale lineItemsDo: [ :aLineItem | | oldTotal newTotal |
		oldTotal := salesOrderedByBook at: aLineItem item ifAbsentPut: [ 0 ].
		newTotal := oldTotal + aLineItem total.
		salesOrderedByBook at: aLineItem item put: newTotal ]! !

!TusLibrosSystemFacade methodsFor: 'private' stamp: 'HernanWilkinson 6/17/2015 20:55'!
salesDoneBy: aUser

	"Esto es un indicio de que por ahi conviene empezar a pensar en modelar un SaleBook - Hernan"
	^ salesBook select: [ :aSale | aSale wasDoneBy: aUser ]! !


!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'MS 11/29/2021 12:51:28'!
catalog

	^catalog copy! !

!TusLibrosSystemFacade methodsFor: 'initialization' stamp: 'HernanWilkinson 6/22/2013 14:17'!
initializeAuthenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	validUsersAndPasswords := aValidUsersAndPasswords.
	catalog := aCatalog.
	salesBook := aSalesBook.
	merchantProcessor := aMerchantProcessor.
	clock := aClock.

	cartSessions := Dictionary new.
	lastId := 0.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TusLibrosSystemFacade class' category: 'TusLibros-Model'!
TusLibrosSystemFacade class
	instanceVariableNames: ''!

!TusLibrosSystemFacade class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/22/2013 14:17'!
authenticatingWith: aValidUsersAndPasswords
	acceptingItemsOf: aCatalog
	registeringOn: aSalesBook
	debitingThrought: aMerchantProcessor
	measuringTimeWith: aClock

	^self new
		initializeAuthenticatingWith: aValidUsersAndPasswords
		acceptingItemsOf: aCatalog
		registeringOn: aSalesBook
		debitingThrought: aMerchantProcessor
		measuringTimeWith: aClock! !
