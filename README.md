# Welcome to RandomUser

This app is a small test of https://randomuser.me/api where you can see a list of 20 users and details of them, you can search users in this list of people by name or gender. Once you select an user can view a detailed information about their location, make a phone call (if you have a physical device) or send them an email (like in the phone call only if you have a physical device).


![GIF Demo](https://raw.githubusercontent.com/f3rn4d0n/randomUser/master/Documentation/demo.GIF)


## Architecture
The app was written in swift and have some libraries from Cocoapods
For this implementation I use only VIPER architecture and don't have storyboard, all UI was written programmatically excepted by launch screen, this decision was made to create Unit testing and UI testing easily.


## UML diagrams

The mainly flow of the app is:

```mermaid
sequenceDiagram
View List ->> Presenter List: Select refresh or start app
Presenter List-->>Interactor List: Request for a WS
Interactor List --X randomuser.me: Request a list of users
randomuser.me -->> Interactor List: Reponse with data of users
Interactor List -->> Presenter List: Parse user info 
Presenter List -->> View List: Show user list representation
View List -->> Presenter List: Select a user
Presenter List -->> Router List: Prepare User Detail Information
Router List --> Router Detail: Setup Detail Information
Router Detail -->> Presenter Detail: Set user selected
Presenter Detail -->> View Detail: Show user representation
Note right of Interactor List: In this section<br/>all response was <br/> parser to create <br/> a user list Entity.

```

![UML Diagram](https://raw.githubusercontent.com/f3rn4d0n/randomUser/master/Documentation/UML.png)
