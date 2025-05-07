(define (domain warehouse-crates)
  (:requirements :typing :durative-actions :negative-preconditions)
  (:types
    robot
    mover loader - robot
    crate
  )
  (:predicates
  (at_loading_bay ?m - mover) ;; predicates at_... for movers
  (at_pause ?m - mover) ;; means that it is not managing a crate
  (on_shelf ?c - crate) ;; predicates on_... for crates
  (on_loading_bay ?c - crate)
  (on_conveyor_belt ?c - crate) 
  (is_picked_by_loader ?l - loader ?c - crate) ;; predicate is_... for action of robot on crate
  (is_loading_crate ?l - loader ?c - crate)
  (is_at_crate ?m - mover ?c - crate)
  (is_picked_by_mover ?m - mover ?c - crate)
  (is_moving_crate ?m - mover ?c - crate)
  (empty ?r - robot)
  (loaded ?c - crate)
  )

  (:functions
    (weight ?c - crate)
    (distance ?c - crate)
  )

  (:durative-action mover_pick
    :parameters (?m - mover ?c - crate)
    :duration (= ?duration 0)
    :condition (and (at start (empty ?m))
                    (at start (on_shelf ?c))
                    (at start (is_at_crate ?m ?c))
    )
    :effect (and (at end (not (empty ?m)))
                  (at end (not (on_shelf ?c)))
                  (at end (is_picked_by_mover ?m ?c))
    ))
  
  (:durative-action loader_pick
    :parameters (?l - loader ?c - crate)
    :duration (= ?duration 0)
    :condition (and (at start (empty ?l))
                    (at start (on_loading_bay ?c))
    )
    :effect (and (at end (not (empty ?l)))
                  (at end (not (on_loading_bay ?c)))
                  (at end (is_picked_by_loader ?l ?c))
    ))

  (:durative-action put_down
    :parameters (?m - mover ?c - crate)
    :duration (= ?duration 0)
    :condition (and (at start (is_picked_by_mover ?m ?c))
                    (at start (at_loading_bay ?m))
    )
    :effect (and (at end (not (is_picked_by_mover ?m ?c)))
                  (at end (empty ?m))
                  (at end (on_loading_bay ?c))
    ))
  
    (:durative-action move_empty
     :parameters (?m - mover ?c - crate)
     :duration (= ?duration (/ (distance ?c) 10))
     :condition (and (at start (empty ?m))
                    (at start (at_pause ?m))
                    (at start (on_shelf ?c))
                    (at start (at_loading_bay ?m))
     )
     :effect (and (at start (not (at_pause ?m)))
                  (at end (is_at_crate ?m ?c))
     ))

  )
