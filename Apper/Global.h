//
//  Global.h
//  Apper
//
//  Created by jian on 8/27/15.
//  Copyright © 2015 jinhu. All rights reserved.
//

#ifndef Global_h
#define Global_h

#define COLOR_ICON_ROTATION_COUNT           1

#define TWITTER_KEY                         @"04HXYvPOzQIKmchfyzCAELQ0B"
#define TWITTER_SECRET                      @"sVmBvNP1cgvE5htTQUz6MA4sRirbG55l8G8HwnLN7yrXXyuzka"

#define GOOGLE_PLUS_KEY                     @"1087681360689-a2a0vja2n111sngap5aac6634jdqo799.apps.googleusercontent.com"
#define LINKEDIN_CLIENT_ID                  @"77d0zwaack5n2v"
#define LINKEDIN_CLIENT_SECRET              @"ATc3bvnusUNtIFFU"
#define LINKEDIN_REDIRECT_URL               @"http://igenapps.com/"
#define PREVIEW_URL                         @"http://igenapps.com/"

#define MAIN_FONT_NAME                      @"Helvetica-Condensed-Light"

//Dashboard.
#define NEXT_PAGE_MOVING_SMALL_ZOOM_TIME    0.1
#define NEXT_PAGE_MOVING_SMALL_ZOOM_VALUE   0.8
#define NEXT_PAGE_MOVING_ZOOM1_TIME         0.2
#define NEXT_PAGE_MOVING_ZOOM1_VALUE        8
#define NEXT_PAGE_MOVING_ZOOM2_TIME         0.2
#define NEXT_PAGE_MOVING_ZOOM2_VALUE        25


//Maker ViewController Constants.
#define MAX_APP_TITLE_LENGTH                20
#define FLOATING_BAR_OFFSET                 15
#define MAX_ICON_COUNT                      12
#define EMPTY_ICON_ALPHA                    0.5
#define EMPTY_SPIN_SPEED                    1.0
#define DELETE_LINE_HEGITH                  1.5

#define GRID_COUNT                          12
#define TAB_COUNT                           5
#define LIST_COUNT                          7
#define DRAWER_COUNT                        12

//Images Constants.
#define SPLASH_IMAGE                        0
#define BACKGROUND_IMAGE                    1

//Choose
#define CHOOSE_CORNER_RADIUS                18.0
#define CHOOSE_BORDER_WIDTH                 8.0
#define CHOOSE_FRAME_ANIM_TIME              0.7
#define CHOOSE_FRAME_OFFSET                 23.0

typedef enum
{
    TYPE_NONE,
    TYPE_IMAGES,
    TYPE_MENU,
    TYPE_INFO,
    TYPE_PREVIEW,
    TYPE_PUBLISH
    
} TOP_NAV_TYPE;

typedef enum
{
    MODE_COLOR,
    MODE_FONT,
    MODE_BAR,
    
} TOP_NAV_MOVING_MODE;

typedef enum
{
    CHOOSE_LISTS                        = 0,
    CHOOSE_FEEDS,
    CHOOSE_MAPS,
    CHOOSE_IMAGES,
    CHOOSE_MEDIA,
    CHOOSE_ACTIONS,
    CHOOSE_PROMO
    
} CHOOSE_TYPE;

#endif /* Global_h */
