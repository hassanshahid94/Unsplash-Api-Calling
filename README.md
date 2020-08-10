# Unsplash-Api-Calling iOS Task

Unsplash-Api-Calling is an iOS Application designed for displaying random food pictures using unsplash API. This app uses unsplash API services to fetch photos and display them.

Demo Video Link: **[Unsplash-Api-Calling - iOS Task](https://www.youtube.com/watch?v=AqAtbEiB8ok&feature=youtu.be)**

#### Faetures:
This app has following major features:
1. Codable Protocol technique for mapping API responses
2. Programtically created UI Elements
3. Data Cache to present when internet is not available
4. Pull to refresh(API Call)
5. Internet Connectivity Management
6. Crash Handling

#### System Architecture:
This application was developed on Xcode IDE. Xcode is used for creating native iOS, watchOS, tvOS applications. Xcode does not generate the code for any application. Developer has to design the screens first and then connect the code with the design.

**MVC** design pattern was used in the application. This application is developed on Swift language. Let me explain a little about the MVC approach I used. As MVC is Model-View-Controller, I organized the app in this way:

**Model:** (ModelClasses)
1. **KiskoLabsFoodResponse** (Main Response Handling Class)
2. **KiskoLabsResult** 
3. **KiskoLabsUrl** 

**Views:** (UI View Elements)
1. **Main.storyboard** (where I have the UI Views designed)

**Controllers:** (View Controllers)
1. HomeVC (calling the unsplash api to get the photos and displayed them in the UI)


**File Naming Conventions:**

* **VC** are ViewControllers
* **CCell** are CollectionViewCells
* **TCell** are TableViewCells

**Variable Naming Conventions:**

As Swift guidelines state that **"Names of types and protocols are UpperCamelCase. Everything else is lowerCamelCase."** I used the same approach in the project. You can notice that:
class **HomeVC** (Class Names are UpperCamelCase)

```
class HomeVC: BaseVC { // UpperCamelCase
    ...
}
```
var **foodData** (Variable Names are lowerCamelCase)
```
//MARK:- Variables
    var foodData: KiskoLabsFoodResponse! // lowerCamelCase
```

There is another folder in the app:

**Helpers:**
1. **Constants** (constants used in the app such as URLs)
2. **Extensions** (useful feature that helps in adding more functionality to an existing Class and written one time to access anywhere)
3. **ServerManager** (API calls)

App images are placed in **Assets.xcassets** folder.




### Cocoapods:

Unsplash-Api-Calling iOS Task uses a number of open source 3rd Party Libraries for better user experience:

* [Alamofire](https://github.com/Alamofire/Alamofire) - An HTTP networking library.

* [RappleProgressHUD](https://github.com/rjeprasad/RappleProgressHUD) - Custom Activity Indicator(Loader/Spinner)

* [IQKeyboardManager](https://github.com/hackiftekhar/IQKeyboardManager) - Used to prevent issues of keyboard sliding up and cover UITextField/UITextView.

* [SDWebImage](https://github.com/SDWebImage/SDWebImage) - Asynchronous image downloader with cache support as a UIImageView category.

* [SnapKit](https://github.com/SnapKit/SnapKit) - SnapKit is a DSL to make Auto Layout easy on both iOS and OS X.

* [SwiftlyCache](https://github.com/hlc0000/SwiftlyCache) - SwiftlyCache is a thread safe IOS general cache Library.

### Support:
In case of any errors or app crashes please email me at:

Hassan Shahid ( [hassan.shahid94@yahoo.com](hassan.shahid94@yahoo.com) )


----


**Last Updated: 16.06.2020**

