(define (problem warehouse-0-0)
  (:domain warehouse-crates)
  (:objects 
    m1 - mover
    c1 c2 - crate
    l1 - loader
  )
  (:init
    (free m1)
    (on_shelf c1)
    (= (distance_m m1 c1) 0.0)
    (on_loading_bay c2)
    (free l1)
    )
  (:goal
    (and (is_picked_by_mover m1 c1)
          (is_picked_by_loader l1 c2)
    ))
  )
