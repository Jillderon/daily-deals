# Report final project minor programming
# Jill de Ron (10553371) 

## Daily Deals - What is it? 
Websites such as Groupon, NuDeal, AmigoAmigo are tremendously popular. They offer (local) activities and products with a lot of discount. Unfortunately, these companies often work with a reserve two hours in advance principle and/or you need to take the printed coupon with you. This makes it less accessible to tourists or people who just want to do something nice right NOW. This app is the solution. Based on your preferences of what you would like to do (activities, food, shopping, party etc.) it finds activities and deals you can immediately visit or do. Only deals for that day are available. Now you know where to go and what to do for a cheap price.

Another benefit DailyDeals offers in comparison to sites as Groupon is that companies don't pay a high percentage of their income just to advertise their deal on the website. Every company can sign up and start adding specials deals. They can upload a deal immediately and enjoy all benefits the minute they post their special offer because deals and discounts are being added by companies themselves. These discount deals boost the amount of clients visiting your company. Just select the location, a time slot and the discount deal. So when a restaurant has a quiet Monday evening, they can just log in to the app, enter a deal (such as second main course for free) and wait for the costumers to come!

[![Screen Shot 2017-02-01 at 14.12.35 copy.png](https://s30.postimg.org/gf431drfl/Screen_Shot_2017_02_01_at_14_12_35_copy.png)](https://postimg.org/image/fctwiu8m5/)

## Design - How does the app work? 
To give a global idea about my app. To use the app you need to be logged in. So when you first start the app you start of at the log in. If you don’t have an account on Daily Deals, you can sign up. After signing up or logging in you will be send to a map centered around your current location. All the current discount deals are displayed on the map as pins. When clicked there will appear some information about the deal. Still interest? Than you can click on the annotation and the information about the deal will be loaded in another screen. 

When you are a company you have two extra features (shown as buttons on the map). One is that you can add a deal by entering a name, the name of your company, the location, a category to which the deal belongs and the date till when the discount is valid. A pin will be placed on the map. Available for every user to see. Another extra features is that you can see you deals in a table view and delete them if you mistyped something or if you just don’t want you deal on the app anymore. 

### Modules
[![Untitled Diagram.png](https://s23.postimg.org/asll7jlyj/Untitled_Diagram.png)](https://postimg.org/image/6jgv5dip3/)

* Due to a lack of space I didn’t work out my functions from the MapViewController in the diagram. So the functions included description are listed over here.
- **TypeOfUserVerification()**
- **readDatabase()**
- **readDatabaseAgain()**
- **reloadPins()**
- **addAllPins()**
- **placeAnnotation()**
- **determineMyCurrentLocation()**
- **checkLocationAuthorizationStatus()**

### Classes

## Process - Which decisions were made?
Clearly describe challenges that you have met during development. Document all important changes that you have made with regard to your design document (from the PROCESS.md). Here, we can see how much you have learned in the past month.

Defend your decisions by writing an argument of a most a single paragraph. Why was it good to do it different than you thought before? Are there trade-offs for your current solution? In an ideal world, given much more time, would you choose another solution?

## Conclusions and future of the app - What have I learned and what happens next? 
I will go on with this app by further expanding it with nice features. Because there is so much to add to it! The first thing I will do is to let the company add a description, a maximum capacity, opening times and a picture. So when customer clicks on the annotation they will see more information and  a button saying ‘Reserve this deal’. Now the company knows how many new customers are coming. When the maximum capacity is reached the deal should be deleted from the map. 

Other changes would for every category an own custom pin annotation, the company can edit their own deal (when there is a typo or something) and the way to store the location. For now it was a design decisions I made, but if I would further expand this app I would choose a way that is less error prone. 
