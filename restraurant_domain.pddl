(define (domain restaurant)
  (:requirements :strips :typing :action-costs)

  (:types
   location food agent quantity - object
   burger coke ice_cream - food
   waiter deliver_man - agent
   )

  (:predicates
   (at ?a - agent ?l - location)
   (dine_In ?l - location ?q - quantity ?f - food)
   (take_away ?l - location ?q - quantity ?f - food)
   (plus1 ?q1 ?q2 - quantity)
   )

  (:functions
   (delivery_cost ?l1 ?l2 - location)
   (food_cost ?f - food)
   (total-cost)
   )

  
 