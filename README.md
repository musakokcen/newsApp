# News App


News App

Simple news app with categories, news titles, and news. The user can search news, refresh, and load more if they reach the end. 
App design is simple: white backgrounds, black texts for both dark and light modes. 

Minimum iOS version that News app supports is iOS 13.0 because %93 of iPhone users currently using version 13.0 or above. (source: https://david-smith.org/iosversionstats/)

VIPER architecture is implemented to better apply clean code principles. VIPER is preferred among other architectures because it provides separation among view, presenter, interactor, entity, and router.
SwiftLint is used as a third party tool for better implementation of swift guide rules.

Other third party tools are Alamofire, KingFisher, and MBProgressHUD in this project.

Alamofire is used for HTTP networking. It is preferred instead of URLSession because making request and handling comletion is simple.
Kingfisher is used to download news images and cache them so that while user is scrolling up and down in the table view, the image could be loaded from memory which is good for performance.
MBProgressHUD is used to show spinner.


* all icons are downloaded from flaticon.com
