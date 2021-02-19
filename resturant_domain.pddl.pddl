;; Final formulation of the linehaul domain (with types and costs),


(define (domain restaurant_with_costs)
  (:requirements :strips :typing :action-costs)

  (:types
   location agent quantity food - object
   waiter deliver_man rocket_Delivery - agent
   )

  ;; Alternative way of writing type declaration:
  ;; (:types
  ;;  refrigerated_truck - truck
  ;;  location truck quantity
  ;;  )

  (:predicates
   (at ?t - agent ?l - location)
   (free_capacity ?t - agent ?q - quantity)
   (demand_home_foods ?l - location ?q - quantity ?f - food)
   (demand_dineIn_foods ?l - location ?q - quantity ?f - food)
  ; (demand_quick_goods ?l - location ?q - quantity ?f -food)
   (plus1 ?q1 ?q2 - quantity)
   (checkn0 ?q1 ?q2 - quantity)
   (checkIceCream ?f1 ?f2 - food)
   )

  (:functions
   (distance ?l1 ?l2 - location)
   (per_km_cost ?t - agent)
   (foodPrice ?f - food)
   (total-cost)
   (delivery-cost)
   (food-cost)
   )


;; For Home Delivery
  ;; The effect of the delivery action is to decrease demand at
  ;; ?l and free capacity of ?t by one.
  (:action deliver_At_Home
   :parameters (?t - deliver_man ?l - location
		?d ?d_less_one ?c ?c_less_one - quantity ?f - food)
   :precondition (and (at ?t ?l)
		      (demand_home_foods ?l ?d ?f)
		      (not  (checkIceCream IceCream ?f))
		      (free_capacity ?t ?c)
		      (plus1 ?d_less_one ?d)  ;; only true if ?d > n0
		      (plus1 ?c_less_one ?c))  ;; only true if ?c > n0
   :effect (and (not (demand_home_foods ?l ?d ?f))
		(demand_home_foods ?l ?d_less_one ?f)
		(increase (food-cost)  (foodPrice ?f))
		(not (free_capacity ?t ?c))
		(free_capacity ?t ?c_less_one)
		;(forall (?d ?d_less_one  - quantity)
        (when  (checkn0 ?d_less_one ?d_less_one)
         ( and
            (increase (delivery-cost) (* (distance Shop ?l) (per_km_cost ?t)))
                (increase (total-cost) (+ (delivery-cost) (food-cost)))

          ) )
  ) )

;; For Dine_In
  (:action deliverORoder_In_Dine
   ;; Note type restriction on ?t: it must be a refrigerated truck.
   :parameters (?t - agent ?l - location
		?d ?d_less_one ?c ?c_less_one - quantity ?f - food)
   :precondition (and (at ?t ?l)
		      (demand_dineIn_foods ?l ?d ?f)
		      (free_capacity ?t ?c)
		      (plus1 ?d_less_one ?d)  ;; only true if ?d > n0
		      (plus1 ?c_less_one ?c))  ;; only true if ?c > n0
   :effect (and ;(not (demand_chilled_goods ?l ?d ?f))
		(demand_dineIn_foods ?l ?d_less_one ?f)
		(increase (food-cost)  (foodPrice ?f))
		(not (free_capacity ?t ?c))
		(free_capacity ?t ?c_less_one)
		 (when  (checkn0 ?d_less_one ?d_less_one)
         ( and
            ;(increase (delivery-cost) (* (distance ?from ?to) (per_km_cost ?t)))
                (increase (total-cost) (+ (delivery-cost) (food-cost)))

          ) ))
   )
   
;   ;; For Quick Delivery
;     (:action deliver_Argent
;   :parameters (?t - rocket_Delivery ?l - location
; 		?d ?d_less_one ?c ?c_less_one - quantity ?f - food)
;   :precondition (and (at ?t ?l)
; 		      (demand_quick_goods ?l ?d ?f)
; 		      (free_capacity ?t ?c)
; 		      (plus1 ?d_less_one ?d)  ;; only true if ?d > n0
; 		      (plus1 ?c_less_one ?c))  ;; only true if ?c > n0
;   :effect (and (not (demand_quick_goods ?l ?d ?f))
; 		(demand_quick_goods ?l ?d_less_one ?f)
; 		(increase (food-cost)  (foodPrice ?f))
; 		(not (free_capacity ?t ?c))
; 		(free_capacity ?t ?c_less_one)
; 		(when  (checkn0 ?d_less_one ?d_less_one)
;          ( and
;             (increase (delivery-cost) (* (distance ?from ?to) (per_km_cost ?t)))
;                 (increase (total-cost) (+ (delivery-cost) (food-cost)))

;           ) ))
;   )

  (:action drive
   :parameters (?t - agent ?from ?to - location)
   :precondition (at ?t ?from)
   :effect (and (not (at ?t ?from))
		(at ?t ?to)
		;(increase (total-cost) (* (distance ?from ?to) (per_km_cost ?t)))
		)
   )

  )
