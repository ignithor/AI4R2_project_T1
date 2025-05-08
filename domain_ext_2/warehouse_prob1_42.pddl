(define (problem warehouse-1-ext42)
  (:domain warehouse-crates-42)
  (:objects 
    m1 m2 - mover
    c1 c3 - normal_crate
    c2 - fragile_crate  
    fl - full_loader
    sl - side_loader
  )
  (:init
    (empty m1)
    (empty m2)
    (at_pause m1)
    (at_pause m2)
    (at_loading_bay m1)
    (at_loading_bay m2)
    (empty fl)
    (idle fl)
    (empty sl)
    (idle sl)
    (on_shelf c1)
    (on_shelf c2)
    (on_shelf c3)
    (= (weight c1) 70)
    (= (weight c2) 20)
    (= (weight c3) 20)
    (= (distance c1) 10)
    (= (distance c2) 20)
    (= (distance c3) 20)
    )
  (:goal
    (and (loaded c1)
        (loaded c2)
        (loaded c3)
    ))
  )
