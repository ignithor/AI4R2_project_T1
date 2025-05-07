(define (problem warehouse-test-drop-single)
  (:domain warehouse_planning)

  (:objects
    robot1 - mover
    crate1 - light_crate
    location1   - location
  )

  (:init
    (robot_at robot1 location1)
    (mover_carrying robot1 crate1)
    (loading_bay location1)
    (bay_free)
    (loader_free)
  )

  (:goal
    (and
      (crate_at crate1 location1)
      (on_loading_bay crate1)
      (robot_free robot1)
      (bay_occupied)
    )
  )
)
