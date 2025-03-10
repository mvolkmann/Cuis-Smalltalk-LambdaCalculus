'From Cuis7.3 [latest update: #7066] on 10 March 2025 at 4:27:18 pm'!
'Description '!
!provides: 'LambdaCalculus' 1 38!
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

!LC class methodsFor: 'as yet unclassified' stamp: 'RMV 3/10/2025 15:27:42'!
church: aWholeNumber	
	^ [:f | [:x |
		| result |
		result := x.
		aWholeNumber timesRepeat: [
			result := f value: result
		].
		result
	]]! !

!LC class methodsFor: 'as yet unclassified' stamp: 'RMV 3/10/2025 16:09:14'!
initialize
	| add false_ fst iszero mul pair phi pred snd succ true_  zero one |

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
	
	zero := self church: 0.
	one := self church: 1.
	Blocks at: #zero put: zero.
	Blocks at: #one put: one.
	Blocks at: #two put: (self church: 2).
	Blocks at: #three put: (self church: 3).
	Blocks at: #four put: (self church: 4).
	Blocks at: #five put: (self church: 5).
	Blocks at: #six put: (self church: 6).
	Blocks at: #twelve put: (self church: 12).
	
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
	
	add := [:m | [:n | m value: succ :: value: n]].
	Blocks at: #add put: add.
	Blocks at: #sub put: [:m | [:n | n value: pred :: value: m]].
	mul := [:m | [:n | m value: (add value: n) :: value: zero]].
	Blocks at: #mul put: mul.
	Blocks at: #exp put: [:m | [:n | n value: (mul value: m) :: value: one]].
	
	Blocks at: #compose put: [:f | [:g | [:x | f value: (g value: x) ]]].
	
	iszero := [:n | n value: [:x | false_] :: value: true_].
	Blocks at: #iszero put: iszero
! !

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

!LCTests methodsFor: 'testing' stamp: 'RMV 3/10/2025 16:07:14'!
testCompose
	| zero one two three six compose num |
	
	num := LC block: #num.
	compose := LC block: #compose.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.
	three := LC block: #three.
	six := LC block: #six.

	self assert: (num value: (compose value: zero :: value: zero)) equals: 0.
	self assert: (num value: (compose value: zero :: value: one)) equals: 0.
	self assert: (num value: (compose value: one :: value: zero)) equals: 0.
	self assert: (num value: (compose value: one :: value: two)) equals: 2.
	self assert: (num value: (compose value: two :: value: one)) equals: 2.
	self assert: (num value: (compose value: two :: value: three)) equals: 6.! !

!LCTests methodsFor: 'testing' stamp: 'RMV 3/10/2025 16:27:12'!
testExp
	| zero one two three exp num |
	
	num := LC block: #num.
	exp := LC block: #exp.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.
	three := LC block: #three.


	self assert: (num value: (exp value: zero :: value: zero)) equals: 1.
	self assert: (num value: (exp value: zero :: value: one)) equals: 0.
	self assert: (num value: (exp value: one :: value: zero)) equals: 1.
	self assert: (num value: (exp value: two :: value: three)) equals: 8.
	! !

!LCTests methodsFor: 'testing' stamp: 'RMV 3/10/2025 16:11:34'!
testIsZero
	| zero one two three bool iszero |
	
	bool := LC block: #bool.
	iszero := LC block: #iszero.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.
	three := LC block: #three.

	self assert: (bool value: (iszero value: zero)).
	self assert: (bool value: (iszero value: one)) not.
	self assert: (bool value: (iszero value: two)) not.! !

!LCTests methodsFor: 'testing' stamp: 'RMV 3/10/2025 16:26:07'!
testMul
	| zero one two three four mul num twelve |
	
	num := LC block: #num.
	mul := LC block: #mul.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.
	three := LC block: #three.
	four := LC block: #four.
	twelve := LC block: #twelve.

	self assert: (num value: (mul value: zero :: value: zero)) equals: 0.
	self assert: (num value: (mul value: zero :: value: one)) equals: 0.
	self assert: (num value: (mul value: one :: value: zero)) equals: 0.
	self assert: (num value: (mul value: one :: value: two)) equals: 2.
	self assert: (num value: (mul value: two :: value: one)) equals: 2.
	self assert: (num value: (mul value: four :: value: three)) equals: 12.
	! !

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

!LCTests methodsFor: 'testing' stamp: 'RMV 3/10/2025 16:20:42'!
testPair
	| zero one two fst myPair num pair snd |
	
	num := LC block: #num.
	fst := LC block: #fst.
	pair := LC block: #pair.
	snd := LC block: #snd.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.
	
	myPair := pair value: zero :: value: zero.
	self assert: (num value: (fst value: myPair)) equals: 0.
	self assert: (num value: (snd value: myPair)) equals: 0.

	myPair := pair value: one :: value: two.
	self assert: (num value: (fst value: myPair)) equals: 1.
	self assert: (num value: (snd value: myPair)) equals: 2.! !

!LCTests methodsFor: 'testing' stamp: 'RMV 3/10/2025 16:23:48'!
testPhi
	| zero one two fst num p pair phi snd |
	
	num := LC block: #num.
	fst := LC block: #fst.
	pair := LC block: #pair.
	phi := LC block: #phi.
	snd := LC block: #snd.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.
	
	p := pair value: zero :: value: zero.
	
	p := phi value: p.
	self assert: (num value: (fst value: p)) equals: 0.
	self assert: (num value: (snd value: p)) equals: 1.
	
	p := phi value: p.
	self assert: (num value: (fst value: p)) equals: 1.
	self assert: (num value: (snd value: p)) equals: 2.
	
	p := phi value: p.
	self assert: (num value: (fst value: p)) equals: 2.
	self assert: (num value: (snd value: p)) equals: 3.! !

!LCTests methodsFor: 'testing' stamp: 'RMV 3/10/2025 16:15:43'!
testPred
	| zero one two three num pred |
	
	num := LC block: #num.
	pred := LC block: #pred.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.
	three := LC block: #three.

	self assert: (num value: (pred value: zero)) equals: 0.
	self assert: (num value: (pred value: one)) equals: 0.
	self assert: (num value: (pred value: two)) equals: 1.
	self assert: (num value: (pred value: three)) equals: 2.
! !

!LCTests methodsFor: 'testing' stamp: 'RMV 3/10/2025 16:25:27'!
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
	self assert: (num value: (sub value: one :: value: three)) equals: 0. "no negative numbers"
	! !

!LCTests methodsFor: 'testing' stamp: 'RMV 3/10/2025 16:14:40'!
testSucc
	| zero one two num succ |
	
	num := LC block: #num.
	succ := LC block: #succ.
	zero := LC block: #zero.
	one := LC block: #one.
	two := LC block: #two.

	self assert: (num value: (succ value: zero)) equals: 1.
	self assert: (num value: (succ value: one)) equals: 2.
	self assert: (num value: (succ value: two)) equals: 3.
! !
LC initialize!
