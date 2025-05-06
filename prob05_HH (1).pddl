(define (problem WAREHOUSE-0-5)
(:domain <warehouse_planning>)
(:objects c70 c20 - crate
            l1 - loader
            m1 m2 - mover
            warehouse loading_bay conveyor_belt - location)
(:INIT (robot_at l1 loading_bay)
        (robot_at m1 warehouse)
        (robot_at m2 warehouse)
        (crate_at c70 warehouse)
        (crate_at c20 warehouse)
        (=(weight c70) 70)
        (=(weight c20) 20)
        (=(distance c70) 10)
        (=(distance c20) 20)
)

(:goal (AND (crate_at c70 conveyor_belt)
            (crate_at c20 conveyor_belt))
)

)