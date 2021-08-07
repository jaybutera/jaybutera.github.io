#lang pollen

◊(define-meta title "Why have functors when we have fold?")
◊(define-meta published "2021-07-27")

A paper from 1999 by Graham Hutton, titled ◊(link "http://www.cs.nott.ac.uk/~pszgmh/fold.pdf" "A tutorial on the universality and expressiveness of fold"), shows how the recursive fold function can be used for many recursive patterns, including the map. Map of course, in its general definition is a very useful and common pattern in functional programming. In Haskell, the generalization of a map on lists is fmap, implemented in the Functor type class.

◊code-block{ Functor f => fmap :: a -> b -> f a -> f b }

Functors are indeed a very useful pattern, they help in specifying a way for special containers of things to be operated on with normal functions. For instance when we want to add 1 to numbers in a list, we don't need a new add function; ◊code-inline{ fmap (+ 1) [2 2 3] }

But a map on lists can be defined in terms of fold like so..

◊code-block{
fold :: a -> b -> b -> [a]
fold = ..

map f = fold (\(x,xs) -> f x : xs) []
}

From fold we can also implement filter, reverse, and length (Hutton). Would fold have been a more general and more universal abstraction for functional programming? Should we be defining data types in terms of an abstract folding class instead of functors? Such a type class that defines a fold would have a default implementation of map too. That is, if the above definition of map in terms of fold can be generalized to other data types beyond just the list.

Consider the case of enumerating the values a custom-defined recursive tree-like structure.

◊code-block{
data Tree a = Nil | Node a (Tree a) (Tree a)
}

Enumeration is an accumulative operation so it can't be defined in terms of map; a functor is of no use here. But ◊code{enumerate :: Tree a -> Tree (a, Int)} can be defined in terms of fold. If this were written in Racket, or Javascipt or the likes, this would already be quite a burden to define in a functional way because  the standard library definitions of fold expect to operate on lists and lists only. There is no broader concept of a foldable data type.

Haskell has a more abstract type definition: ◊code{fold :: (Foldable t, Monoid m) => t m -> m}
fold is basically taking a Foldable type (a type that implements fold) which contains a type which is a Monoid. Monoid is the general pattern of data that concatenates associatively - for lists it would be the concatenate (:). Fold reduces to a single element of the monoid.

Interestingly in the case of implementing map in terms of fold for lists above, the list is both the Monoid (f x : xs) and the Foldable, as fold is operating from the empty list.

Upon some brief inspection into generalized folds, I found the ◊(link "https://en.wikipedia.org/wiki/Catamorphism" "Catamorphism").
