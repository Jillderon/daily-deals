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
- I want to filter different deals trough categories. So I need to know how to filter data I get from Firebase (http://stackoverflow.com/questions/39647742/how-to-filter-firebase-data-in-swift). This goes wrong!! When you click on filter and the map opens again, the first time only two pins are displayed and the second time you filter and go to the map again, zero pins are displayed!! I don't seem to understand why this happens. 
- Change color of the pickerView to white (http://stackoverflow.com/questions/40928383/how-to-change-the-font-color-inside-a-picker-view-swift) and also of the datePicker (http://stackoverflow.com/questions/28417217/set-text-color-and-font-for-uidatepicker-in-ios8-swift)

## Monday day 11 - 23/01/2017 
- I'm creating an app icon (https://makeappicon.com/) so I get the feeling that at least I got something accomplished today. 
- Add pictures to my storyboard (the four little canal houses)
- costum image annotation -> https://www.mapbox.com/ios-sdk/examples/marker-image/ OR https://littlebitesofcocoa.com/70-custom-map-view-pins. I made my custom annotations with https://logomakr.com/
- After filtering different deals by category, new pins don't get displayed on the map. I think 'remove all annotations' is the problem. Probably you can't reuse an already used and removed pin. How to fix this? Fixed this with help from Julian (NotificationCenter and popping things of the view)!!

## Tuesday day 12 - 24/01/2017
- Filtering deals isn't working correctly! HELP!!!! Sometimes it does and than it doens't. Driving me crazy. After a while of testing filtering it shows: Unable to Forward Geocode Address (Error Domain=kCLErrorDomain Code=2 "(null)") (http://stackoverflow.com/questions/17867422/kclerrordomain-error-2-after-geocoding-repeatedly-with-clgeocoder) or it shows at the beginning: ERROR /BuildRoot/Library/Caches/com.apple.xbs/Sources/VectorKit_Sim/VectorKit-1230.32.8.29.9/GeoGL/GeoGL/GLCoreContext.cpp 1764: WARNING: Output of vertex shader 'v_gradient' not read by fragment shader (http://stackoverflow.com/questions/39608231/warning-output-of-vertex-shader-v-gradient-not-read-by-fragment-shader). Both warnings don't seem to be due to uncorrect coding but are Xcode problems.  

## Wednesday day 13 - 25/01/2017 
- Custom annotation on the MapView, but not for different categories different images per pin -> http://stackoverflow.com/questions/38274115/ios-swift-mapkit-custom-annotation -> I did the excact same thing but it doens't work!! 
- set Navigation Bar to transparent and back button to white. Thanks to Femke van Son!
- The company who is adding a deal can now indicate till when a deal is valid. When the current date is past the valid date the deal will be deleted from Firebase. 
    DATE references: 
        * http://stackoverflow.com/questions/36476826/how-to-deal-with-nsdate-and-firebase
        * http://stackoverflow.com/questions/29502186/get-just-the-date-no-time-from-uidatepicker
        Working! Only thing that bothers me is that the date of deals only gets checked in viewDidLoad

## Thursday day 14 - 26/01/2017
- Make it possible to click on an event and to reserve a place!! 
  http://stackoverflow.com/questions/40478120/mkannotationview-swift-adding-info-button
  But there are some problems with this, because I want to add more information to the InformationDealViewController than there is in the annotation. How to get information from Firebase? You can do this by name of the deal, but what happens if there are two deals who have the samen name? Than Firebase will 

## Friday day 15 - 27/01/2017 
- Presentations
- I did the codebetter analysis 
- I think it, timewise, it is not realistic to add a maximum capacity to the deal and hide the deal when maximum capactiy is reached. This makes my InformationDealViewController right now a little bit unneccessary, but it is still nice to have so I don't need to make it when I'm expanding the app with extra features

## Monday day 16 - 30/01/2017 
- Cleaning up my code trhough the advice of better code hub
- Adding in the function to reset your password (http://stackoverflow.com/questions/35808352/firebase-reset-password-swift). Validation email didn't work out. 
- Found a bug -> With my pickerView if I select nothing (and standard it stands on the category 'activities'), it will send an 0 and shopping will be selected!! 
- Found another bug :( -> Sometimes you have to log out twice. I really don't know why this is happening. I think I fixed this one!! It has to do with preforming segues. I had a segue that was on 'show' and I changed it to 'present modally'

## Tuesday day 17 - 31/01/2017 
- add alert for the right date format
- Today I'm going to add my last functionality. For the '



