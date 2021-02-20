import ..type_library.box

namespace hidden

-- concrete example
def map_box_nat_nat 
  (f : nat → nat)
  (b : box nat) :
  box nat :=
  _

-- almost the most general case

universes u₁ u₂

def map_box 
  {α : Type u₁} 
  {β : Type u₂}
  (f : α → β)
  (b : box α) :
  box β :=
box.mk (f b.val) 

-- exercise: make it work for logical types

/-
On the following two assumptions, 
what is the type of (map_box f b)?
-/
variables 
  (f : string → nat)
  (b : box string)


def nbox := 
map_box 
  (λ s, s+1)
  (box.mk 5)

#reduce nbox  -- expected result???

end hidden
