(define (problem warehouse-4-ext421)
  (:domain warehouse-crates-421)
  (:objects 
    m1 m2 - mover
    c1 c6 - normal_crate
    c2 c3 c4 c5 - fragile_crate  
    fl - full_loader
    sl - side_loader
    A B - group
  )
  (:init ;; always initialize groups as not active, or not more than one should be active
    (independent m1 m2)
    (independent m2 m1)
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
    (on_shelf c5)
    (on_shelf c6)
    (pickable c1)
    (pickable c2)
    (pickable c3)
    (pickable c4)
    (pickable c5)
    (pickable c6)
    (= (weight c1) 30)
    (= (weight c2) 20)
    (= (weight c3) 30)
    (= (weight c4) 20)
    (= (weight c5) 30)
    (= (weight c6) 20)
    (= (distance c1) 20)
    (= (distance c2) 20)
    (= (distance c3) 10)
    (= (distance c4) 20)
    (= (distance c5) 30)
    (= (distance c6) 10)
    (no_active_group)
    (is_of_group A c1)
    (is_of_group A c2)
    (is_of_group B c3)
    (is_of_group B c4)
    (is_of_group B c5)
    (no_group c6)
    (= (group-cost) 0)
    )
  (:goal
    (and (loaded c1)
        (loaded c2)
        (loaded c3)
        (loaded c4)
        (loaded c5)
        (loaded c6)
    ))
  (:metric minimize (+ (total-time) (group-cost)))
  )
