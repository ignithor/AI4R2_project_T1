(define (problem warehouse-test-move-robot-free)
  (:domain warehouse_planning)

  (:objects
    robot1 - mover
    locA locB - location
  )

  (:init
    ;; initial robot condition
    (robot_at robot1 locA)
    (robot_free robot1)
    ;; distance information
    (= (distance locA locB) 20)
    (= (distance locB locA) 20)
  )

  (:goal
    ;; move from locA to locB
    (robot_at robot1 locB)
  )

  (:metric minimize (total-time))
)
