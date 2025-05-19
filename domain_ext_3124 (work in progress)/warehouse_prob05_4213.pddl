(define (problem warehouse-05-ext4213)
  (:domain warehouse-crates-4213)
  (:objects 
    m1 m2 - mover
    c1 c2 - normal_crate
    fl - full_loader
    sl - side_loader
    A - group
    st1 st2 - charging_station
  )
  (:init
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
    (pickable c1)
    (pickable c2)
    (= (weight c1) 70)
    (= (weight c2) 20)
    (= (distance c1) 10)
    (= (distance c2) 20)
    (no_active_group)
    (no_group c1)
    (is_of_group A c2)
    (= (group-cost) 0)
    (free st1)
    (free st2)
    (= (charging_vel st1) 2)
    (= (charging_vel st2) 2)
    (= (battery m1) 20)
    (= (battery m2) 20)
    )
  (:goal
    (and (loaded c1)
        (loaded c2)    ))
  (:metric minimize (+ (total-time) (group-cost)))
  )
