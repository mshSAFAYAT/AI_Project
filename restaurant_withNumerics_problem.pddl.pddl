
(define (problem restaurant_example)
  (:domain restaurant_with_costs)

  (:objects
    ;Rocket Parcel
    Special_DVan - special_Van
    Delivery_Van - deliver_man
    By_Waiter - waiter
    Normal_Agent waiter deliver_man special_Van - agent
    Shop Firigi_Bazar Custom_Bazar Reazuddin_Bazar Station_Road - location
    Burger Pitha IceCream - food
    
    )

  (:init
    (at Delivery_Van Shop)
    (at Normal_Agent Shop)
    (at By_Waiter Shop)
    (at Special_DVan Shop)
    (= (free_capacity Delivery_Van) 30)
    (= (free_capacity By_Waiter) 30)
    (= (free_capacity Normal_Agent) 0)
    (= (free_capacity Special_DVan) 10)
    (= (quick_home_delivery Reazuddin_Bazar Pitha) 2)
     (= (quick_home_delivery Firigi_Bazar Burger) 1)
    (= (home_delivery Firigi_Bazar Pitha) 1)   
     (= (home_delivery Custom_Bazar Burger) 2)
     (= (enjoy_dineIn Shop IceCream) 1)    
    ( checkIceCream IceCream IceCream )
   ; (= (distance Shop Shop) 0)
    (= (distance Shop Firigi_Bazar) 5)
    (= (distance Shop Custom_Bazar) 10)
    (= (distance Shop Reazuddin_Bazar) 7)
    (= (distance Shop Station_Road) 6)
    (= (distance Firigi_Bazar Shop) 5)
    (= (distance Firigi_Bazar Firigi_Bazar) 0)
    (= (distance Firigi_Bazar Custom_Bazar) 16)
    (= (distance Firigi_Bazar Reazuddin_Bazar) 2)
    (= (distance Firigi_Bazar Station_Road) 3)
    (= (distance Custom_Bazar Shop) 10)
    (= (distance Custom_Bazar Firigi_Bazar) 16)
    (= (distance Custom_Bazar Custom_Bazar) 0)
    (= (distance Custom_Bazar Reazuddin_Bazar) 13)
    (= (distance Custom_Bazar Station_Road) 14)
    (= (distance Reazuddin_Bazar Shop) 7)
    (= (distance Reazuddin_Bazar Firigi_Bazar) 2)
    (= (distance Reazuddin_Bazar Custom_Bazar) 13)
    (= (distance Reazuddin_Bazar Reazuddin_Bazar) 0)
    (= (distance Reazuddin_Bazar Station_Road) 1)
    (= (distance Station_Road Shop) 6)
    (= (distance Station_Road Reazuddin_Bazar) 1)
    (= (distance Station_Road Firigi_Bazar) 3)
    (= (distance Station_Road Custom_Bazar) 14)
    (= (distance Station_Road Station_Road) 0)
    (= (per_km_cost Normal_Agent) 0)
    (= (per_km_cost Delivery_Van) 3)
    (= (per_km_cost By_Waiter) 0)
    (= (per_km_cost Special_DVan) 6)
    (= (foodPrice Burger) 35)
    (= (foodPrice Pitha) 20)
    (= (foodPrice IceCream) 25)
    (= (total-cost) 0)
    (= (delivery-cost) 0)
    (= (food-cost) 0)
    )

   (:goal ( and 
   	     (<= (quick_home_delivery Reazuddin_Bazar Pitha) 0)
             (<= (quick_home_delivery Firigi_Bazar Burger) 0)
             (<= (home_delivery Firigi_Bazar Pitha) 0)   
             (<= (home_delivery Custom_Bazar Burger) 0)
             (<= (enjoy_dineIn Shop IceCream) 0)           
              (at Special_DVan Shop)
              (at Delivery_Van Shop)
              (at Normal_Agent Shop)
              (at By_Waiter Shop))
	 )

  (:metric minimize (total-cost))

  )
