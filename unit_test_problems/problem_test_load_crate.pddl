(define (problem warehouse-test-load-crate)
  (:domain warehouse_planning)

  (:objects
    loader1     - loader
    crate1      - heavy_crate
    location1   - location
  )

  (:init
    (robot_at loader1 location1)
    (crate_at crate1 location1)
    (on_loading_bay crate1)
    (loading_bay location1)
    (bay_occupied)
    (loader_free)
    (not (loaded crate1))
  )

  (:goal
    (and
      (loaded crate1)
      (loader_free)
      (bay_free)
    )
  )
)
