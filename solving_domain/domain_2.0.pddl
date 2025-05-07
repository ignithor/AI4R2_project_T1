(define (domain warehouse-crates)
  (:requirements :typing :durative-actions :negative-preconditions)
  (:types robot crate)
  (:predicates (free ?r - robot)
  (carried ?c - crate)
  )

  (:durative-action pick
    :parameters (?r - robot ?c - crate)
    :duration (= ?duration 0)
    :condition (and (at start (free ?r)))
    :effect (and (at end (not (free ?r)))
                            (at end (carried ?c))
    )))
