namespace hidden

universe u

inductive list (α : Type u) : Type u
| nil {} : list
| cons  (h : α) (t : list) : list

end hidden

#print list