(define (problem warehouse-0-0)
  (:domain warehouse-crates)
  (:objects 
    m1 - robot
    c1 - crate)
  (:init
    (free m1))
  (:goal
    (and (carried c1)))
  )
