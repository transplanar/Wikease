[View Case Study](https://transplanar.github.io/portfolio//wikease/)

[View on Heroku](https://wikease.herokuapp.com/)

# Wikease
Wikease is a Wikipedia-style page developed in Rails. Users have the option to upgrade their account to a premium account using Stripe, enabling them to create private wikis they can assign collaborators to.

##How to Use
Sign up or create an account or login using any of the following credentials:
*  admin@example.com / password
*  member@example.com / password
*  member2@example.com / password

You may then create a new wiki, view other users, view other wikis, or explore your user profile.
###Create a New Wiki
Click ```Create a New Wiki``` in the upper right to view a form to create your new wiki. When finished, click ```Create Wiki``` to publish.

###View Other Users
Click the ```Users``` tab at the top to see an index of other users. You may then click a user to see a list of wikis they own.

###View Other Wikis
Click the ```Wikis``` tab to view an index of all wikis in the database. From there you may click the wiki title to view the page or the author's email to view their profile.

###Explore Your Profile
Click on your email in the upper right to view your profile page, which displays a list of all wikis you own.

##Additional Features

###Upgrading Your account
If you click ```Settings``` under your email in the upper right corner, you are taken to a page to update your email or password. At the bottom you have the option to upgrade to a premium user. 

To test, click ```Pay with card``` and use the card number ```4242 4242 4242 4242```. This will make you a premium user. Upon creating a new wiki, you will see a checkbox that will allow you to make your wiki **private**. Private wikis can only be seen by you, an admin, or collaborators.

####Assigning Collaborators
If you own a wiki, you may click the ```Collaborations``` button to invite other users to be collaborators to your page.

##Tech
* Devise Authentication
* Pundit Authorization
* Stripe integration for upgrading user accounts
* Redcarpet for Markdown parsing in wiki entries
