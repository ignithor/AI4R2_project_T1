(define (domain <warehouse_planning>)
  (:requirements :typing :durative-actions :negative-preconditions :numeric-fluents)    ;;What functions we use 
  
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

(:action put_down 
  :parameters (?r -mover ?c - crate ?l - location)
  :precondition (and 
  (robot_at ?r ?l)
  (mover_carrying ?r ?c)
  )
  :effect (and 
  (crate_at ?c ?l)
  (not(mover_carrying ?r ?c))
  )
)

    
    
  (:durative-action move_empty    
    :parameters (?r - mover ?from - location ?to -location)
    (= ?duration (/ (distance ?from ?to) 10))
    
    :condition (and          ;; What must be true for the action to start
    (at start (robot_at ?r ?from))
    (at start (not (exists (?c - crate) (mover_carrying ?r ?c))))   ;;Robot needs to be empty
    )
    
    :effect (and         ;;What is being changed in the world due to the action
    (at start (not(robot_at ?r ?from)))
    (at end (robot_at ?r ?to))
    )
  )
  
  (:durative-action load_crate 
  :parameters (?l - loader ?c -crate)
  :duration (= ?duration 4)
  
  :condition (and 
  (at start (on_loading_bay ?c ))
  (at start (loader_available ?l))
  )
  
  :effect (and
    (at start (not (loader_available ?l)))  
    (at end (loaded ?c))                    
    (at end (loader_available ?l))      
    (at end (not (on_loading_bay ?c)))  
  )
)



)




