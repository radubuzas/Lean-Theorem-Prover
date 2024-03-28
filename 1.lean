-- Lean limbaj pt programarea functionala si un prover assistent

-- 2 comenzi principale: #eval, #check


#eval 1 + 1
#eval 7 * 5 + 12
#eval "Hello" ++ " world!"


-- definirea de functii simple
-- sa se def o functie care primeste un nr natural si returneaza n + 5

def plus5(n: Nat) : Nat := n + 5

def plus5' (n: Nat) := n + 5

#check plus5'

#eval plus5 10


def applyFunction (α β : Type) (a : α) (f : α -> β) : β := f a

#check applyFunction
#eval applyFunction Nat Bool 2 (fun x => x > 2)

def applyFunction' {α β : Type} (a : α) (f : α -> β) : β := f a
#check applyFunction'
#check applyFunction' 2
#eval applyFunction' 2 (fun x => x == 2)

def f: Nat -> Nat -> Nat := fun x y => x + y

#check @f
#check @f 2
#check @f 2 3

#eval f 2 3

-- avem functii map, filter, flodr
#check @List.map

#check @List.filter


-- putem defini structuri

structure Student where
  name: String
  group: Nat

#check Student.mk

def me : Student := Student.mk "Nume" 100
def me' : Student := {name := "Nume", group := 100}


def studentToString (s: Student ) : String :=
  s.name ++ " " ++ (toString s.group)

#eval studentToString me'

#check Option


def sub? : Nat -> Nat -> Option Nat :=
  fun x y =>
  if x < y then none else some (x - y)

#eval sub? 10 2

-- De construit multimea nr naturale SI sa facem cateva demonstratii

-- Aritmetica lui Peano/ Axiomatica lui Peano

-- Construim N inductiv

-- 0 : ℕ (0 este cstr al lui N)

-- succ : ℕ -> ℕ


inductive Natural
| zero : Natural
| succ : Natural -> Natural

#check @Natural.succ
#reduce Natural.succ $ Natural.succ $ Natural.zero


-- definitia adunarii

@[simp]
def Natural.add : Natural -> Natural -> Natural :=
  fun x y =>
  match x with
  | zero => y
  | succ x'=> succ $ Natural.add x' y


#check Natural.add._eq_1

--stim ca
--∀ y ∈ ℕ, 0 + y = y

-- vrem sa demonstram ca n_plus_0_eq_n(n) :
-- cum dem aceasta prop

--∀ n, n + 0 = n
-- pasul 0:0 + 0 = 0 (evident din P1)

--stim n + 0 = n

--vrem sa demonstram ca succ n + 0 = succ n

-- succ n + 0 = succ (n + 0) -- aplicand P2 x' = n
--            = succ n


-- theorem commutativity (n: Natural) : Natural.add n Natural.zero = n := by
--   induction n
--   case zero => exact Natural.add._eq_1 $ Natural.zero
--   case succ n' ih =>
--     rw [Natural.add._eq_2 (Natural.zero) n']
--     rw [ih]

-- #check commutativity


-- theorem add_comm (n m: Natural) : Natural.add n m = Natural.add m n := by
--   induction n
--   case zero => exact Natural.add._eq_1 $ Natural.zero
--   case succ n' ih =>
