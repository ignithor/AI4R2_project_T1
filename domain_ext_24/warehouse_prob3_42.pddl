(define (problem warehouse-3-ext42)
  (:domain warehouse-crates-42)
  (:objects 
    m1 m2 - mover
    c1 c3 c4 - normal_crate
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
    (on_shelf c4)
    (= (weight c1) 70)
    (= (weight c2) 80)
    (= (weight c3) 60)
    (= (weight c4) 30)
    (= (distance c1) 20)
    (= (distance c2) 20)
    (= (distance c3) 30)
    (= (distance c4) 10)
    )
  (:goal
    (and (loaded c1)
        (loaded c2)
        (loaded c3)
        (loaded c4)
    ))
  )
