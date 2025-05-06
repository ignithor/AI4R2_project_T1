(define (problem warehouse05)
(:domain warehouse_planning)
(:objects c1 - crate
            m1 - mover
            warehouse - location)
(:INIT 
        (robot_at m1 warehouse)
        (crate_at c1 warehouse)
        (free m1)
)

(:goal (mover_carrying m1 c1)
)

)
