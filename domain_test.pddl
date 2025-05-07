(define (domain warehouse_planning)
  (:requirements :typing :durative-actions :numeric-fluents)

  (:types
    robot
    mover loader - robot
    crate
    light_crate heavy_crate - crate
    location
  )

  (:predicates
    (robot_at ?r - robot ?l - location)
    (crate_at ?c - crate ?l - location)
    (mover_carrying ?r - mover ?c - crate)
    (loaded ?c - crate)
    (on_loading_bay ?c - crate)
    (loading_bay ?l - location)
    (loader_busy)
    (robot_free ?r - mover)
    (bay_free)
  )

  (:functions
    (weight ?c - crate)
    (distance ?from - location ?to - location)
  )

  ;; Move Robot Without Crate
  (:durative-action move_robot_free
    :parameters (?r - mover ?from ?to - location)
    :duration (= ?duration (/ (distance ?from ?to) 10))
    :condition (and
      (at start (robot_at ?r ?from))
      (at start (robot_free ?r))
      (over all (robot_free ?r))
    )
    :effect (and
      (at start (not (robot_at ?r ?from)))
      (at end (robot_at ?r ?to))
    )
  )
)
