(define (problem test-4123)
  (:domain warehouse-crates-4213)
  (:objects 
    m1 m2 - mover
    c1 c2 - normal_crate
    fl - full_loader
    sl - side_loader
    A B - group
    st1 st2 - charging_station
  )
  (:init
    (independent m1 m2)
    (independent m2 m1)
    (at_loading_bay m1)
    (at_loading_bay m2)
    (at_pause m1)
    (at_pause m2)
    (free st1)
    (free st2)
    (empty m1)
    (empty m2)
    (= (battery-capacity m1) 20)
    (= (battery-capacity m2) 20)
    (= (charging_vel st1) 2)
    (= (charging_vel st2) 2)
    (= (battery m1) 20)
    (= (battery m2) 20)
    (= (group-cost) 0)
    (on_shelf c1)
    (pickable c1)
    (= (weight c1) 60)
    (= (distance c1) 40)
    ; (no_group c1)
    (is_of_group A c1)
    (on_shelf c2)
    (pickable c2)
    (= (weight c2) 20)
    (= (distance c2) 60)
    (is_of_group B c2)
    (empty fl)
    (idle fl)
    (no_active_group)
    )
  (:goal
    (and 
      (loaded c1)
      (loaded c2)
    ))
  (:metric minimize (+ (total-time) (group-cost)))
  )
