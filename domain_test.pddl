(define (domain warehouse_planning)
  (:requirements :typing :negative-preconditions)    ;;What functions we use 
  
  (:types       ;; What object types exist 
    robot
    mover loader - robot    
    crate 
    light_crate heavy_crate - crate
    location)               
  (:predicates                              ;;States which either are true or false 
    (robot_at ?r - robot ?l - location)     ;; Name of predicate is always in front 
    (crate_at ?c - crate ?l - location)
    (mover_carrying ?r - mover ?c - crate)
    (loaded ?c - crate)
    (on_loading_bay ?c - crate)
    )
    
  (:functions   ;; Numerics - weight and distance 
    (weight ?c - crate)                             
    (distance ?from - location ?to - location)    
    ;;(time)                                    
    )        

  (:action pick_up_single 
    :parameters (?r - mover ?c - crate ?l - location)
    :precondition (and
      (robot_at ?r ?l)               
      (crate_at ?c ?l)               
      (not (exists (?x - crate) (mover_carrying ?r ?x)))
    )
    :effect (and
      (mover_carrying ?r ?c)        
      (not (crate_at ?c ?l))  
    )
  )

  (:action pick_up_dual
    :parameters (?r1 - mover ?r2 - mover ?c - crate ?l - location)
    :precondition (and
      (robot_at ?r1 ?l)
      (robot_at ?r2 ?l)
      (crate_at ?c ?l)
      (not (exists (?x - crate) (mover_carrying ?r1 ?x)))
      (not (exists (?x - crate) (mover_carrying ?r2 ?x)))
    )
    :effect (and
      (mover_carrying ?r1 ?c)
      (mover_carrying ?r2 ?c)
      (not (crate_at ?c ?l))
    )
  )
)
