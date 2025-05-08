(define (problem warehouse-4)
  (:domain warehouse_planning)
  (:objects 
    m1 m2 - mover
    l1 - loader
    c1 - normal_crate
    c2 - fragile_crate
    c3 - fragile_crate
    c4 - fragile_crate
    c5 - fragile_crate
    c6 - normal_crate
    loading_bay location1 location2 location3 location4 location5 location6 - location
  )
  (:init
    ;; Robots status
    (robot_at m1 loading_bay)
    (robot_at m2 loading_bay)
    (robot_at l1 loading_bay)
    (robot_free m1)
    (robot_free m2)
    (loader_free)
    
    ;; Loading bay setup
    (loading_bay loading_bay)
    (bay_free)
    
    ;; Crates location
    (crate_at c1 location1)
    (crate_at c2 location2)
    (crate_at c3 location3)
    (crate_at c4 location4)
    (crate_at c5 location5)  
    (crate_at c6 location6)
    
    ;; Crates properties
    (= (weight c1) 30)  ;; heavy crate (>=50kg)
    (= (weight c2) 20)  ;; light crate (<50kg)
    (= (weight c3) 30)  ;; heavy crate (>=50kg)
    (= (weight c4) 20)
    (= (weight c5) 30)
    (= (weight c6) 10)

    ;; Distances
    (= (distance loading_bay location1) 20)
    (= (distance location1 loading_bay) 20)
    (= (distance loading_bay location2) 20)
    (= (distance location2 loading_bay) 20)
    (= (distance loading_bay location3) 10)
    (= (distance location3 loading_bay) 10)
    (= (distance loading_bay location4) 20)
    (= (distance location4 loading_bay) 20)
    (= (distance loading_bay location5) 30)
    (= (distance location5 loading_bay) 30)
    (= (distance loading_bay location6) 10)
    (= (distance location6 loading_bay) 10)
;    (= (distance location1 location2) 10)
;    (= (distance location2 location1) 10)
  )
  (:goal
    (and 
      (loaded c1)
      (loaded c2)
      (loaded c3)
      (loaded c4)
      (loaded c5)
      (loaded c6)
    )
  )
  (:metric minimize (total-time))
)
