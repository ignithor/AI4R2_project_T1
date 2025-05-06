(define (problem WAREHOUSE-0-5)
(:domain WAREHOUSE)
(:objects c70 c20 - crate
            A - crate_group
            l1 - loader
            m1 m2 - mover)
(:INIT (EMPTY_L l1)
        (EMPTY_M m1)
        (EMPTY_M m2)
        (on_shelf c70)
        (on_shelf c20)
        (=(at_distance c70) 10)
        (=(at_distance c20) 20)
        (=(weights c70) 70)
        (=(weights c20) 20)
        (of_group c20 A)
)

(:goal (EMPTY_L l1)
        (EMPTY_M m1)
        (EMPTY_M m2)
        (on_conveyor_belt c70)
        (on_conveyor_belt c20)

)
