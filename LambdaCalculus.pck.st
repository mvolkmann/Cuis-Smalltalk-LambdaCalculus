'From Cuis7.3 [latest update: #7036] on 10 March 2025 at 9:26:00 am'!
'Description '!
!provides: 'LambdaCalculus' 1 2!
SystemOrganization addCategory: #LambdaCalculus!


!classDefinition: #LC category: #LambdaCalculus!
Object subclass: #LC
	instanceVariableNames: ''
	classVariableNames: 'And Bool False_ Not Num Or True_'
	poolDictionaries: ''
	category: 'LambdaCalculus'!
!classDefinition: 'LC class' category: #LambdaCalculus!
LC class
	instanceVariableNames: ''!

!classDefinition: #LCTests category: #LambdaCalculus!
TestCase subclass: #LCTests
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'LambdaCalculus'!
!classDefinition: 'LCTests class' category: #LambdaCalculus!
LCTests class
	instanceVariableNames: ''!


!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 09:16:35'!
And
	^ And! !

!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 09:15:55'!
Bool
	^ Bool! !

!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 09:16:30'!
False_
	^ False_! !

!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 09:16:48'!
Not
	^ Not! !

!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 09:16:54'!
Num
	^ Num! !

!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 09:16:39'!
Or
	^ Or! !

!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 09:16:25'!
True_
	^ True_! !

!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 09:13:39'!
initialize

	True_ := [:x | [:y | x]].
	False_ := [:x | [:y | y]].
	Not := [:b | b value: False_ :: value: True_].
	And := [:x | [:y | x value: y :: value: False_]].	
	Or := [:x | [:y | x value: True_ :: value: y]].
	Bool := [:b | b value: true :: value: false].
	Num := [:n | n value: [:x | x + 1] :: value: 0].! !

!LCTests methodsFor: 'testing' stamp: 'rmv 3/10/2025 09:25:15'!
testBool
	| bool f t |
	
	bool := LC Bool.
	f := LC False_.
	t := LC True_.

	self assert: (bool value: f) equals: false.
	self assert: (bool value: t) equals: true.! !
LC initialize!
