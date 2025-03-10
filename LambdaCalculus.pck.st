'From Cuis7.3 [latest update: #7036] on 10 March 2025 at 10:18:44 am'!
'Description '!
!provides: 'LambdaCalculus' 1 5!
SystemOrganization addCategory: #LambdaCalculus!


!classDefinition: #LC category: #LambdaCalculus!
Object subclass: #LC
	instanceVariableNames: ''
	classVariableNames: 'Blocks'
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


!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 09:16:25'!
True_
	^ True_! !

!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 09:29:39'!
block: aSymbol
	
	^ Blocks at: aSymbol! !

!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 10:14:04'!
initialize
	| false_ true_ |

	Blocks := Dictionary new.
	
	true_ := [:x | [:y | x]].
	false_ := [:x | [:y | y]].
	Blocks at: #true put: true_.
	Blocks at: #false put: false_.
	Blocks at: #not put:​ [:b | b value: false_ :: value: true_].
	Blocks at: #and put:​ [:x | [:y | x value: y :: value: false_]].	
	Blocks at: #or put:​ [:x | [:y | x value: true_ :: value: y]].
	Blocks at: #bool put:​ [:b | b value: true :: value: false].
	Blocks at: #num put:​ [:n | n value: [:x | x + 1] :: value: 0].
	
	Blocks at: #zero put: [:f | [:x | x]].
	Blocks at: #one put: [:f | [:x | f value: x]].
	Blocks at: #two put: [:f | [:x | f value: (f value: x)]].
	Blocks at: #three put: [:f | [:x | f value: (f value: (f value: x))]].
	Blocks at: #four put: [:f | [:x | f value: (f value: (f value: (f value: x)))]].
	Blocks at: #five put: [:f | [:x | f value: (f value: (f value: (f value: (f value: x))))]].
	Blocks at: #six put: [:f | [:x | f value: (f value: (f value: (f value: (f value: (f value: x)))))]].
	Blocks at: #succ put: [:n | [:f | [:x | f value: n value: f :: value: x]]].
		
	! !

!LCTests methodsFor: 'testing' stamp: 'rmv 3/10/2025 10:16:08'!
testAnd
	| and bool false_ true_ |
	
	and := LC block: #and.
	bool := LC block: #bool.
	false_ := LC block: #false.
	true_ := LC block: #true.

	self assert: (bool value: (and value: true_ :: value: true_)) equals: true.
	self assert: (bool value: (and value: true_ :: value: false_)) equals: false.
	self assert: (bool value: (and value: false_ :: value: true_)) equals: false.
	self assert: (bool value: (and value: false_ :: value: false_)) equals: false.! !

!LCTests methodsFor: 'testing' stamp: 'rmv 3/10/2025 10:16:53'!
testBool
	| bool false_ true_ |
	
	bool := LC block: #bool.
	false_ := LC block: #false.
	true_ := LC block: #true.

	self assert: (bool value: false_) equals: false.
	self assert: (bool value: true_) equals: true.
	
	self assert: (true_ value: 1 :: value: 2) equals: 1. "returns first value"
	self assert: (false_ value: 1 :: value: 2) equals: 2. "returns second value"	! !

!LCTests methodsFor: 'testing' stamp: 'rmv 3/10/2025 10:15:38'!
testNot
	| bool false_ not true_ |
	
	bool := LC block: #bool.
	false_ := LC block: #false.
	not := LC block: #not.
	true_ := LC block: #true.
	
	self assert: (bool value: (not value: true_)) equals: false.
	self assert: (bool value: (not value: false_)) equals: true.
! !

!LCTests methodsFor: 'testing' stamp: 'rmv 3/10/2025 10:17:43'!
testNum
	| num zero |
	
	num := LC block: #num.
	zero := LC block: #zero.

	self assert: (num value: zero) equals: 0.! !

!LCTests methodsFor: 'testing' stamp: 'rmv 3/10/2025 10:16:33'!
testOr
	| bool false_ or true_ |
	
	bool := LC block: #bool.
	false_ := LC block: #false.
	or := LC block: #or.
	true_ := LC block: #true.

	self assert: (bool value: (or value: true_ :: value: true_)) equals: true.
	self assert: (bool value: (or value: true_ :: value: false_)) equals: true.
	self assert: (bool value: (or value: false_ :: value: true_)) equals: true.
	self assert: (bool value: (or value: false_ :: value: false_)) equals: false.
	! !
LC initialize!
