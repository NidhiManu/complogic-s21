/-
The nat type in Lean is defined just as it
is in our nat.lean file, so we just use Lean's
definition here. For reference, here's Lean's
definition.

inductive nat : Type
| zero : nat
| succ : nat → nat 

That's it. To fully understand how this
definition produces a set of terms that
we can view interpret as representing
natural numbers, you need a few facts:

(1) Constructors are *disjoint*. This 
means that terms built using different
constructors are never equal.

(2) Constructors are *injective*. This
means that even if you use the same
contructor, as long as you provide
different argument values, you will
always get terms that are not equal.

(3) The values of a type include all
values obtainable by any finite number
of applications of its constructors.
-/

#print nat

/-
The key to writing functions that take nat
arguments is, as usual, case analysis. If
we're given a natural number (term of type
ℕ), n, we first determine which constructor
was used to create it (zero or succ), and if
it was succ, then what one-smaller nat value
succ was applied to to produce our argument.
-/

/-
Zero. Zero is the smallest natural number.
It is implemented by the zero constructor.
-/

#eval nat.zero

/-
Successor. The successor function takes a
nat and yields a one-bigger nat. It is
implemented by the succ constructor. This
constructor takes a term of type nat as 
an argument and constructs/returns a new
term with one additional "succ" at its
front.
-/

#eval nat.succ nat.zero

/-
Predecessor. Here we define a truncated
version of the predecessor function on
natural numbers, defined mathematically
by the following cases:
    pred 0 = 0,
    pred (n' + 1) = n'
-/

def pred : ℕ → ℕ
| nat.zero := nat.zero
| (nat.succ n') := n' 

#eval pred 0
#eval pred 1
#eval pred 5

/-
We can easily write a predicate function
that returns true iff its argument is 
zero.
-/
def isZero : ℕ → bool
| nat.zero := tt
| _ := ff 

/-
Because larger values of type nat are
constructed from smaller values of the
same type, many functions that consume
a nat argument will work by applying
themselves recursively to smaller values
of the same type.

Here's an easy example. We can define
a function, double, that takes a nat
argument and returns double its value,
recursively, like this:

double 0 = 0
double (1 + n') = 2 + double n'
-/

def double : ℕ → ℕ 
| nat.zero := 0   -- 0 is nat.zero     
| (nat.succ n') := 2 + double n'

/-
Weird detail: In this example, we 
take advantage of Lean's notations
for natural numbers. We can use the
usual numerals (0 instead of nat.zero
for example); and  Lean "de-sugars" 
(n'+ 1) to nat.succ n', but this 
trick doesn't work for 1 + n'.
-/

/-
Exercise. Implement the factorial
function on natural numbers, defined
by the following cases:
    fac 0 := 1
    fac (n' + 1) := fac (n' + 1) * fac n'
-/

-- Ans:

def fac : ℕ → ℕ 
| 0 := 1
| (nat.succ n') := (nat.succ n') * fac n'

/-
Exercise: Define the n'th Fibonacci
number by the following cases:
  fib 0 = 1
  fib 1 = 1
  fib (n' + 2) = fib (n' +1) + fib n'
-/

-- Ans, now using some Lean notations

def fib : ℕ → ℕ 
| 0 := 1
| 1 := 1
| (n' + 2) := fib (n' + 1) + fib n'

#eval fib 5

/- 
Exercise: On a piece of paper, draw
the complete computation tree for fib
5.

                  fib 5
                /      \
              fib 4   fib 3
            /     \    /\ ...
          fib 3   fib 2
        /     \    /\ ...
      fib 2  fib 1
     /     \  /\ ...
   fib 1  fib 0
    |       |
    1       1
-/

/-
Addition:

0         + m = m
(n' + 1)  + m = (n' + m) + 1

Be sure you understand that!
-/

def add : ℕ → ℕ → ℕ 
| 0        m :=   m 
| (n' + 1) m := 1 + (add n' m) 


/-
EXERCISE: write a mathematical
definition of multiplication of
n by m, then implement it, using
your add function if/as necessary
to carry out addition.
-/

def mult : ℕ → ℕ → ℕ 
| 0 m := 0
| (n' + 1) m := add m (mult n' m)

#eval mult 8 12
#eval mult 16 0

/-
EXERCISE: write a mathematical
definition of exponentiation and
implement it, using your definition
of multiplication if/as necessary.
-/

def exp : ℕ → ℕ → ℕ
| m 0 := 1
| m (n' + 1) := mult m (exp m n')

#eval exp 0 0
#eval exp 2 10
#eval exp 3 4
