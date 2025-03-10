'From Cuis7.3 [latest update: #7066] on 10 March 2025 at 3:09:10 pm'!
'Description '!
!provides: 'LambdaCalculus' 1 12!
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

!LC class methodsFor: 'as yet unclassified' stamp: 'RMV 3/10/2025 15:09:02'!
church: aWholeNumber
	| result |
	
	result := [:f | [:x | x]]. "zero"
	aWholeNumber timesRepeat: [
		result := [:f | [:x | f value: (result value: f :: value: x)]]
	].
	^ result.! !

!LC class methodsFor: 'as yet unclassified' stamp: 'rmv 3/10/2025 13:20:27'!
initialize
	| false_ fst pair phi pred snd succ true_  zero |

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
	pred := [:n | fst value: (n value: phi :: value: (pair value: zero :: value: zero))].
	Blocks at: #pair put: pair.
	Blocks at: #fst put: fst.
	Blocks at: #snd put: snd.
	Blocks at: #phi put: phi.
	Blocks at: #pred put: [:n | fst value: (n value: phi :: value: (pair value: zero :: value: zero))].
	
	Blocks at: #add put: [:m | [:n | m value: succ :: value: n]].
	Blocks at: #sub put: [:m | [:n | n value: pred :: value: m]].! !

!LCTests methodsFor: 'testing' stamp: 'rmv 3/10/2025 13:17:37'!
testAdd
	| zero one two three four five add num |
	
	num := LC block: #num.
	add := LC block: #add.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.
	three := LC block: #three.
	four := LC block: #four.
	five := LC block: #five.

	self assert: (num value: (add value: zero :: value: zero)) equals: 0.
	self assert: (num value: (add value: zero :: value: one)) equals: 1.
	self assert: (num value: (add value: one :: value: zero)) equals: 1.
	self assert: (num value: (add value: three :: value: two)) equals: 5.
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

!LCTests methodsFor: 'testing' stamp: 'rmv 3/10/2025 13:19:52'!
testSub
	| zero one two three four five num sub |
	
	num := LC block: #num.
	sub := LC block: #sub.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.
	three := LC block: #three.
	four := LC block: #four.
	five := LC block: #five.

	self assert: (num value: (sub value: zero :: value: zero)) equals: 0.
	self assert: (num value: (sub value: one :: value: zero)) equals: 1.
	self assert: (num value: (sub value: one :: value: one)) equals: 0.
	self assert: (num value: (sub value: five :: value: two)) equals: 3.
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
