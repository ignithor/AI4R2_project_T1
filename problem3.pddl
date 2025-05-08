(define (problem warehouse-3)
  (:domain warehouse_planning)
  (:objects 
    m1 m2 - mover
    l1 - loader
    c1 - normal_crate
    c2 - fragile_crate
    c3 - normal_crate
    c4 - normal_crate
    loading_bay location1 location2 location3 location4 - location
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
    
    ;; Crates properties
    (= (weight c1) 70)  ;; heavy crate (>=50kg)
    (= (weight c2) 80)  ;; light crate (<50kg)
    (= (weight c3) 60)  ;; heavy crate (>=50kg)
    (= (weight c4) 30)

    
    ;; Distances
    (= (distance loading_bay location1) 10)
    (= (distance location1 loading_bay) 10)
    (= (distance loading_bay location2) 20)
    (= (distance location2 loading_bay) 20)
    (= (distance loading_bay location3) 30)
    (= (distance location3 loading_bay) 30)
    (= (distance loading_bay location4) 10)
    (= (distance location4 loading_bay) 10)
;    (= (distance location1 location2) 10)
;    (= (distance location2 location1) 10)
  )
  (:goal
    (and 
      (loaded c1)
      (loaded c2)
      (loaded c3)
      (loaded c4)
    )
  )
  (:metric minimize (total-time))
)
