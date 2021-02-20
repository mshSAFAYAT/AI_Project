(define (domain restaurant_with_costs)
  (:requirements :strips :typing :action-costs :fluents)

  (:types
   location agent food - object
   waiter deliver_man  special_Van  - agent
   )


  (:predicates
   (at ?a - agent ?l - location)
   (checkIceCream ?f1 ?f2 - food)
   )

  (:functions
  (home_delivery ?l - location ?f - food) - number ;
  (quick_home_delivery ?l - location ?f - food) - number 
  (enjoy_dineIn ?l - location  ?f - food) - number 
    (free_capacity ?a - agent) - number
   (distance ?l1 ?l2 - location)  - number
   (per_km_cost ?a - agent) - number
   (foodPrice ?f - food) - number
   (total-cost) - number
   (delivery-cost) - number
   (food-cost) - number
   )


(:action deliver_At_Home
:parameters (?a - deliver_man ?l - location ?f - food)
:precondition (and (at ?a ?l) (not  (checkIceCream IceCream ?f)))
:effect (and
(when (>= (free_capacity ?a) (home_delivery ?l ?f))
(and (assign (home_delivery ?l ?f) 0)
(increase (food-cost)  (* (foodPrice ?f) (home_delivery ?l ?f)))
(decrease (free_capacity ?a) (home_delivery ?l ?f))))
(when (< (free_capacity ?a) (home_delivery ?l ?f))
(and (assign (free_capacity ?a) 0)
(increase (food-cost)  (* (foodPrice ?f) (home_delivery ?l ?f)))
(decrease (home_delivery ?l ?f) (free_capacity ?a))))

    (increase (delivery-cost) (* (distance Shop ?l) (per_km_cost ?a)))
         (increase (total-cost) (+ (delivery-cost) (food-cost)))
)
)

(:action In_Dine
:parameters (?a - waiter ?l - location ?f - food)
:precondition  (at ?a ?l) 
:effect (and
(when (>= (free_capacity ?a) (enjoy_dineIn ?l ?f))
(and (assign (enjoy_dineIn ?l ?f) 0)
(increase (food-cost)  (* (foodPrice ?f) (enjoy_dineIn ?l ?f)))
(decrease (free_capacity ?a) (enjoy_dineIn ?l ?f))))
(when (< (free_capacity ?a) (enjoy_dineIn ?l ?f))
(and (assign (free_capacity ?a) 0)
(increase (food-cost)  (* (foodPrice ?f) (enjoy_dineIn ?l ?f)))
(decrease (enjoy_dineIn ?l ?f) (free_capacity ?a))))
       (increase (total-cost) (+ (delivery-cost) (food-cost)))
)
)

(:action deliver_By_SpecialVan
:parameters (?a - special_Van  ?l - location ?f - food)
:precondition  (at ?a ?l) 
:effect (and
(when (>= (free_capacity ?a) (quick_home_delivery ?l ?f))
(and (assign (quick_home_delivery ?l ?f) 0)
(increase (food-cost)  (* (foodPrice ?f) (quick_home_delivery ?l ?f)))
(decrease (free_capacity ?a) (quick_home_delivery ?l ?f))))
(when (< (free_capacity ?a) (quick_home_delivery ?l ?f))
(and (assign (free_capacity ?a) 0)
(increase (food-cost)  (* (foodPrice ?f) (quick_home_delivery ?l ?f)))
(decrease (quick_home_delivery ?l ?f) (free_capacity ?a))))
    (increase (delivery-cost) (* (distance Shop ?l) (per_km_cost ?a)))
         (increase (total-cost) (+ (delivery-cost) (food-cost)))
)
)


  (:action drive
   :parameters (?a - agent ?from ?to - location)
   :precondition (at ?a ?from)
   :effect (and (not (at ?a ?from))
		(at ?a ?to)
		)
   )
   
  ; (:action drive_Van
  ; :parameters (?a - deliver_man ?from ?to - location)
  ; :precondition (at ?a ?from)
  ; :effect (and (not (at ?a ?from))
;		(at ?a ?to)
;		)
 ;  )

  )
