# Report final project minor programming
# Jill de Ron (10553371) 

## Daily Deals - What is it? 
Websites such as Groupon, NuDeal, AmigoAmigo are tremendously popular. They offer (local) activities and products with a lot of discount. Unfortunately, these companies often work with a reserve two hours in advance principle and/or you need to take the printed coupon with you. This makes it less accessible to tourists or people who just want to do something nice right NOW. This app is the solution. Based on your preferences of what you would like to do (activities, food, shopping, party etc.) it finds activities and deals you can immediately visit or do. Only deals for that day are available. Now you know where to go and what to do for a cheap price.

Another benefit DailyDeals offers in comparison to sites as Groupon is that companies don't pay a high percentage of their income just to advertise their deal on the website. Every company can sign up and start adding specials deals. They can upload a deal immediately and enjoy all benefits the minute they post their special offer because deals and discounts are being added by companies themselves. These discount deals boost the amount of clients visiting your company. Just select the location, a time slot and the discount deal. So when a restaurant has a quiet Monday evening, they can just log in to the app, enter a deal (such as second main course for free) and wait for the costumers to come!

[![Screen Shot 2017-02-01 at 14.12.35 copy.png](https://s30.postimg.org/gf431drfl/Screen_Shot_2017_02_01_at_14_12_35_copy.png)](https://postimg.org/image/fctwiu8m5/)

## Design - How does the app work? 
To use the app you need to be logged in. So when you first start the app you start off at the log in. If you don’t have an account on Daily Deals, you can sign up. After signing up or logging in you will be send to a map centered around your current location. All the current discount deals are displayed on the map as pins. Pins from now on are called annotations. When clicked on a annotation there will appear some information about the deal. Still interested? Than you can click on the annotation and the information about the deal will be loaded in another screen. Right now this screen isn't too useful, but when expanding Daily Deals in the future this is the place to find more information aobut the deal and reserve it!

When you are a company you have two extra features on the Map screen (shown as buttons on the map). One is that you can add a deal by entering a name, the name of your company, the location, a category to which the deal belongs and the date till when the discount is valid. An annotation will be placed on the map. Available for every user to see. Another extra feature is that the company can see it's deals in a table view and delete them if they mistyped something or if you just don’t want you deal on the app anymore. 

### ViewControllers and functions
This flowchart image displays all import functions per view controller (take notice that not all functions are in the diagram) and how the view controllers work together. 

[![Diagram.png](https://s28.postimg.org/saryvoulp/Diagram.png)](https://postimg.org/image/7qn4x7euh/)

Due to a lack of space I didn’t work out my functions from the MapViewController in the diagram. So the functions included description are listed over here.
- **TypeOfUserVerification()** This function checks if the current user is a costumer or a company. When the current user signed up with a company account, two extra buttons get visible (add deal and my deals). 
- **readDatabase()** Reads in the FireDatabase and saves all the data about the deals. It also calls the addAllAnnotations() functions to place the deals on the map as well. 
- **readDatabaseAgain()** This functions needs to be there because after a deal is deleted in the MyDealsViewController, the data needs to be synced with Firebase. The only thing this function does is listen to a notification from the MyDealsViewController. The notification will be send if someone deletes a dealin MyDealsViewcontroller. Because the deal only gets deleted in Firebase, the data from Firebase and the local data on the app aren't the same anymore. So if there is a notification it calls the readDatabaseAgain() function and syncs the data from Firebase to the local data from the app.
- **addAllAnnotations()** This function loops to all deal objects and places them on the map by calling placeAnnotation()
- **reloadAnnotations()** This function needs to be there because after somebody filters deals on a certain category, only the annotations for that category need to be placed on the map. So this function deletes all excisting annotations and only reload the annotations of that category. This deal also works with a notification. When the button 'filter' is clicked in the FilterDealViewController a notification is send that calls this function. Than this function deletes all excisting annotations and calls the addAllAnnotations(), so only the annotations of the filtered category get displayed.
- **placeAnnotation()** This function is placing an annotation on the map.
- **determineMyCurrentLocation()** This functions does as it's name already suggests; it locates the location of the current user. It also calls the ceckLocationAuthorizationStatus() function to check if the user gave permission to use his or her location. 
- **checkLocationAuthorizationStatus()**

### Models
[**User**](https://github.com/Jillderon/daily-deals/blob/master/DailyDeals/User.swift)

| User          | Values        |
| ------------- |:-------------:|
| uid           | String!       |
| email         | String!       |
| type          | Int?          |

[**Deal**](https://github.com/Jillderon/daily-deals/blob/master/DailyDeals/Deal.swift)

| Deal          | Values        |
| ------------- |:-------------:|
| nameDeal      | String!       |
| nameCompany   | String!       |
| category      | String!       |
| date          | Double!       |
| uid           | String!       |
| longitude     | Double!       |
| latitude      | Double!       |

## Process - Which decisions were made?
My most important design decision was on how to let a company add the location of the deal, so that it is easy to place a pin annotation on the correct location. Right now a user with a company account adds a deal by filling in the address in the format streetname + number. So if Madame Tussauds Amsterdam would add a deal they have to fill in Dam 20 as address. This address will be transformed to a longitude and latitude (both Doubles) the minute they add the deal and saved in Firebase. This form of transformation is hardcoded (Amsterdam, the Netherlands). This hardcoding is also the reason why deals can only be located in Amsterdam. As you can see, this way of locating the pin annotations on the map is really error prone. If the company fills in the wrong address the deal won't be displayed on the map (but luckily the app won't crash either). So the user is responsible for typing in the right address. Because of that responsibility I implemented an alert where the user gets a caution about this problem. It was a design decision to save the address as longitude and latitude in Firebase instead of the streetname and number formatted as string. I first saved it as an address (String) in the Firebase Database and when retrieving the data to place it as annotations on the map the address would be transfomed to latitude and longitude. Unfortunately geocode only accepts around 3 requests per minute. So I decided to only request the geocode when adding a deal than requesting it when adding an annotation. The reason is I expect lesser adding deals per minute than requests to place a pin annotation. Because when there are 9 deals on the map of Amsterdam and everytime you open the app they have to be loaded you will immediately get an error because of the amount of requests. Of course this still isn't the most beautiful design because, as described above, it is error prone and because of the geocode request limit. When expanding this app I would definitely find another way to let companies place annotations on the map, but for now this seemed like the best solution.

Secondly another struggle was to filter the deals by category. After clicking on the filter button, only the annotations of that category must be displayed. To overcome this problem I learned how to use the NotificationCenter. Notification Center is sending a notification to the map as soon as the filter button is clicked. This notification makes sure a functions is called that removes all the annotations from the map and only places the deals of the selected category (without loading the data from Firebase again). 

My last large challange to overcome was to implement the feature that a company can decide till when a deal is valid. I had some trouble with this because in Firebase you can't save a NSDATE. Eventually I saved it in Firebase as a Double by transforming the date with timeIntervalSince1970. When reading the data from Firebase I checked if the given date (as a Double) wasn't larger than the current date (also transformed to a timeIntervalSince1970). 

Want to know more about my process? A detailed logbook of the whole process is found in the [PROCESS.md](https://github.com/Jillderon/daily-deals/blob/master/PROCESS.md) file. 

## Conclusions and future of the app - What have I learned and what happens next? 
I will go on with this app by further expanding it with nice features. Because there is so much to add to it! The first thing I will do is to let the company add a description, a maximum capacity, opening times and a picture. So when customer clicks on a pin annotation they will see more information and  a button saying ‘Reserve this deal’. Now the company knows how many new customers are coming. When the maximum capacity is reached the deal should be deleted from the map. Further expansions can even add a whole payment systems, like sites as Groupon and NuDeal also have. 
Another thing that would make my app more userfriendly is a rating system for the companies that place a deal on the app. This could be a rating system that was implemented in the app itself (so users of DailyDeals can rate companies) or a rating system loaded in from An idea is to link the Google review API to it. Another advantage of adding the Google Review API is that they can find the address of the company that adds the deal!
Small changes would be for every category an own custom pin annotation and the company can edit their own deal (when there is a typo or something).
