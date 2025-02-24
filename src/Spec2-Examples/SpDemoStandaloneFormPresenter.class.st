"
The presenter that provides only the standalone form for the form demo
"
Class {
	#name : #SpDemoStandaloneFormPresenter,
	#superclass : #SpPresenterWithModel,
	#instVars : [
		'workingModel',
		'nameLabel',
		'nameTextInput',
		'surnameLabel',
		'surnameTextInput',
		'number1Label',
		'number1Input',
		'number2Label',
		'number2Input',
		'scaleLabel',
		'scaleInput',
		'passwordLabel',
		'passwordInput',
		'checkboxLabel',
		'checkboxInput',
		'dateLabel',
		'dateInput',
		'genderLabel',
		'genderButtons',
		'maleButton',
		'femaleButton',
		'itemsLabel',
		'itemsInput',
		'submitButton',
		'restoreButton'
	],
	#category : #'Spec2-Examples-Demo-Forms'
}

{ #category : #specs }
SpDemoStandaloneFormPresenter class >> defaultSpec [
	
	^ SpBoxLayout newTopToBottom
		add:
			(SpGridLayout build: [ :builder |
				builder
					add: 'Name:';
					add: #nameTextInput;
					nextRow;
					add: 'Surname:';
					add: #surnameTextInput;
					nextRow;
					add: 'Number 1:';
					add: #number1Input;
					nextRow;
					add: 'Number 2:';
					add: #number2Input;
					nextRow;
					add: 'Scale:';
					add: #scaleInput;
					nextRow;
					add: 'Password:';
					add: #passwordInput;
					nextRow;
					add: 'Remember me:';
					add: #checkboxInput;
					nextRow;
					"SpDatePresenter is exclusive from Morphic backend for the moment"
					"add: 'Date:';
					add: #dateInput;
					nextRow;"
					add: 'Gender:';
					add:
						(SpBoxLayout newLeftToRight
							add: #maleButton;
							add: #femaleButton;
							yourself) ]);
		add: (SpBoxLayout newLeftToRight
				add: #submitButton;
				add: #restoreButton;
				yourself)
			expand: false;
		yourself
]

{ #category : #'instance creation' }
SpDemoStandaloneFormPresenter class >> open [
	<example>
	(self on: SpDemoFormModel new) openWithSpec
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> checkboxInput [
	^ checkboxInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> checkboxInput: anObject [
	checkboxInput := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> checkboxLabel [
	^ checkboxLabel
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> checkboxLabel: anObject [
	checkboxLabel := anObject
]

{ #category : #initialization }
SpDemoStandaloneFormPresenter >> connectPresenters [
	self submitButton action: [ self submit ].
	self restoreButton action: [ self restore ]
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> dateInput [
	^ dateInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> dateInput: anObject [
	dateInput := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> dateLabel [
	^ dateLabel
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> dateLabel: anObject [
	dateLabel := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> femaleButton [
	^ femaleButton
]

{ #category : #'model updates' }
SpDemoStandaloneFormPresenter >> fillFormWithWorkingModel [
	| aModel |
	aModel := self workingModel.
	self nameTextInput text: aModel name.
	self surnameTextInput text: aModel surname.
	self number1Input text: aModel number1 asString.
	self number2Input text: aModel number2 asString.
	self scaleInput value: aModel scale.
	self passwordInput text: aModel password.
	self checkboxInput state: aModel rememberMe.
	"self dateInput date: aModel date."
	(genderButtons at: aModel gender) state: true.

	self itemsInput selectItems: self workingModel selectedItems
]

{ #category : #'model updates' }
SpDemoStandaloneFormPresenter >> fillModelWithFormContent [

	self workingModel
		name: self nameTextInput text;
		surname: self surnameTextInput text;
		number1: number1Input number;
		number2: number2Input number;
		scale: self scaleInput value;
		password: self passwordInput text;
		rememberMe: self checkboxInput state;
		date: self dateInput date.

	self workingModel gender: (genderButtons associations detect: [ :each | each value state ]) key.
	
	self workingModel selectedItems: self itemsInput selectedItems.

]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> genderLabel [
	^ genderLabel
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> genderLabel: anObject [
	genderLabel := anObject
]

{ #category : #initialization }
SpDemoStandaloneFormPresenter >> initializePresenters [
	nameLabel := self newLabel label: 'name:'.
	nameTextInput := self newTextInput.

	surnameLabel := self newLabel label: 'surname:'.
	surnameTextInput := self newTextInput.
	surnameTextInput placeholder: 'empty'.
	number1Label := self newLabel label: 'number 1:'.
	number1Input := self newNumberInput.

	number2Label := self newLabel label: 'number 2:'.
	number2Input := self newNumberInput
		beFloat;
		digits: 3;
		climbRate: 0.005;
		minimum: 10.005;
		maximum: 20.05.

	scaleLabel := self newLabel label: 'scale:'.
	scaleInput := self newSlider.

	passwordLabel := self newLabel label: 'password:'.
	passwordInput := self newTextInput bePassword.
	checkboxLabel := self newLabel label: 'remember me'.
	checkboxInput := self newCheckBox state: true.

	dateLabel := self newLabel label: 'date:'.
	dateInput := self instantiate: SpDatePresenter.
	dateInput display: [ :item | item yyyymmdd ].

	maleButton := self newRadioButton label: 'male'.
	femaleButton := self newRadioButton label: 'female'.
	maleButton associatedRadioButtons: {femaleButton}.
	genderButtons := Dictionary newFrom: {
		(#male -> maleButton). 
		(#female -> femaleButton)}.

	genderLabel := self newLabel label: 'gender:'.
	itemsLabel := self newLabel label: 'items:'.
	itemsInput := self newList.
	itemsInput beMultipleSelection.
	itemsInput items: self model items.

	submitButton := self newButton label: 'Submit'.
	restoreButton := self newButton label: 'Restore'
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> itemsInput [
	^ itemsInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> itemsInput: anObject [
	itemsInput := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> itemsLabel [
	^ itemsLabel
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> itemsLabel: anObject [
	itemsLabel := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> maleButton [
	^ maleButton
]

{ #category : #initialization }
SpDemoStandaloneFormPresenter >> modelChanged [

	workingModel := self model copy.

	self fillFormWithWorkingModel.

	
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> nameLabel [
	^ nameLabel
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> nameLabel: anObject [
	nameLabel := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> nameTextInput [
	^ nameTextInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> nameTextInput: anObject [
	nameTextInput := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> number1Input [
	^ number1Input
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> number1Input: anObject [
	number1Input := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> number1Label [
	^ number1Label
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> number1Label: anObject [
	number1Label := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> number2Input [
	^ number2Input
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> number2Input: anObject [
	number2Input := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> number2Label [
	^ number2Label
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> number2Label: anObject [
	number2Label := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> passwordInput [
	^ passwordInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> passwordInput: anObject [
	passwordInput := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> passwordLabel [
	^ passwordLabel
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> passwordLabel: anObject [
	passwordLabel := anObject
]

{ #category : #actions }
SpDemoStandaloneFormPresenter >> restore [

	self modelChanged

	
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> restoreButton [
	^ restoreButton
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> restoreButton: anObject [
	restoreButton := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> scaleInput [
	^ scaleInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> scaleInput: anObject [
	scaleInput := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> scaleLabel [
	^ scaleLabel
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> scaleLabel: anObject [
	scaleLabel := anObject
]

{ #category : #actions }
SpDemoStandaloneFormPresenter >> submit [

	self fillModelWithFormContent.
	
	self model: workingModel.
	self announcingObject valueChanged.
	
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> submitButton [
	^ submitButton
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> submitButton: anObject [
	submitButton := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> surnameLabel [
	^ surnameLabel
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> surnameLabel: anObject [
	surnameLabel := anObject
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> surnameTextInput [
	^ surnameTextInput
]

{ #category : #accessing }
SpDemoStandaloneFormPresenter >> surnameTextInput: anObject [
	surnameTextInput := anObject
]

{ #category : #'accessing - model' }
SpDemoStandaloneFormPresenter >> workingModel [
	^ workingModel
]

{ #category : #'accessing - model' }
SpDemoStandaloneFormPresenter >> workingModel: anObject [
	workingModel := anObject
]
