(define (problem warehouse-0-0)
  (:domain warehouse-crates)
  (:objects 
    m1 - mover
    c1 - crate
    l1 - loader
  )
  (:init
    (on_loading_bay c1)
    (empty l1)
    )
  (:goal
    (and (loaded c1)
    ))
  )
