//
//  Apper.swift
//  Apper
//
//  Created by jian on 8/27/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

import UIKit

//enum CATEGORY_TYPE: Int
//{
//    case CATEGORY_BANDS_MUSICIANS
//    case CATEGORY_BARS_RESTAURANTS
//    case CATEGORY_BEAUTY_SPA
//    case CATEGORY_CAR_DEALERS
//    case CATEGORY_COFFEE_SHOPS
//    case CATEGORY_CONCERTS
//    case CATEGORY_EVENTS_SHOWS
//    case CATEGORY_CONSULTANTS
//    case CATEGORY_CONTRACTING
//    case CATEGORY_DAYCARE
//    case CATEGORY_GYM_FITNESS
//    case CATEGORY_HOME_SERVICES
//    case CATEGORY_LEGAL_SERVICES
//    case CATEGORY_MEDICAL_SERVICES
//    case CATEGORY_PET_SERVICES
//    case CATEGORY_PHOTOGRAPH
//    case CATEGORY_REAL_ESTATE
//    case CATEGORY_RELIGION
//    case CATEGORY_HOTELS_RESORTS
//    case CATEGORY_SPORTS_TEAMS
//    case CATEGORY_STORES_BOUTIQUES
//    case CATEGORY_TOURISM
//    case CATEGORY_EDUCATION
//    case CATEGORY_WEDDINGS
//}

enum MenuStyle
{
    case Collect
    case TabBar
    case List
    case SideBar
}

class Apper: NSObject
{
    var category: Int!
    var mainColor: UIColor!
    var imgIcon: UIImage!
    var imgSplash: UIImage!
    var imgBackground: UIImage!
    var imgDefault: UIImage!
    
    var appTitle: String!
    var appCategory: String!
    var appDescription: String!
    var menuStyle: MenuStyle?
    var arrCategories: NSArray!
    var appStoreCategories: NSArray!
    var arrIcons: NSMutableArray!
    
    override init()
    {
        super.init()
        
        mainColor = UIColor(red: 253.0/255.0, green: 130.0/255.0, blue: 12.0/255.0, alpha: 1.0)
        arrIcons = NSMutableArray()
        appTitle = "App Name"
        appDescription = ""
        menuStyle = MenuStyle.Collect
        
        //Category.
        arrCategories = NSArray(objects:
            "Bands & Musicians",
            "Bars & Restaurants",
            "Beauty & Spa",
            "Car Dealers",
            "Coffee Shops",
            "Concerts",
            "Events & Shows",
            "Consultants",
            "Contracting",
            "Daycare",
            "Gyms & Fitness",
            "Home Services",
            "Legal Services",
            "Medical Services",
            "Pet Services",
            "Photography",
            "Real Estate",
            "Religion",
            "Hotels & Resorts",
            "Sports Team",
            "Stores & Boutiques",
            "Tourism",
            "Education",
            "Weddings")
        
        appStoreCategories = NSArray(objects:
            "Books",
            "Business",
            "Catalogs",
            "Education",
            "Entertainment",
            "Finance",
            "Food & Drink",
            "Games",
            "Health & Fitness",
            "Lifestyle",
            "Medical",
            "Music",
            "Navigation",
            "News",
            "Photo & Video",
            "Productivity",
            "Reference",
            "Social Networking",
            "Sports",
            "Travel",
            "Utilities",
            "Weather")
        
        
        
        //Category Brands & Musicians.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E001}", title: "Item1"),
            AppIcon(icon: "\u{E002}", title: "Item2"),
            AppIcon(icon: "\u{E003}", title: "Item3"),
            AppIcon(icon: "\u{E004}", title: "Item4"),
            AppIcon(icon: "\u{E005}", title: "Item5"),
            AppIcon(icon: "\u{E006}", title: "Item6"),
            AppIcon(icon: "\u{E007}", title: "Item7")))
        
        //Category Bars & Restaurants.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E008}", title: "Item1"),
            AppIcon(icon: "\u{E009}", title: "Item2"),
            AppIcon(icon: "\u{E010}", title: "Item3"),
            AppIcon(icon: "\u{E011}", title: "Item4"),
            AppIcon(icon: "\u{E012}", title: "Item5"),
            AppIcon(icon: "\u{E013}", title: "Item6"),
            AppIcon(icon: "\u{E014}", title: "Item7")))
        
        //Category Beauty & Spa.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E015}", title: "Item1"),
            AppIcon(icon: "\u{E016}", title: "Item2"),
            AppIcon(icon: "\u{E017}", title: "Item3"),
            AppIcon(icon: "\u{E018}", title: "Item4"),
            AppIcon(icon: "\u{E019}", title: "Item5"),
            AppIcon(icon: "\u{E020}", title: "Item6"),
            AppIcon(icon: "\u{E021}", title: "Item7")))
        
        //Category Car Dealers.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E022}", title: "Item1"),
            AppIcon(icon: "\u{E023}", title: "Item2"),
            AppIcon(icon: "\u{E024}", title: "Item3"),
            AppIcon(icon: "\u{E025}", title: "Item4"),
            AppIcon(icon: "\u{E026}", title: "Item5"),
            AppIcon(icon: "\u{E027}", title: "Item6"),
            AppIcon(icon: "\u{E028}", title: "Item7")))
        
        //Category Coffee Shops.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E029}", title: "Item1"),
            AppIcon(icon: "\u{E030}", title: "Item2"),
            AppIcon(icon: "\u{E031}", title: "Item3"),
            AppIcon(icon: "\u{E032}", title: "Item4"),
            AppIcon(icon: "\u{E033}", title: "Item5"),
            AppIcon(icon: "\u{E034}", title: "Item6"),
            AppIcon(icon: "\u{E035}", title: "Item7")))
        
        //Category Concerts.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E037}", title: "Item1"),
            AppIcon(icon: "\u{E038}", title: "Item2"),
            AppIcon(icon: "\u{E039}", title: "Item3"),
            AppIcon(icon: "\u{E040}", title: "Item4"),
            AppIcon(icon: "\u{E041}", title: "Item5"),
            AppIcon(icon: "\u{E042}", title: "Item6"),
            AppIcon(icon: "\u{E043}", title: "Item7")))
        
        //Category Events & Show.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E044}", title: "Item1"),
            AppIcon(icon: "\u{E045}", title: "Item2"),
            AppIcon(icon: "\u{E046}", title: "Item3"),
            AppIcon(icon: "\u{E047}", title: "Item4"),
            AppIcon(icon: "\u{E048}", title: "Item5"),
            AppIcon(icon: "\u{E049}", title: "Item6"),
            AppIcon(icon: "\u{E050}", title: "Item7")))
        
        //Category Consultants.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Contracting.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Daycare.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Gym & Fitness.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Home Services.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Legal Services.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Medical Services.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Pet Services.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Photograph.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Real Estate.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Religion.
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Hotel Resorts
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Sports Teams
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Stores Boutiques
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Tourism
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Education
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))
        
        //Category Wedding
        arrIcons.addObject(NSArray(objects:
            AppIcon(icon: "\u{E051}", title: "Item1"),
            AppIcon(icon: "\u{E052}", title: "Item2"),
            AppIcon(icon: "\u{E053}", title: "Item3"),
            AppIcon(icon: "\u{E054}", title: "Item4"),
            AppIcon(icon: "\u{E055}", title: "Item5"),
            AppIcon(icon: "\u{E056}", title: "Item6"),
            AppIcon(icon: "\u{E057}", title: "Item7")))


    }
}
