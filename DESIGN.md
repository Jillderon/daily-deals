# Design DailyDeals 
Because this app is centered both around clients as around companies, there are two kinds of accounts:
1. Client account
2. Business account 

## Diagram of classes 
* Login ViewController
* SignUp ViewController
* Map ViewController
* AddDeal ViewController
* SearchDeal ViewController 
* InformationDeal ViewController

[![Screen Shot 2017-01-11 at 15.13.09.png](https://s27.postimg.org/8bqddhkcz/Screen_Shot_2017_01_11_at_15_13_09.png)](https://postimg.org/image/xhrbkbln3/)

## Sketches UI of the SearchDeal VC, Map VC and InformationDeal VC
[![Screen Shot 2017-01-13 at 11.14.03.png](https://s28.postimg.org/tlqe7v5jx/Screen_Shot_2017_01_13_at_11_14_03.png)](https://postimg.org/image/v0rywl6mx/)

1. Search Viewcontroller. A Screen where you can add your preferences (activities, festivals, dinner etc) through a drop-down menu.
2. Map Viewcontroller. Map of Amsterdam with pins representing activities of the user's preference.  When clicked on a pin, more detailed information about that activity will be loaded. There is also a 'more information' option and when clicked the user is send to the InformationDeal ViewController. You can also navigate across the map and new pins will automatically appear.
3. InformationDeal ViewController. More information about a deal and here a user can click 'Get the deal' so they are registered to that particular deal. 

## APIs and frameworks or plugins
To create this app the UIKit and UIMapKit library will be used. UIMapKit will be used to determine the current location of the user and to place activities and deals on the map. Firebase will be used to save preferences of users. 

## Possible limitations
The result of a search are shown as pins on a map of Amsterdam. There are probably some difficulties with loading the pins on the map, because it has to be close to the current location of the user. And the user can navigate, zoom-in and zoom-out, still displaying and updating all the pins on the map.

## Components used
To visualize activities as marking points on a map of Amsterdam, one internal (built-in) component is used: Map Kit Framework
To subsribe users Firebase will be used.

## Similar application
A similar application is the WeCity app. WeCity uses a specially designed algorithm to deliver tailored travel tips and recommendations. But it doesn't show (temporary) deals and as a business you can't add your company as an interesting activity!
