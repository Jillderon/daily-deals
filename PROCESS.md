#Process Document - Jill de Ron - UvA Amsterdam - 2017
This document will provide as a logbook for the overall process of the final project for Minor Programming

## Monday day 1 - 09/01/2017: 
- Brainstorming about idea for final project. 
- Setup Github repository. 
- Add README.md.
- Setup xcode project.

## Tuesday day 2 - 10/01/2017: 
- First meeting with the IOS group. 
- Desiging lay-out project - making sketches of UI. 
- I first wanted to used the [Amsterdam API](https://data.amsterdam.nl/index.html#?dsd=catalogus&dsp=1&dsv=CARDS&mpb=topografie&mpz=9&mpv=52.3719:4.9012) to load in activities and thing to do. But the API didn't consist of enough information about an activity and I had to skip my idea about 'discount deals'. One of the supervisors helped me a lot with working out my idea. I decided that companies can add deals themselves so I don't have to work with an API. 

## Wednesday day 3 - 11/01/2017:
- Setting up Firebase. Installing pods took hours! 
- Making log in and sign up screen (and add functionality Firebase). This was relatively easy because I remember how it was done in [pset 6](https://github.com/Jillderon/pset6) and Ray Wenderlich has this nice [Firebase tutorial](https://www.raywenderlich.com/139322/firebase-tutorial-getting-started-2)

## Thursday day 4 - 12/01/2017
- Setup MapKit. 
- Zoom in to current location of the user and show this location on the map. I found a [Ray Wenderlich tutorial](https://www.raywenderlich.com/90971/introduction-mapkit-swift-tutorial)

## Friday day 5 - 13/01/2017
- Design document and prototype complete. 
- Pickerview with categories in AddDealViewController. I watched [a tutorial on YouTube](https://www.youtube.com/watch?v=oHkEUibsShM).

## Monday day 6 - 16/01/2017
- Sending addDeal data to Firebase. Oops, I forgot how this worked and it took all day. 

## Tuesday day 7 - 17/01/2017
- Add content PROCESS.md 
- Get addDeal data back from Firebase Database. I checked my [pset 6](https://github.com/Jillderon/pset6) app to know how to get information back from Firebase. 
- [Hide navigation bar at MapViewController](http://stackoverflow.com/questions/29209453/how-to-hide-a-navigation-bar-from-first-viewcontroller-in-swift)
- From address to longitude and latitude. Rick and Martijn are working on geocoding as well, but they are doing it the other way around. I found two helpful websites: 
  ..* [Cocoacasts](https://cocoacasts.com/forward-and-reverse-geocoding-with-clgeocoder-part-1/)
  ..* [Stack overflow](http://stackoverflow.com/questions/38156145/mapkit-swift-converting-address-to-coordinated)

## Wednesday day 8 - 18/01/2017
- Two different accounts needed. One for the users and one for companies. You need a [segmented controller](https://www.ioscreator.com/tutorials/segmented-control-tutorial-ios8-swift) in the register.
- Working on stylebook with the group. 
-  Wanting to add a new functionality: [Pickerview](https://www.ioscreator.com/tutorials/display-date-date-picker-ios8-swift) with dates in AddDealViewController, so you can [remove annotations after some given time](http://stackoverflow.com/questions/32135771/mkmapview-add-annotation-and-remove-it-after-some-time/3213605. Added by the company as a date + time through the pickerView. Didn't work out yet. I will leave it for now I will later continue trying to implement this.

## Tuesday day 9 - 19/01/2017 
- Working on stylebook with the group. 
- Jasper helped me with some ideas of how to let the two account differ (consument and company account). He told me I could simply check my account type and hide some buttons for the consument account. So today I [hide my addDealButton](http://stackoverflow.com/questions/30065010/how-to-hide-show-a-button-in-swift) for consument account. This is an easy way to make sure only people with a company acount can add deals. 
- [State restoration](https://www.raywenderlich.com/117471/state-restoration-tutorial) and adding sign out. For both functionalities I checked my [pset 6](https://github.com/Jillderon/pset6). 
- Segue information form the SearchDealViewController to the MapViewController. Is needed to filter deals later on. Aynel helped me with a segue because she already did this a lot in her app. 

## Friday day 10 - 20/01/2017
- I want to filter different deals trough categories. So I need to know how to [filter data I get from Firebase](http://stackoverflow.com/questions/39647742/how-to-filter-firebase-data-in-swift). This goes wrong!! When you click on filter and the map opens again, the first time only two pins are displayed and the second time you filter and go to the map again, zero pin annotations are displayed!! I don't seem to understand why this happens. I will ask this on Julian on monday or tuesday and go on with other things right now, because I really tried and nothing seems to work. 
- [Change color of the pickerView to white](http://stackoverflow.com/questions/40928383/how-to-change-the-font-color-inside-a-picker-view-swift) and also of the [datePicker](http://stackoverflow.com/questions/28417217/set-text-color-and-font-for-uidatepicker-in-ios8-swift). I got both helpful websites from Femke. 

## Monday day 11 - 23/01/2017 
- I'm creating an app icon with the help of Rick. On a site called [makeappicon](https://makeappicon.com/) 
- Add pictures to my storyboard (the four little canal houses). I made this picture with https://logomakr.com/
- After filtering different deals by category, new pin annotations don't get displayed on the map. I think 'remove all annotations' is the problem. Probably you can't reuse an already used and removed pin. How to fix this? Fixed this with help from Julian (NotificationCenter and popping things of the view). So it had nothing to do with removing pins from the map. 

## Tuesday day 12 - 24/01/2017
- Filtering deals isn't working correctly! HELP!!!! Sometimes it does and than it doens't. Driving me crazy. After a while of testing filtering it shows two errors: 

Unable to Forward Geocode Address (Error Domain=kCLErrorDomain Code=2 "(null)")

ERROR /BuildRoot/Library/Caches/com.apple.xbs/Sources/VectorKit_Sim/VectorKit-1230.32.8.29.9/GeoGL/GeoGL/GLCoreContext.cpp 1764: WARNING: Output of vertex shader 'v_gradient' not read by fragment shader  

I looked both errors up on Stack overflow. [The first one](http://stackoverflow.com/questions/17867422/kclerrordomain-error-2-after-geocoding-repeatedly-with-clgeocoder) is a problem with geocoding itself. You just can request so many locations in a minute. [The other one](http://stackoverflow.com/questions/39608231/warning-output-of-vertex-shader-v-gradient-not-read-by-fragment-shader) is due to the fact that I'm testing my app on a simulator. So, both warnings don't seem to be due to uncorrect coding but are other problems. So I won't bother too much.

## Wednesday day 13 - 25/01/2017 
- I want custom annotation on the MapView. This worked out a bit, but not for different categories different images per pin. I did the excact same as [this tutorial](https://littlebitesofcocoa.com/70-custom-map-view-pins) and the same thing as [this site](http://stackoverflow.com/questions/38274115/ios-swift-mapkit-custom-annotation) recommended but it doens't work!! So I changed it to just one costum annotation for all the pins. When I had more time I would definitely try to implement this as well. Unfortunately I already made the custom pins on logomakr.
- Set Navigation Bar to transparent and back button to white. Thanks to Femke van Son who already had this feature integrated in her app. 
- The company who is adding a deal can now indicate till when a deal is valid. When the current date is past the valid date the deal will be deleted from Firebase. I had some trouble with this because in Firebase you can't save a NSDATE. Dax gave me the advise to transform the NSDate to a Double by the function timeIntervalSince1970. This is a functions that counts the seconds from 1970 till the given date. Now I can compare the given date with the current date and check if it is not already expired yet. 
    Two helpful DATE references: 

(http://stackoverflow.com/questions/36476826/how-to-deal-with-nsdate-and-firebase)

(http://stackoverflow.com/questions/29502186/get-just-the-date-no-time-from-uidatepicker)

Working! Only thing that bothers me is that the date of deals only gets checked in viewDidLoad. 

## Thursday day 14 - 26/01/2017
- When a deal is clicked I want to go to another deal with more information on it. Maybe a description or something else. So I need to [add a button to my annotation](http://stackoverflow.com/questions/40478120/mkannotationview-swift-adding-info-button)
  But there are some problems with this, because I want to add more information to the InformationDealViewController than there is in the annotation. How to get information from Firebase? You can do this by name of the deal, but what happens if there are two deals who have the samen name? Than Firebase won't know which deal was selected and will choose a random one. I think this isn't realistic, but it definitely a nice thing to add when I would have had more time. 

## Friday day 15 - 27/01/2017 
- I did the codebetter analysis. 
- Presentations.  
- I really want to add the extra functionality for the costumer to reserve a deal and for the business to get an email when someone reserve a deal. So they can say what there maximum capacity is. So when the capacity is reached the deal automatically will be removed. Unfortunately I think, timewise, it is not realistic to add a maximum capacity to the deal and hide the deal when maximum capactiy is reached. This makes my InformationDealViewController right now a little bit unneccessary, but it is still nice to have so I don't need to make it when I'm expanding the app with extra features. 

## Monday day 16 - 30/01/2017 
- Cleaning up my code trhough the advice of better code hub.
- Femke told me it is very easy to add an extra functionality of let a user resetting it's password, so I implemented [this](http://stackoverflow.com/questions/35808352/firebase-reset-password-swift). Validation email didn't work out, because after signing up it automatically logged in. So I have to check if the user already had a validation email, but timewise it is best to just leave this for what it is.
- Found a bug. Because of design decisions I let my pickerView start on the middlest category (see earlier in my process book). Unfortunately an error occurs. If a user selects nothing (and standard it stands on the category 'activities'), it will send an 0 and shopping will be selected. I don't know how to change this, so I changed my design and let the pickerView start on the first category 'shopping'. '
- Found another bug :( Sometimes you have to log out twice. I really don't know why this is happening. On slack a lot of other people (Dax, Jasper and Martijn) also have this problem. I think I fixed the solution to this problem. I think it has to do with preforming segues. I had a segue that was on 'show' and I changed it to 'present modally' and since I changed this it didn't happen. I put my solution on slack. '

## Tuesday day 17 - 31/01/2017 
- Add alert for the right address format
- Today I'm going to add my last functionality. If you have a business account, you are able to see all your deals (in a table view) and delete deals over here! Aynel worked a lot with tableViews so she helped me to implement this. 
- Turn off landscape. Martijn told me how to do this. 

## Wednesday day 18 - 01/02/2017
- Adding descriptions of functions 
- Working on my REPORT.md
- Found a bug! After deleting a deal in My Deals. The deal is still displayed on the map. After logging in again the deal is gone. I thought this would be fixed when I placed my readDatabase function in ViewWillAppear but this is still the case. Because I implemented this functionality quite late in the process I didn't find this bug until now. Eventually I think I fixed it by using NotificationCenter. I added a listener to ViewDidAppear and when a deal is deleted the data gets loaded again.
- Put not the address as a string in Firebase, but latitude en longitude! To work around the bug you can only apply to geocoder 3 times every minute. This is about the bug I found on Tuesday day 12 - 24/01/2017. 

## Thursday day 19 - 02/02/2017
- Writing report
- Constraints fixed, so you can run the app perfectly on an iphone 5, iphone 6 and iphone 7. 
- Noticed still one minor bug. If you select nothing when you click on filtered deals and than click on the button 'filter' in stead of on the button 'back', no pins are shown on the map. Yay, fixed it by adding an extra condition where it checks if the value of category is empty (self.category == "")!
- Found a bug. After deleting a deal, it won't be shown on the map, but when you directly filter on all deals you can see it again. I don't know why this is happening and unfortunately I don't have time to figure this out.
- Adding example deals around the Amsterdam centre. 
