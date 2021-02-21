(define (domain restaurant_with_costs)
  (:requirements :strips :typing :action-costs :fluents)

  (:types  ;;3 types of object used here
   location agent food - object
   ;; 3 subtypes of agent 
   waiter deliver_man  special_Van  - agent
   )

  (:predicates
   (at ?a - agent ?l - location)  ; agent's location
   (checkIceCream ?f1 ?f2 - food) ; check if foodItem is IceCream
   )

  (:functions  ;number for integer(numerics)
  
  ;; functions for delivery sevices,takes location and food item
  (home_delivery ?l - location ?f - food) - number ;
  (quick_home_delivery ?l - location ?f - food) - number 
  (enjoy_dineIn ?l - location  ?f - food) - number 
  
  ;;function for free capacity of an agent
    (free_capacity ?a - agent) - number
    
  ;;for distance of 2 locations
   (distance ?l1 ?l2 - location)  - number
   
  ;;for checking agent's per_km_cost
   (per_km_cost ?a - agent) - number
   
  ;; for price of food item
   (foodPrice ?f - food) - number
   
  ;; cost functions for calculating food, delivery and total cost
   (total-cost) - number
   (delivery-cost) - number
   (food-cost) - number
   )

;; For home delivery ,IceCream cannot be ordered.
(:action deliver_At_Home
:parameters (?a - deliver_man ?l - location ?f - food)

;;Cheking agent's loaction and food item
:precondition (and (at ?a ?l) (not  (checkIceCream IceCream ?f)))

:effect (and	;checking agent's capacity and do delivery
(when (>= (free_capacity ?a) (home_delivery ?l ?f))
(and (assign (home_delivery ?l ?f) 0)

;food cost calculation
(increase (food-cost)  (* (foodPrice ?f) (home_delivery ?l ?f))) 
(decrease (free_capacity ?a) (home_delivery ?l ?f))))
(when (< (free_capacity ?a) (home_delivery ?l ?f))
(and (assign (free_capacity ?a) 0)

;food cost calculation
(increase (food-cost)  (* (foodPrice ?f) (home_delivery ?l ?f)))
(decrease (home_delivery ?l ?f) (free_capacity ?a))))

;delivery cost calculation
    (increase (delivery-cost) (* (distance Shop ?l) (per_km_cost ?a)))
    ;total cost calculation
         (increase (total-cost) (+ (delivery-cost) (food-cost)))
))

;; For Dine_In, All food item can be ordered.No delivery charge
(:action In_Dine
:parameters (?a - waiter ?l - location ?f - food)

;;Cheking agent's loaction
:precondition  (at ?a ?l) 

:effect (and ;checking agent's capacity and do delivery
(when (>= (free_capacity ?a) (enjoy_dineIn ?l ?f))
(and (assign (enjoy_dineIn ?l ?f) 0)

;food cost calculation
(increase (food-cost)  (* (foodPrice ?f) (enjoy_dineIn ?l ?f)))
(decrease (free_capacity ?a) (enjoy_dineIn ?l ?f))))
(when (< (free_capacity ?a) (enjoy_dineIn ?l ?f))
(and (assign (free_capacity ?a) 0)

;food cost calculation
(increase (food-cost)  (* (foodPrice ?f) (enjoy_dineIn ?l ?f)))
(decrease (enjoy_dineIn ?l ?f) (free_capacity ?a))))
    ;total cost calculation
       (increase (total-cost) (+ (delivery-cost) (food-cost)))
))

;; For Special or fast delivery ,IceCream cannot be ordered.
(:action deliver_By_SpecialVan
:parameters (?a - special_Van  ?l - location ?f - food)

;;Cheking agent's loaction and food item
:precondition (and (at ?a ?l) (not  (checkIceCream IceCream ?f)))

:effect (and	;checking agent's capacity and do delivery
(when (>= (free_capacity ?a) (quick_home_delivery ?l ?f))
(and (assign (quick_home_delivery ?l ?f) 0)

;food cost calculation
(increase (food-cost)  (* (foodPrice ?f) (quick_home_delivery ?l ?f)))
(decrease (free_capacity ?a) (quick_home_delivery ?l ?f))))
(when (< (free_capacity ?a) (quick_home_delivery ?l ?f))
(and (assign (free_capacity ?a) 0)

;food cost calculation
(increase (food-cost)  (* (foodPrice ?f) (quick_home_delivery ?l ?f)))
(decrease (quick_home_delivery ?l ?f) (free_capacity ?a))))

    ;delivery cost calculation
    (increase (delivery-cost) (* (distance Shop ?l) (per_km_cost ?a)))
        
        ;total cost calculation
         (increase (total-cost) (+ (delivery-cost) (food-cost)))
)
)

;;For delivering food by special_van , delivery_van
  (:action drive
   :parameters (?a - agent ?from ?to - location)
   :precondition (at ?a ?from)
   :effect (and (not (at ?a ?from))
		(at ?a ?to)
		)
   )  

  )
