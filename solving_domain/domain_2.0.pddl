(define (domain warehouse-crates)
  (:requirements :typing :durative-actions :negative-preconditions)
  (:types
    robot
    mover loader - robot
    crate
  )
  (:predicates
  (at_loading_bay ?m - mover) ;; predicates at_... for movers
  (on_shelf ?c - crate) ;; predicates on_... for crates
  (on_loading_bay ?c - crate)
  (on_conveyor_belt ?c - crate) 
  (is_picked_by_loader ?l - loader ?c - crate) ;; predicate is_... for action of robot on crate
  (is_loading_crate ?l - loader ?c - crate)
  (is_picked_by_mover ?m - mover ?c - crate)
  (is_moving_crate ?m - mover ?c - crate)
  (free ?r - robot)
  (loaded ?c - crate)
  )

  (:functions
    (weight ?c - crate)
    (distance_c ?c - crate)
    (distance_m ?m - mover ?c - crate)
  )

  (:durative-action mover_pick
    :parameters (?m - mover ?c - crate)
    :duration (= ?duration 0)
    :condition (and (at start (free ?m))
                    (at start (on_shelf ?c))
                    (at start (= (distance_m ?m ?c) 0.0))
    )
    :effect (and (at end (not (free ?m)))
                  (at end (not (on_shelf ?c)))
                  (at end (is_picked_by_mover ?m ?c))
    ))
  
(:durative-action loader_pick
    :parameters (?l - loader ?c - crate)
    :duration (= ?duration 0)
    :condition (and (at start (free ?l))
                    (at start (on_loading_bay ?c))
    )
    :effect (and (at end (not (free ?l)))
                  (at end (not (on_loading_bay ?c)))
                  (at end (is_picked_by_loader ?l ?c))
    ))


  )
