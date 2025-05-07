(define (problem warehouse-test-move-crate-single)
  (:domain warehouse_planning)

  (:objects
    robot1 - mover
    crate1 - light_crate
    location1 location2 - location
  )

  (:init
    (robot_at robot1 location1)
    (mover_carrying robot1 crate1)
    (= (weight crate1) 30)
    
    ;; Location distances
    (= (distance location1 location2) 20)
    (= (distance location2 location1) 20)
  )

  (:goal
    (and
      (robot_at robot1 location2)
    )
  )
  
  (:metric minimize (total-time))
)
