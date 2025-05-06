(define (problem warehouse-pickup-test)
  (:domain warehouse_planning)

  (:objects
    robot1 - mover
    crate1 - light_crate
    locA - location
  )

  (:init
    (robot_at robot1 locA)
    (crate_at crate1 locA)
  )

  (:goal
    (and
      (mover_carrying robot1 crate1)
      (not (crate_at crate1 locA))
    )
  )
)
