(define (problem warehouse-05)
  (:domain warehouse_planning)
  (:objects 
    m1 m2 - mover
    l1 - loader
    c1 - normal_crate
    c2 - normal_crate
    loading_bay location1 location2 - location
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
    
    ;; Crates properties
    (= (weight c1) 70)  ;; heavy crate (>=50kg)
    (= (weight c2) 20)  ;; light crate (<50kg)

    
    ;; Distances
    (= (distance loading_bay location1) 10)
    (= (distance location1 loading_bay) 10)
    (= (distance loading_bay location2) 20)
    (= (distance location2 loading_bay) 20)
    (= (distance location1 location2) 10)
    (= (distance location2 location1) 10)
  )
  (:goal
    (and 
      (loaded c1)
      (loaded c2)
    )
  )
  (:metric minimize (total-time))
)
