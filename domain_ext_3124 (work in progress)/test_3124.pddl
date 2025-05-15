(define (problem test-4123)
  (:domain warehouse-crates-4213)
  (:objects 
    m1 m2 - mover
    c1 c3 - normal_crate
    c2 - fragile_crate  
    fl - full_loader
    sl - side_loader
    A - group
    st1 st2 - charging_station
  )
  (:init
    (at_loading_bay m1)
    (at_pause m1)
    (free st1)
    (= (charging_vel st1) 2)
    (= (battery m1) 5)
    (= (group-cost) 0)
    )
  (:goal
    (and (> (battery m1) 17)
    ))
  (:metric minimize (+ (total-time) (group-cost)))
  )
