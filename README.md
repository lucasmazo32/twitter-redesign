# Twitter redesign: Ruby on Rails

This solo project is part of the Microverse curriculum in which I had to build a [Twitter Redesign](https://immense-castle-68670.herokuapp.com/) following the design made by [Gregoire Vella](https://www.behance.net/gallery/14286087/Twitter-Redesign-of-UI-details). I could change the logo and name, but the overall design should be there.

The project is fully functional and is open for new features that can be easily added. 

# Features

As a non-logged user, you can Log in, or create a new account.

The fields specify which ones are optional. In case you decide not to fill those fields, the system is going to assign one random profile picture and cover image to you. If you create the account, is going to redirect you to your profile page.

![New user](https://github.com/lucasmazo32/twitter-redesign/blob/feature/final_touches/app/assets/images/screenshots/new_user.png?raw=true)

![Profile](https://github.com/lucasmazo32/twitter-redesign/blob/feature/final_touches/app/assets/images/screenshots/profile.jpg?raw=true)

In the login page, you can log in with your user, if you have one; create a new user, or ask for the list of seeded users to log in as one of them. 

![Login page](https://github.com/lucasmazo32/twitter-redesign/blob/feature/final_touches/app/assets/images/screenshots/login.png?raw=true)

![Sample users](https://github.com/lucasmazo32/twitter-redesign/blob/feature/final_touches/app/assets/images/screenshots/sample_users.png?raw=true)

Once you log in, is going to take you to the Just Like That's homepage, in which you can see the "tweets" of everyone that you follow, and the ones that you've made.

![root](https://github.com/lucasmazo32/twitter-redesign/blob/feature/final_touches/app/assets/images/screenshots/root.jpg?raw=true)

The 'Who to follow' section shows you three users that you are not following so you can check their profile, and in case you like it, follow them. The plus sign to the side of the person's photo is the follow button. Additionally, if you start a tweet with jlt_`username` you are going to tag that person, and in your comment, you can see the hyperlink to that person's user page. If you go to the user's profile, you can write a tweet, and it already has the jlt_`username` by default.

![other page](https://github.com/lucasmazo32/twitter-redesign/blob/feature/final_touches/app/assets/images/screenshots/other_profile.jpg?raw=true)

Every link in the application is clickable and fully functional, so don't be afraid of exploring more.


## Built With

- Ruby v2.7.0
- Ruby on Rails v5.2.4

## Getting Started

To get a local copy up and running follow these simple example steps.

### Prerequisites

Ruby: 2.7
Rails: 5.2.3
Postgres: >=9.5

### Setup

Instal gems with:

```
   bundle install
```

In case it is required, run `bundle update`.


Setup development and test database with:

```
   rails db:drop
   rails db:create
   rails db:migrate
   rails db:migrate RAILS_ENV=test
   rails db:seed
   rails db:seed RAILS_ENV=test
```

> Following the last steps are very important for setting up the database for the development environment as well as the test environment.

### Usage

Start server with:

```
    rails server
```

Open `http://localhost:3000/` in your browser.

### Run tests

```
    bundle exec rspec
```

### Deployment

https://immense-castle-68670.herokuapp.com/

## Authors

Lucas Mazo:

[LinkedIn](https://www.linkedin.com/in/lucas-mazo-meza-55a65b159/) | 
[Github](https://github.com/lucasmazo32) | 
[Twitter](https://twitter.com/lucasmazo32)

## 🤝 Contributing

Contributions, issues and feature requests are welcome!

Feel free to check the [repository](https://github.com/lucasmazo32/twitter-redesign).

## Show your support

Give a ⭐️ if you like this project!

## Acknowledgments

For the logo creation, I used the application [LogoMakr](https://logomakr.com/), which has cool logos and is easy to use. 

For the SVG's (like the house, pencil and others) I used [Font Awesome](https://fontawesome.com/).

## 📝 License

MIT
