(define (domain warehouse-crates-4321)
  (:requirements :typing :durative-actions :negative-preconditions :numeric-fluents)
  (:types
    robot
    mover loader - robot
    side_loader full_loader - loader ;; full_loader can load any crate, side_loader only loads light ones
    crate
    fragile_crate normal_crate - crate
    group
    charging_station
  )
  (:predicates
  (at_loading_bay ?m - mover) ;; predicates at_... for movers
  (at_pause ?m - mover) ;; means that it is not managing a crate and not charging
  (idle ?l - loader)
  (on_shelf ?c - crate) ;; predicates on_... for crates
  (on_loading_bay ?c - crate) 
  (is_picked_by_loader ?l - loader ?c - crate) ;; predicate is_... for action of robot on crate
  (is_loading_crate ?l - loader ?c - crate)
  (is_at_crate ?m - mover ?c - crate)
  (is_picked_by_mover_single ?m - mover ?c - crate)
  (is_picked_by_mover_dual ?m - mover ?c - crate)
  (is_moving_crate_single ?m - mover ?c - crate)
  (is_moving_crate_dual ?m - mover ?c - crate)
  (empty ?r - robot)
  (loaded ?c - crate)
  (group_active ?g - group)
  (is_of_group ?g - group ?c - crate)
  (no_group ?c - crate)
  (no_active_group)
  (pickable ?c - crate)
  (free ?st - charging_station)
  (independent ?m1 - mover ?m2 - mover)
  )

  (:functions
    (weight ?c - crate)
    (distance ?c - crate)
    (group-cost)
    (battery ?m - mover)
    (battery-capacity ?m - mover) ;; fixed to 20 in the assignment
    (charging_vel ?st - charging_station)
  )

  (:durative-action move_empty
    :parameters (?m - mover ?c - crate)
    :duration (= ?duration (/ (distance ?c) 10))
    :condition (and (at start (empty ?m))
                  (at start (at_pause ?m))
                  (at start (on_shelf ?c))
                  (at start (at_loading_bay ?m))
                  (at start (>= (battery ?m) (/ (distance ?c) 10)))
    )
    :effect (and (at start (not (at_pause ?m)))
                (at end (not (at_loading_bay ?m)))
                (at end (is_at_crate ?m ?c))
                (at end (decrease (battery ?m) (/ (distance ?c) 10)))
    )) 

  ; (:durative-action move_empty_slow
  ;   :parameters (?m - mover ?c - normal_crate)
  ;   :duration (= ?duration (/ (distance ?c) 10))
  ;   :condition (and (at start (empty ?m))
  ;                 (at start (at_pause ?m))
  ;                 (at start (on_shelf ?c))
  ;                 (at start (at_loading_bay ?m))
  ;                 (at start (>= (battery ?m) (+ (/ (distance ?c) 10) (/ (* (distance ?c) (weight ?c)) 100))))
  ;   )
  ;   :effect (and (at start (not (at_pause ?m)))
  ;               (at end (not (at_loading_bay ?m)))
  ;               (at end (is_at_crate ?m ?c))
  ;               (at end (decrease (battery ?m) (/ (distance ?c) 10)))
  ;   )) 

  ; (:durative-action move_empty_fast
  ;   :parameters (?m - mover ?c - crate)
  ;   :duration (= ?duration (/ (distance ?c) 10))
  ;   :condition (and (at start (empty ?m))
  ;                 (at start (at_pause ?m))
  ;                 (at start (on_shelf ?c))
  ;                 (at start (at_loading_bay ?m))
  ;                 (at start (< (weight ?c) 50))
  ;                 (at start (>= (battery ?m) (+ (/ (distance ?c) 10) (/ (* (distance ?c) (weight ?c)) 150))))
  ;   )
  ;   :effect (and (at start (not (at_pause ?m)))
  ;               (at end (not (at_loading_bay ?m)))
  ;               (at end (is_at_crate ?m ?c))
  ;               (at end (decrease (battery ?m) (/ (distance ?c) 10))) 
  ;   ))

  (:durative-action mover_pick_single
    :parameters (?m - mover ?c - normal_crate)
    :duration (= ?duration 0.1)
    :condition (and (at start (empty ?m))
                    (at start (on_shelf ?c))
                    (at start (is_at_crate ?m ?c))
                    (at start (pickable ?c))
    )
    :effect (and (at end (not (empty ?m)))
                  (at end (not (on_shelf ?c)))
                  (at end (is_picked_by_mover_single ?m ?c))
                  (at start (not (pickable ?c)))
    ))
  
  (:durative-action mover_pick_dual
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :duration (= ?duration 0.1)
    :condition (and (at start (empty ?m1))
                    (at start (empty ?m2))
                    (at start (on_shelf ?c))
                    (at start (is_at_crate ?m1 ?c))
                    (at start (is_at_crate ?m2 ?c))
                    (at start (pickable ?c))
                    (over all (independent ?m1 ?m2))
                    (over all (independent ?m2 ?m1))
    )
    :effect (and (at end (not (empty ?m1)))
                  (at end (not (empty ?m2)))
                  (at end (not (on_shelf ?c)))
                  (at end (is_picked_by_mover_dual ?m1 ?c))
                  (at end (is_picked_by_mover_dual ?m2 ?c))
                  (at start (not (pickable ?c)))
    ))

  (:durative-action move_crate_single
    :parameters (?m - mover ?c - normal_crate)
    :duration (= ?duration (/ (* (distance ?c) (weight ?c)) 100))
    :condition (and (over all (is_picked_by_mover_single ?m ?c))
                    (at start (< (weight ?c) 50))
                    (at start (>= (battery ?m) (/ (* (distance ?c) (weight ?c)) 100)))
    )
    :effect (and (at start (is_moving_crate_single ?m ?c))
                (at end (not (is_moving_crate_single ?m ?c)))
                (at end (at_loading_bay ?m))
                (at end (decrease (battery ?m) (/ (* (distance ?c) (weight ?c)) 100)))
    ))
  
  (:durative-action move_crate_dual_heavy
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :duration (= ?duration (/ (* (distance ?c) (weight ?c)) 100))
    :condition (and (over all (is_picked_by_mover_dual ?m1 ?c))
                    (over all (is_picked_by_mover_dual ?m2 ?c))
                    (over all (>= (weight ?c) 50))
                    (at start (>= (battery ?m1) (/ (* (distance ?c) (weight ?c)) 100)))
                    (at start (>= (battery ?m2) (/ (* (distance ?c) (weight ?c)) 100)))
                    (over all (independent ?m1 ?m2))
                    (over all (independent ?m2 ?m1))
    )
    :effect (and (at start (is_moving_crate_dual ?m1 ?c))
                (at start (is_moving_crate_dual ?m2 ?c))
                (at end (not (is_moving_crate_dual ?m1 ?c)))
                (at end (not (is_moving_crate_dual ?m2 ?c)))
                (at end (at_loading_bay ?m1))
                (at end (at_loading_bay ?m2))
                (at end (decrease (battery ?m1) (/ (* (distance ?c) (weight ?c)) 100)))
                (at end (decrease (battery ?m2) (/ (* (distance ?c) (weight ?c)) 100)))
    ))
  
  (:durative-action move_crate_dual_light
    :parameters (?m1 - mover ?m2 - mover ?c - crate)
    :duration (= ?duration (/ (* (distance ?c) (weight ?c)) 150))
    :condition (and (over all (is_picked_by_mover_dual ?m1 ?c))
                    (over all (is_picked_by_mover_dual ?m2 ?c))
                    (over all (< (weight ?c) 50))
                    (at start (>= (battery ?m1) (/ (* (distance ?c) (weight ?c)) 150)))
                    (at start (>= (battery ?m2) (/ (* (distance ?c) (weight ?c)) 150)))
                    (over all (independent ?m1 ?m2))
                    (over all (independent ?m2 ?m1))
    )
    :effect (and (at start (is_moving_crate_dual ?m1 ?c))
                (at start (is_moving_crate_dual ?m2 ?c))
                (at end (not (is_moving_crate_dual ?m1 ?c)))
                (at end (not (is_moving_crate_dual ?m2 ?c)))
                (at end (at_loading_bay ?m1))
                (at end (at_loading_bay ?m2))
                (at end (decrease (battery ?m1) (/ (* (distance ?c) (weight ?c)) 150)))
                (at end (decrease (battery ?m2) (/ (* (distance ?c) (weight ?c)) 150)))
    ))

  (:durative-action put_down_to_full_loader_single
    :parameters (?m - mover ?l - full_loader ?c - normal_crate)
    :duration (= ?duration 0.1)
    :condition (and (at start (is_picked_by_mover_single ?m ?c))
                    (at start (at_loading_bay ?m))
                    (at start (idle ?l))
    )
    :effect (and (at end (not (is_picked_by_mover_single ?m ?c)))
                  (at end (empty ?m))
                  (at end (at_pause ?m))
                  (at end (on_loading_bay ?c))
                  (at end (not (is_at_crate ?m ?c)))
                  (at start (not (idle ?l)))
                  (at end (pickable ?c))
    ))
  
  (:durative-action put_down_to_side_loader_single
    :parameters (?m - mover ?l - side_loader ?c - normal_crate)
    :duration (= ?duration 0.1)
    :condition (and (at start (is_picked_by_mover_single ?m ?c))
                    (at start (at_loading_bay ?m))
                    (at start (< (weight ?c) 50))
                    (at start (idle ?l))
    )
    :effect (and (at end (not (is_picked_by_mover_single ?m ?c)))
                  (at end (empty ?m))
                  (at end (at_pause ?m))
                  (at end (on_loading_bay ?c))
                  (at end (not (is_at_crate ?m ?c)))
                  (at start (not (idle ?l)))
                  (at end (pickable ?c))
    ))
  
  (:durative-action put_down_to_full_loader_dual
    :parameters (?m1 - mover ?m2 - mover ?l - full_loader ?c - crate)
    :duration (= ?duration 0.1)
    :condition (and (at start (is_picked_by_mover_dual ?m1 ?c))
                    (at start (is_picked_by_mover_dual ?m2 ?c))
                    (at start (at_loading_bay ?m1))
                    (at start (at_loading_bay ?m2))
                    (at start (idle ?l))
                    (over all (independent ?m1 ?m2))
                    (over all (independent ?m2 ?m1))
    )
    :effect (and (at end (not (is_picked_by_mover_dual ?m1 ?c)))
                  (at end (not (is_picked_by_mover_dual ?m2 ?c)))
                  (at end (empty ?m1))
                  (at end (empty ?m2))
                  (at end (at_pause ?m1))
                  (at end (at_pause ?m2))
                  (at end (on_loading_bay ?c))
                  (at end (not (is_at_crate ?m1 ?c)))
                  (at end (not (is_at_crate ?m2 ?c)))
                  (at start (not (idle ?l)))
                  (at end (pickable ?c))
    ))
  
  (:durative-action put_down_to_side_loader_dual
    :parameters (?m1 - mover ?m2 - mover ?l - side_loader ?c - crate)
    :duration (= ?duration 0.1)
    :condition (and (at start (is_picked_by_mover_dual ?m1 ?c))
                    (at start (is_picked_by_mover_dual ?m2 ?c))
                    (at start (at_loading_bay ?m1))
                    (at start (at_loading_bay ?m2))
                    (at start (< (weight ?c) 50))
                    (at start (idle ?l))
                    (over all (independent ?m1 ?m2))
                    (over all (independent ?m2 ?m1))
    )
    :effect (and (at end (not (is_picked_by_mover_dual ?m1 ?c)))
                  (at end (not (is_picked_by_mover_dual ?m2 ?c)))
                  (at end (empty ?m1))
                  (at end (empty ?m2))
                  (at end (at_pause ?m1))
                  (at end (at_pause ?m2))
                  (at end (on_loading_bay ?c))
                  (at end (not (is_at_crate ?m1 ?c)))
                  (at end (not (is_at_crate ?m2 ?c)))
                  (at start (not (idle ?l)))
                  (at end (pickable ?c))
    ))

  (:durative-action full_loader_pick_grouped_crate
    :parameters (?l - full_loader ?c - crate ?g - group)
    :duration (= ?duration 0.1)
    :condition (and (at start (empty ?l))
                    (at start (on_loading_bay ?c))
                    (at start (and (group_active ?g) (is_of_group ?g ?c)))
    )
    :effect (and (at end (not (empty ?l)))
                  (at end (not (on_loading_bay ?c)))
                  (at end (is_picked_by_loader ?l ?c))
    ))
  
  (:durative-action loader_pick_ungrouped_crate
    :parameters (?l - full_loader ?c - crate)
    :duration (= ?duration 0.1)
    :condition (and (at start (empty ?l))
                    (at start (on_loading_bay ?c))
                    (at start (and (no_active_group) (no_group ?c)))
    )
    :effect (and (at end (not (empty ?l)))
                  (at end (not (on_loading_bay ?c)))
                  (at end (is_picked_by_loader ?l ?c))
    ))
  
  (:durative-action side_loader_pick_grouped_crate
    :parameters (?sl - side_loader ?sc - crate ?fl - full_loader ?fc - crate ?g - group) ;; maybe change full_loader to loader to enable more than 2 side_loaders
    :duration (= ?duration 0.1)
    :condition (and (at start (empty ?sl))
                    (over all (< (weight ?sc) 50))
                    (at start (on_loading_bay ?sc))
                    (at start (is_loading_crate ?fl ?fc))
                    (at start (and (group_active ?g) (is_of_group ?g ?sc)))
    )
    :effect (and (at end (not (empty ?sl)))
                  (at end (not (on_loading_bay ?sc)))
                  (at end (is_picked_by_loader ?sl ?sc))
    ))
  
  (:durative-action side_loader_pick_ungrouped_crate
    :parameters (?sl - side_loader ?sc - crate ?fl - full_loader ?fc - crate) ;; maybe change full_loader to loader to enable more than 2 side_loaders
    :duration (= ?duration 0.1)
    :condition (and (at start (empty ?sl))
                    (over all (< (weight ?sc) 50))
                    (at start (on_loading_bay ?sc))
                    (at start (is_loading_crate ?fl ?fc))
                    (at start (and (no_active_group) (no_group ?sc)))
    )
    :effect (and (at end (not (empty ?sl)))
                  (at end (not (on_loading_bay ?sc)))
                  (at end (is_picked_by_loader ?sl ?sc))
    ))
  
  (:durative-action full_load_normal_crate
    :parameters (?l - full_loader ?c - normal_crate)
    :duration (= ?duration 4)
    :condition (and (at start (is_picked_by_loader ?l ?c))
    )
    :effect (and (at start (not (empty ?l)))
                (at start (not (is_picked_by_loader ?l ?c)))
                (at start (is_loading_crate ?l ?c))
                (at end (loaded ?c))
                (at end (not (is_loading_crate ?l ?c)))
                (at end (empty ?l))
                (at end (idle ?l))
    ))
  
  (:durative-action side_load_normal_crate
    :parameters (?l - side_loader ?c - normal_crate)
    :duration (= ?duration 4)
    :condition (and (at start (is_picked_by_loader ?l ?c))
    )
    :effect (and (at start (not (empty ?l)))
                (at start (not (is_picked_by_loader ?l ?c)))
                (at start (is_loading_crate ?l ?c))
                (at end (loaded ?c))
                (at end (not (is_loading_crate ?l ?c)))
                (at end (empty ?l))
                (at end (idle ?l))
    ))

  (:durative-action full_load_fragile_crate
    :parameters (?l - loader ?c - fragile_crate) ;full_loader ?c - fragile_crate)
    :duration (= ?duration 6)
    :condition (and (at start (is_picked_by_loader ?l ?c))
    )
    :effect (and (at start (not (empty ?l)))
                (at start (not (is_picked_by_loader ?l ?c)))
                (at start (is_loading_crate ?l ?c))
                (at end (loaded ?c))
                (at end (not (is_loading_crate ?l ?c)))
                (at end (empty ?l))
                (at end (idle ?l))
    ))
  
  (:durative-action side_load_fragile_crate
    :parameters (?l - side_loader ?c - fragile_crate)
    :duration (= ?duration 6)
    :condition (and (at start (is_picked_by_loader ?l ?c))
    )
    :effect (and (at start (not (empty ?l)))
                (at start (not (is_picked_by_loader ?l ?c)))
                (at start (is_loading_crate ?l ?c))
                (at end (loaded ?c))
                (at end (not (is_loading_crate ?l ?c)))
                (at end (empty ?l))
                (at end (idle ?l))
    ))
  
  (:durative-action switch_group
    :parameters (?ga - group ?gn - group ?c - crate)
    :duration (= ?duration 0)
    :condition (and (at start (group_active ?ga)) ;; ?gn must also be inactive but no negative condition, so let's consider that problems are always initializing with unactive groups (or not more than one)
                    (over all (is_of_group ?gn ?c))
                    (at start (on_shelf ?c))
    )
    :effect (and (at end (not (group_active ?ga)))
                (at end (group_active ?gn))
                (at end (assign (group-cost) (+ (group-cost) 1)))
    ))
  
  (:durative-action activate_group
    :parameters (?gn - group ?c - crate)
    :duration (= ?duration 0)
    :condition (and (at start (no_active_group))
                    (over all (is_of_group ?gn ?c))
                    (at start (on_shelf ?c))
    )
    :effect (and (at end (not (no_active_group)))
                (at end (group_active ?gn))
                (at end (assign (group-cost) (+ (group-cost) 1)))
    ))
  
  (:durative-action deactivate_groups
    :parameters (?ga - group ?c - crate)
    :duration (= ?duration 0)
    :condition (and (at start (group_active ?ga))
                    (over all (no_group ?c))
                    (at start (on_shelf ?c))
    )
    :effect (and (at end (no_active_group))
                (at end (not (group_active ?ga)))
                (at end (assign (group-cost) (+ (group-cost) 1)))
    ))
  
  (:durative-action charge_mover_1_unit ;; could also charge to maximum but time optimisation is better this way
    :parameters (?m - mover ?st - charging_station)
    :duration (= ?duration (/ 1 (charging_vel ?st)))
    ; :duration (= ?duration (/ (- 20 (battery ?m)) (charging_vel ?st)))
    :condition (and (at start (at_loading_bay ?m))
                    (at start (at_pause ?m))
                    (at start (free ?st))
                    (at start (< (battery ?m) (battery-capacity ?m)))
    )
    :effect (and (at start (not (free ?st)))
                (at start (not (at_pause ?m)))
                (at end (free ?st))
                (at end (at_pause ?m))
                (at end (increase (battery ?m) 1))
                ; (at end (assign (battery ?m) (battery-capacity ?m)))
    )

  )
)