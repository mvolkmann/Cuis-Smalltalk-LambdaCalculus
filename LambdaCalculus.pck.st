'From Cuis7.3 [latest update: #7036] on 10 March 2025 at 1:16:49 pm'!
'Description '!
!provides: 'LambdaCalculus' 1 9!
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


!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 09:29:39'!
block: aSymbol
	
	^ Blocks at: aSymbol! !

!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 13:15:52'!
initialize
	| false_ fst pair phi snd succ true_  zero |

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
	
	zero := [:f | [:x | x]].
	Blocks at: #zero put: zero.
	Blocks at: #one put: [:f | [:x | f value: x]].
	Blocks at: #two put: [:f | [:x | f value: (f value: x)]].
	Blocks at: #three put: [:f | [:x | f value: (f value: (f value: x))]].
	Blocks at: #four put: [:f | [:x | f value: (f value: (f value: (f value: x)))]].
	Blocks at: #five put: [:f | [:x | f value: (f value: (f value: (f value: (f value: x))))]].
	Blocks at: #six put: [:f | [:x | f value: (f value: (f value: (f value: (f value: (f value: x)))))]].
	
	succ := [:n | [:f | [:x | f value: (n value: f :: value: x)]]].
	Blocks at: #succ put: succ.
	
	pair := [:x | [:y | [:f | f value: x :: value: y]]].
	fst := [:p | p value: true_].
	snd := [:p | p value: false_].
	phi := [:p | pair value: (snd value: p) :: value: (succ value: (snd value: p))].
	Blocks at: #pair put: pair.
	Blocks at: #fst put: fst.
	Blocks at: #snd put: snd.
	Blocks at: #phi put: phi.
	Blocks at: #pred put: [:n | fst value: (n value: phi :: value: (pair value: zero :: value: zero))].
	
	Blocks at: #add put: [:m | [:n | m value: succ :: value: n]].! !

!LCTests methodsFor: 'testing' stamp: 'rmv 3/10/2025 13:16:44'!
testAdd
	| zero one two three four five six add num |
	
	num := LC block: #num.
	add := LC block: #add.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.
	three := LC block: #three.
	four := LC block: #four.
	five := LC block: #five.
	six := LC block: #six.

	self assert: (num value: (add value: zero :: value: zero)) equals: 0.
	self assert: (num value: (add value: zero :: value: one)) equals: 1.
	self assert: (num value: (add value: one :: value: zero)) equals: 1.
	self assert: (num value: (add value: two :: value: three)) equals: 5.
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

!LCTests methodsFor: 'testing' stamp: 'rmv 3/10/2025 10:22:07'!
testNum
	| zero one two three four five six num |
	
	num := LC block: #num.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.
	three := LC block: #three.
	four := LC block: #four.
	five := LC block: #five.
	six := LC block: #six.

	self assert: (num value: zero) equals: 0.
	self assert: (num value: one) equals: 1.
	self assert: (num value: two) equals: 2.
	self assert: (num value: three) equals: 3.
	self assert: (num value: four) equals: 4.
	self assert: (num value: five) equals: 5.
	self assert: (num value: six) equals: 6.! !

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

!LCTests methodsFor: 'testing' stamp: 'rmv 3/10/2025 10:33:32'!
testPred
	| zero one two three four five six num pred |
	
	num := LC block: #num.
	pred := LC block: #pred.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.
	three := LC block: #three.
	four := LC block: #four.
	five := LC block: #five.
	six := LC block: #six.

	self assert: (num value: (pred value: one)) equals: 0.
	self assert: (num value: (pred value: six)) equals: 5.
! !

!LCTests methodsFor: 'testing' stamp: 'rmv 3/10/2025 10:24:24'!
testSucc
	| zero one two three four five six num succ |
	
	num := LC block: #num.
	succ := LC block: #succ.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.
	three := LC block: #three.
	four := LC block: #four.
	five := LC block: #five.
	six := LC block: #six.

	self assert: (num value: (succ value: zero)) equals: 1.
	self assert: (num value: (succ value: five)) equals: 6.
! !
LC initialize!
