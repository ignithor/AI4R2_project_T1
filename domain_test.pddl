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
    (loader_free)
    (robot_free ?r - mover)
    (bay_free)
    (bay_occupied)
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

  ;; Pick Up Light Crate (Single Robot)
  (:durative-action pick_up_single
    :parameters (?r - mover ?c - light_crate ?l - location)
    :duration (= ?duration 0.5)
    :condition (and
      (at start (robot_at ?r ?l))
      (at start (crate_at ?c ?l))
      (at start (< (weight ?c) 50))
      (at start (robot_free ?r))
      (over all (robot_at ?r ?l))
    )
    :effect (and
      (at end (mover_carrying ?r ?c))
      (at end (not (crate_at ?c ?l)))
      (at end (not (robot_free ?r)))
    )
  )

  ;; Pick Up Crate (Two Robots)
  (:durative-action pick_up_dual
    :parameters (?r1 ?r2 - mover ?c - crate ?l - location)
    :duration (= ?duration 0.5)
    :condition (and
      (at start (robot_at ?r1 ?l))
      (at start (robot_at ?r2 ?l))
      (at start (crate_at ?c ?l))
      (at start (robot_free ?r1))
      (at start (robot_free ?r2))
      (over all (robot_at ?r1 ?l))
      (over all (robot_at ?r2 ?l))
    )
    :effect (and
      (at end (mover_carrying ?r1 ?c))
      (at end (mover_carrying ?r2 ?c))
      (at end (not (crate_at ?c ?l)))
      (at end (not (robot_free ?r1)))
      (at end (not (robot_free ?r2)))
    )
  )

  ;; Drop Crate at Loading Bay (Single Robot)
  (:durative-action drop_single
    :parameters (?r - mover ?c - light_crate ?l - location)
    :duration (= ?duration 0.5)
    :condition (and
      (at start (robot_at ?r ?l))
      (at start (mover_carrying ?r ?c))
      (at start (loading_bay ?l))
      (at start (bay_free))
      (at start (loader_free))
      (over all (robot_at ?r ?l))
      (over all (loader_free))
    )
    :effect (and
      (at end (not (mover_carrying ?r ?c)))
      (at end (crate_at ?c ?l))
      (at end (on_loading_bay ?c))
      (at end (robot_free ?r))
      (at end (bay_occupied))
    )
  )

  ;; Drop Crate at Loading Bay (Two Robots)
  (:durative-action drop_dual
    :parameters (?r1 ?r2 - mover ?c - crate ?l - location)
    :duration (= ?duration 0.5)
    :condition (and
      (at start (robot_at ?r1 ?l))
      (at start (robot_at ?r2 ?l))
      (at start (mover_carrying ?r1 ?c))
      (at start (mover_carrying ?r2 ?c))
      (at start (loading_bay ?l))
      (at start (bay_free))
      (at start (loader_free))
      (over all (robot_at ?r1 ?l))
      (over all (robot_at ?r2 ?l))
      (over all (loader_free))
    )
    :effect (and
      (at end (not (mover_carrying ?r1 ?c)))
      (at end (not (mover_carrying ?r2 ?c)))
      (at end (crate_at ?c ?l))
      (at end (on_loading_bay ?c))
      (at end (robot_free ?r1))
      (at end (robot_free ?r2))
      (at end (bay_occupied))
    )
  )

  ;; Load Crate onto Conveyor Belt (Loader)
  (:durative-action load_crate
    :parameters (?r - loader ?c - crate ?l - location)
    :duration (= ?duration 4)
    :condition (and
      (at start (robot_at ?r ?l))
      (at start (crate_at ?c ?l))
      (at start (on_loading_bay ?c))
      (at start (loading_bay ?l))
      (at start (bay_occupied))
      (at start (loader_free))
      (over all (robot_at ?r ?l))
    )
    :effect (and
      (at start (not (loader_free)))
      (at start (not (on_loading_bay ?c)))
      (at start (not (crate_at ?c ?l)))
      (at end (loaded ?c))
      (at end (loader_free))
      (at end (bay_free))
    )
  )

  ;; Move Light Crate (Single Robot)
  (:durative-action move_crate_single
    :parameters (?r - mover ?c - light_crate ?from ?to - location)
    :duration (= ?duration (/ (* (distance ?from ?to) (weight ?c)) 100))
    :condition (and
      (at start (robot_at ?r ?from))
      (at start (mover_carrying ?r ?c))
      (at start (< (weight ?c) 50))
      (over all (mover_carrying ?r ?c))
    )
    :effect (and
      (at start (not (robot_at ?r ?from)))
      (at end (robot_at ?r ?to))
    )
  )

  ;; Move Crate (Two Robots)
  (:durative-action move_crate_dual
    :parameters (?r1 ?r2 - mover ?c - crate ?from ?to - location)
    :duration (= ?duration (/ (* (distance ?from ?to) (weight ?c)) 150))
    :condition (and
      (at start (robot_at ?r1 ?from))
      (at start (robot_at ?r2 ?from))
      (at start (mover_carrying ?r1 ?c))
      (at start (mover_carrying ?r2 ?c))
      (over all (mover_carrying ?r1 ?c))
      (over all (mover_carrying ?r2 ?c))
    )
    :effect (and
      (at start (not (robot_at ?r1 ?from)))
      (at start (not (robot_at ?r2 ?from)))
      (at end (robot_at ?r1 ?to))
      (at end (robot_at ?r2 ?to))
    )
  )
)
