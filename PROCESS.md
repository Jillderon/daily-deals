#Process Document - Jill de Ron - UvA Amsterdam - 2017
This document will provide as a logbook for the overall process of the final project for Minor Programming

## Monday day 1 - 09/01/2017: 
- Brainstorming about idea for final project
- Setup Github repository
- Add README.md
- Setup xcode project

## Tuesday day 2 - 10/01/2017: 
- First meeting 
- Desiging lay-out project - making sketches of UI

## Wednesday day 3 - 11/01/2017:
- Setting up Firebase
- Making log in and sign up screen (and add functionality Firebase)

## Thursday day 4 - 12/01/2017
- Setup MapKit
- zoom in to current location of the user and show this location on the map 

## Friday day 5 - 13/01/2017
- Design document and prototype complete 
- pickerview with categories in AddDealViewController (https://www.youtube.com/watch?v=oHkEUibsShM)

## Monday day 6 - 16/01/2017
- Sending addDeal data to Firebase

## Tuesday day 7 - 17/01/2017
- Add content PROCESS.md 
- get addDeal data back from Firebase Database 
- Hide navigation bar at MapViewController (http://stackoverflow.com/questions/29209453/how-to-hide-a-navigation-bar-from-first-viewcontroller-in-swift)
- From address to longitude and latitude: 
  https://cocoacasts.com/forward-and-reverse-geocoding-with-clgeocoder-part-1/
  http://stackoverflow.com/questions/38156145/mapkit-swift-converting-address-to-coordinated

## Wednesday day 8 - 18/01/2017
- Two different accounts needed. One for the users and one for companies. You need a segmented controller in the register (https://www.ioscreator.com/tutorials/segmented-control-tutorial-ios8-swift)
- Working on stylebook 
- Didn't work out: pickerview with dates in AddDealViewController, so you can remove annotations after some given time (added by the company as a date + time) 
http://stackoverflow.com/questions/32135771/mkmapview-add-annotation-and-remove-it-after-some-time/3213605 (https://www.ioscreator.com/tutorials/display-date-date-picker-ios8-swift)

## Tuesday day 9 - 19/01/2017 
- Working on stylebook 
- Hide addDealButton for user account (http://stackoverflow.com/questions/30065010/how-to-hide-show-a-button-in-swift)
- State restoration (https://www.raywenderlich.com/117471/state-restoration-tutorial)
- Add sign out 
- Segue information form the SearchDealViewController to the MapViewController. Is needed to filter deals later on. 


## Friday day 10 - 20/01/2017
- Ask Julian: pickerview with dates in AddDealViewController, so you can remove annotations after some given time (added by the company as a date + time) 
- I want to filter different deals trough categories. So I need to know how to filter data I get from Firebase (http://stackoverflow.com/questions/39647742/how-to-filter-firebase-data-in-swift). This goes wrong!! When you click on filter and the map opens again, the first time only two pins are displayed and the second time you filter and go to the map again, zero pins are displayed!! I don't seem to understand why this happens. 
- Change color of the pickerView to white (http://stackoverflow.com/questions/40928383/how-to-change-the-font-color-inside-a-picker-view-swift) and also of the datePicker (http://stackoverflow.com/questions/28417217/set-text-color-and-font-for-uidatepicker-in-ios8-swift)

## Monday day 11 - 23/01/2017 
- I'm stuck on two functionality things. so I'm creating an app icon (https://makeappicon.com/) so I get the feeling that at least I got something accomplished today. 



