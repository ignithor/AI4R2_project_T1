(define (problem warehouse-test-move-crate-dual)
  (:domain warehouse_planning)

  (:objects
    robot1 robot2 - mover
    crate1 - heavy_crate
    location1 location2 - location
  )

  (:init
    ;; Robots carrying heavy crate
    (robot_at robot1 location1)
    (robot_at robot2 location1)
    (mover_carrying robot1 crate1)
    (mover_carrying robot2 crate1)
    
    ;; Crate properties
    (= (weight crate1) 90)
    
    ;; Location distances
    (= (distance location1 location2) 20)
    (= (distance location2 location1) 20)
  )

  (:goal
    (and
      (robot_at robot1 location2)
      (robot_at robot2 location2)
    )
  )
  
  (:metric minimize (total-time))
)
