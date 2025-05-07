(define (problem warehouse-test-pick-up-single)
  (:domain warehouse_planning)

  (:objects
    robot1 - mover
    crate1 - light_crate
    location1 - location
  )

  (:init
    (robot_at robot1 location1)
    (crate_at crate1 location1)
    (= (weight crate1) 30)
    (robot_free robot1)
  )

  (:goal (and
    (mover_carrying robot1 crate1)
  ))
)
