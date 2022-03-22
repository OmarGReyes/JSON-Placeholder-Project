# JSON-Placeholder-Project

<img width="409" alt="Screen Shot 2022-03-22 at 8 28 01 AM" src="https://user-images.githubusercontent.com/64993876/159492461-0b7df479-9677-4abc-825d-987620b34ff3.png">


## How to run the app?

Download/Clone the project in to your mac and run the app in Xcode.

## System settings
- Xcode 12.4 or above installed
- Swift 5.0 or above installed


## Proposed architecture

<img width="876" alt="Screen Shot 2022-03-22 at 8 46 27 AM" src="https://user-images.githubusercontent.com/64993876/159495906-eaf37e63-229a-4835-bed2-c9b385b60e19.png">
VIPER was the selected architechture due the clear separation between the app layers and the ease of testing the functions of each layer due the protocols implementation.

## App extra features

### Swipe to delete posts
![SwipeToDelete](https://user-images.githubusercontent.com/64993876/159498147-9d2cf4bc-1b62-4c4a-b0ae-6ed94477b232.gif)

### Pull to refresh implementation
![Pull-to-refresh](https://user-images.githubusercontent.com/64993876/159498669-4732c209-9313-4cf3-80a8-be4ac984695f.gif)

### Loader while services are requested
- When the app is initializing
- When a post is taped
- When the view is refreshing

![Loader](https://user-images.githubusercontent.com/64993876/159499406-c2203d13-f907-4d12-b5c0-ef76ad412cae.gif)

### Alerts implementation
| Delete post alert    | Delete all        |
 ----------------------------------- | ------------------------------------
![deletePost](https://user-images.githubusercontent.com/64993876/159500531-b53b914e-790f-49de-ace1-3751a50e7c33.gif) | ![DeleteAllPosts](https://user-images.githubusercontent.com/64993876/159500892-4a8bb0d1-9b82-424d-9c77-15d1091ea459.gif)

| Pull-to-refresh alert    | Tap refresh button alert      |
 ----------------------------------- | ------------------------------------
![Pull-To-Refresh alert](https://user-images.githubusercontent.com/64993876/159503193-ea3855f9-4a77-4716-b6d8-371dee749607.gif) | ![TapRefreshAlert](https://user-images.githubusercontent.com/64993876/159503888-fe6c5c61-1def-4aad-8ee8-5d5d6746f17b.gif)


