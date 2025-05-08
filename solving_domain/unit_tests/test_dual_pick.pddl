(define (problem warehouse-0-0)
  (:domain warehouse-crates)
  (:objects 
    m1 m2 - mover
    c1 - crate
  )
  (:init
    (empty m1)
    (empty m2)
    (on_shelf c1)
    (is_at_crate m1 c1)
    (is_at_crate m2 c1)
    )
  (:goal
    (and (is_picked_by_mover_dual m1 c1)
            (is_picked_by_mover_dual m2 c1)
    ))
  )
