(define (problem warehouse-test-move-robot-free)
  (:domain warehouse_planning)

  (:objects
    robot1 - mover
    location1 location2 - location
  )

  (:init
    ;; initial robot condition
    (robot_at robot1 location1)
    (robot_free robot1)
    ;; distance information
    (= (distance location1 location2) 20)
    (= (distance location2 location1) 20)
  )

  (:goal
    ;; move from location1 to location2
    (robot_at robot1 location2)
  )

  (:metric minimize (total-time))
)
