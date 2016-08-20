# Query Movie for Visa

##Link

https://github.com/AlexHsieh/QueryMovie

## Usage

To run this query movie project, clone the repo, and run `pod install` from the directory first. Use QueryMovie.xcworkspace rather than QueryMovie.xcodeproj


## Note

- Structure of this App is classical MVC. 
- It adopts several 3rd party library for convenience
- the data were combined from 2 API
- No cache deletion for now.
- The server limited api call 40 requests every 10 second.


## Future Improvment

- Cache update and deletion
  * No deletion for now
  * migrate to NSCache
- Move the loading from query view (search view) to movie list view
  * For better user experience
- Add no data view in Movie List view. 
  * Use MVVM will have advantage on switching between no data view and table view
- Add trailer(from Youtube) in movie detail view.
  * need to build additional API call and a bunch of stuff. It seems fun...
- Multi data request
  * more filters need more data
- more filter
  * such as popularity, vote number, adult etc
- error handle
  * ex: no network
- UX
  * beautiful app makes people smile 


## Requirements
ARC only; iOS 9.0+


## Author

Alex Hsieh, alex.kyhsieh@gmail.com
Any question mail me!



