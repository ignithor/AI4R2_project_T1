(define (problem warehouse-0-0)
  (:domain warehouse-crates)
  (:objects 
    m1 m2 - mover
    c1 c2 - crate
    l1 - loader
  )
  (:init
    (empty m1)
    (at_pause m1)
    (on_shelf c1)
    (at_loading_bay m1)
    (= (distance c1) 10)
    (empty m2)
    (at_pause m2)
    (on_shelf c2)
    (at_loading_bay m2)
    (= (distance c2) 30)
    )
  (:goal
    (and (is_at_crate m1 c1)
         (is_at_crate m2 c2)
    ))
  )
