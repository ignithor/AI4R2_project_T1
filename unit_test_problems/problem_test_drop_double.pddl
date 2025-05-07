(define (problem warehouse-test-drop-dual)
  (:domain warehouse_planning)

  (:objects
    robot1 robot2 - mover
    crate1       - heavy_crate
    location1    - location
  )

  (:init
    (robot_at robot1 location1)
    (robot_at robot2 location1)
    (mover_carrying robot1 crate1)
    (mover_carrying robot2 crate1)
    (loading_bay location1)
    (bay_free)
    (loader_free)
  )

  (:goal
    (and 
      (crate_at crate1 location1)
      (on_loading_bay crate1)
      (robot_free robot1)
      (robot_free robot2)
      (bay_occupied)
    )
  )
)
