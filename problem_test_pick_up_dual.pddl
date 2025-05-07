(define (problem warehouse-test-pick-up-dual)
  (:domain warehouse_planning)

  (:objects
    robot1 robot2 - mover
    crate1 - heavy_crate
    location1 - location
  )

  (:init
    (robot_at robot1 location1)
    (robot_at robot2 location1)
    (crate_at crate1 location1)
    (= (weight crate1) 80) 
    (robot_free robot1)
    (robot_free robot2)
  )

  (:goal (and
    (mover_carrying robot1 crate1)
    (mover_carrying robot2 crate1)
  ))
)

