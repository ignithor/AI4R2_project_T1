(define (problem warehouse-0-5)
  (:domain warehouse-crates)
  (:objects 
    m1 m2 - mover
    c1 c2 - crate
    l1 - loader
  )
  (:init
    (empty m1)
    (empty m2)
    (at_pause m1)
    (at_pause m2)
    (at_loading_bay m1)
    (at_loading_bay m2)
    (on_shelf c1)
    (on_shelf c2)
    (= (weight c1) 70)
    (= (weight c2) 20)
    (= (distance c1) 10)
    (= (distance c2) 20)
    )
  (:goal
    (and (loaded c1)
        (loaded c2)
    ))
  )
