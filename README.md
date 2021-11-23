Original App Design Project - README Template
===

# Armario Viewing

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Armario Viewing is an iOS mobile application that will allow users to share photos of the clothes in their personal closets. Armario means "closet" in Spanish, and "Viewing" signifies that it will be an application that allows other users to view these photos. Users can post photos of their clothing items listing where the clothes from, and other users of the app may save/like these photos for inspiration for their own wardrobe.

### App Evaluation
[Evaluation of your app across the following attributes]
- **Category:** Lifestyle
- **Mobile:** Website is view only, uses camera, mobile first experience.
- **Story:** Allows users to share their clothing items in their closet. Other users may view these items and create personalized wardrobes on the app for inspiration. 
- **Market:** Anyone that is looking to share fashion inspiration and takes pictures could enjoy this app. Ability to follow users based on their closets and like/save photos to "wardrobes" on the app. 
- **Habit:** Users can post throughout the day many times. Features like “Wardrobes” could encourage users to create different sets of wardroves.  Users can explore endless pictures in any category imaginable whenever they want. Very habbit forming!
- **Scope:** Armario Viewing is a very narrow scope. The app could eventually expand to include features for users to sell their clothing items they no longer want.

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User can post a new photo of their clothing item.
- [x] User can create a closet to post their photos.
- [x] User can login
- [x] User can sign up for the app
- [ ] User can search for other users
- [x] User can like a photo
- [ ] User can save a photo
- [ ] User can create a wardrobe to save posts to 
- [ ] User can give a wardrobe a title and a description
- [x] User can view a feed of clothing posts

**Optional Nice-to-have Stories**

- [ ] Users can sell clothing pieces 
- [ ] Users list a price for their clothing pieces
- [ ] Users can bid on clothing pieces
- [ ] Users link online payment systems

### 2. Screen Archetypes

* Login Screen
   * User can login
* Registration Screen
   * User can create a new account
* Stream
   * User can view a feed a clothing items
   * User can like a photo
   * User can save a photo
* Creation
   * User can post a new clothing item 
   * User can list where they purchased their clothing item 
   * User can add hashtags to describe the item
* Search 
   * User can search for other users
   * User can search by hashtags, brand/store names, and descriptions
* Storage
   * User can view photos that they saved on their feed in organized, table cell "wardrobes"

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Feed
* Search User
* Post a Photo
* View Saved Photos stored in "Wardrobes"

**Flow Navigation** (Screen to Screen)

* Login Screen
   * Home
* Registration Screen
   * Home
* Stream Screen
   * None
* Creation Screen
   * Home (after completing the post)
* Search Screen
   * User could navigate to a searched user's profile
   * User could navigate to a searched user's posted clothing item
* Storage Screen
   * User could navigate to a clothing item that was saved previously 

## Wireframes
<img src="https://user-images.githubusercontent.com/59743056/140002057-c5da41b7-3645-44f6-9761-4782c42a9be9.jpeg" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

### Models

Post

| Property | Type | Description |
| --- | --- | --- |
| postId | String	| unique id for the user post (default field) |
| author | Pointer to User |	image author |
| image	 | File	| image that user posts |
| profileImage	| File |	profile image by author |
| caption	| String |	image caption by author |
| brand | String	| image clothing brand by author |
| commentsCount |	Number | number of comments that has been posted to an image |
| likesCount	| Number	| number of likes for the post |
| savesCount	| Number	| number of saves for the post |
| createdAt	| DateTime	| date when post is created (default field) |

Wardrobe Collection 

| Property | Type | Description |
| --- | --- | --- |
| wardrobeId | String	| unique id for the user wardrobe (default field) |
| title	| String |	wardrobe title by author |
| description	| String |	wardrobe description by author |
| author | Pointer to User |	author of the wardrobe collection |
| imagesCount |	Number | number of images that has been added to wardrobe collection |
| posts | Pointers to Posts |	posts saved by author |
| createdAt	| DateTime	| date when post is created (default field) |
| updatedAt	| DateTime	| date when post is updated (default field) |

User

| Property | Type | Description |
| --- | --- | --- |
| userId | String	| unique id for the user (default field) |
| username	| String |	username by author |
| bio	| String |	bio by author |
| profileImage	| File |	profile image by author |
| posts | Pointers to Posts |	posts created by author |
| followers | Pointer to Users |	other users that follow the user |
| followingUsers | Pointer to Users |	other users that the user is following |
| imagesCount |	Number | number of images that has been created |
| followersCount |	Number | number of followers the user has |
| followingCount |	Number | number of users the user follows |




### Networking
* Home Feed Screen
  * (Read/GET) Query all posts where author is one of the users that the logged in user follows
```
let query = PFQuery(className:"Post")
query.whereKey("following", equalTo: true)
query.order(byDescending: "createdAt")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error { 
      print(error.localizedDescription)
   } else if let posts = posts {
      print("Successfully retrieved \(posts.count) posts.")
  // TODO: Do something with posts...
   }
}
```
  * (Create/POST) Create a new like on a post
```
let like = PFObject(className: "Likes")
        save["post"] = selectedPost
        save["author"] = PFUser.current()!
         
        selectedPost.add(like, forKey: "likes")
```
  * (Delete) Delete existing like
```
let like = PFObject(className: "Likes")
        save["post"] = selectedPost
        save["author"] = PFUser.current()!
         
        selectedPost.remove(like, forKey: "likes")
```
  * (Create/POST) Create a new comment on a post
```
let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()!
         
        selectedPost.add(comment, forKey: "comments")
```
  * (Delete) Delete existing comment
```
let comment = PFObject(className: "Comments")
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()!
         
        selectedPost.remove(comment, forKey: "comments")
```
  * (Create/POST) Create a new save on a post
```
let save = PFObject(className: "Saves")
        save["post"] = selectedPost
        save["wardrobeCollection"] = selectedWardrobeCollection
        save["author"] = PFUser.current()!
         
        selectedWardrobeCollection.add(save, forKey: "saves")
```
  * (Delete) Delete existing save
```
let save = PFObject(className: "Saves")
        save["post"] = selectedPost
        save["wardrobeCollection"] = selectedWardrobeCollection
        save["author"] = PFUser.current()!
         
        selectedWardrobeCollection.remove(save, forKey: "saves")
```
* Create Post Screen
  * (Create/POST) Create a new post object
```
let post = PFObject(className: "Posts")
        post["caption"] = caption
        post["brand"] = brand
        post["image"] = image
        post["author"] = PFUser.current()!
         
        PFUser.current()!.add(post, forKey: "posts")
```
* Create Wardrobe Collection Screen
  * (Create/POST) Create a new wardrobe collection object
```
let wardrobe = PFObject(className: "Posts")
        wardrobe["title"] = title
        wardrobe["description"] = brand
        wardrobe["save"] = save
        wardrobe["author"] = PFUser.current()!
         
        PFUser.current()!.add(wardrobeCollection, forKey: "wardrobeCollections")
```
* Profile Screen
  * (Read/GET) Query logged in user object
```
let query = PFQuery(className:"User")
query.whereKey("userId", equalTo:  PFUser.current()!)
```
  * (Read/GET) Query all posts where where user is author
```
let query = PFQuery(className:"Post")
query.whereKey("author", equalTo: currentUser)
query.order(byDescending: "createdAt")
query.findObjectsInBackground { (posts: [PFObject]?, error: Error?) in
   if let error = error { 
      print(error.localizedDescription)
   } else if let posts = posts {
      print("Successfully retrieved \(posts.count) posts.")
  // TODO: Do something with posts...
   }
}
```

### First Sprint Progress

<img src='https://user-images.githubusercontent.com/59743056/141922155-5419030f-3f27-4550-8029-7559fe54f243.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />

<img src='https://user-images.githubusercontent.com/59743056/141922564-fc35ba3e-76cd-4cad-ba52-457c0411217f.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />

<img src='https://user-images.githubusercontent.com/59743056/141922803-c6bb4a9a-cbd3-4927-be70-a62f0323794d.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />

<img src='https://user-images.githubusercontent.com/59743056/141923251-3bbe90db-432a-4466-8d44-67b4ee9b4711.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />

<img src='https://user-images.githubusercontent.com/59743056/141923385-b4ccc928-5047-4a4b-9659-9e3212065daa.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />

### Second Spring Progress

<img src='https://user-images.githubusercontent.com/59743056/142955282-e47f117f-2d4f-446b-b2ce-df5903952349.gif' title='Video Walkthrough' width='250' alt='Video Walkthrough' />


