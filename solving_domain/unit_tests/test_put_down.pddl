(define (problem warehouse-0-0)
  (:domain warehouse-crates)
  (:objects 
    m1 - mover
    c1 c2 - crate
    l1 - loader
  )
  (:init
    (empty m1)
    (on_shelf c1)
    (is_at_crate m1 c1)
    (at_loading_bay m1)
    )
  (:goal
    (and (on_loading_bay c1)
    ))
  )
