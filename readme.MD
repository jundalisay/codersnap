== CODERSCHOOL HOMEWORK

# Pre-work - *CoderSnap*

**CoderSnap** is a Ruby on Rails chat app.

Submitted by: **Juan Dalisay Jr.**

Time spent: **17** hours 

Timeline:

March 16 - followed video on http://learning.coderschool.vn and deployed on heroku (2 hours)

March 18 - added authentication, sessions, forms, messages, pictures (6 hours)

Learned from: https://www.youtube.com/watch?v=zQJtlvlNunw, https://www.youtube.com/watch?v=o0eVqNbapb0, and https://www.youtube.com/watch?v=Hw6WtWJwRtU

March 19 - added friendships and fixed login (6 hours)

March 20 - fixed Registration and Friends controller with help from Harley and Hoa (2 hours) and fixed some bugs (1 hour)

URL: **http://codersnap.herokuapp.com/**

## User Stories

The following **required** functionality is complete:

> HINT: mark the items you completed with [x]

* [X] User can sign up by providing their email, password, and name.
* [X] User can login using an email and password.
* [X] After logging in, the user is taken to a page that has a list of incoming messages, sorted in descending chronological order (newest messages at top), a "new message" link, an "add friends" link, and a "sent messages" link.
* [X] Unread messages should be bold or something similar in the list of messages.
* [X] Clicking the "add friends" link takes the user to a page with all users listed, with a link to "add user to friends list".
* [?] Clicking on "new message" takes the user to a page where they can write a new mesasge. The recipient field should be a dropdown, where the options are names from the user's friends.
* [?] Clicking on "sent messages" takes the user to a page listing messages they have sent. Each message should display at what time it was read by the recipient, or "unread". The user cannot read the contents of the messages.
* [X] User can read a message's content only once. Once the message has been read, the user will see a page indicating the message has already been read.
User can only read messages where they are the recipient.

## Bonus User Stories

* [?] User can attach an image: https://github.com/carrierwaveuploader/carrierwave.
or https://www.filepicker.com/. I haven't tried, but on Heroku it should be easy to use Filepicker add-on.
* [ ] User can specify multiple recipients per message.
* [ ] User can log in with Facebook. If interested, you can check out https://oauth.io instead.
* [ ] Implement Infinite Scroll. You can use the kaminari gem and jquery-infinite-pages gem.
* [ ] User gets an email when they receive a message, with a link to view the message.
* [ ] Check out letter_opener to test emails on localhost.
* [ ] Check out Email/SMS addons on Heroku if you want to implement it on Heroku. Sendgrid is a good free option.
* [ ] Check out sucker_punch gem if you want a simple way to send email via a background task. For serious apps, you should use sidekiq gem instead.
* [ ] User gets an email when a message they have sent is read with the time at which the message was read.
* [X] User can send a message to the email address of a non-registered user. The recipient will receive an email with a link to sign up for the service, and after creating an account, will be able to view the sent message.
* [X] User A can "block" User B. If User A blocks User B, they will not see messages from User B. User B will not know they have been blocked.
Designing the schema for this may be tricky. Ask questions and share your schema if you get stuck.
* [X] User can remove friends from their friends list.
* [X]User can unblock friends from their block list.


The following known issues:

* I didn't know how to start with the proper Message, Friendship model so I took an existing messaging project and transferred the code 

## Video Walkthrough 

Here's a walkthrough of implemented user stories:

> User can Filter, Search, and Order 
![Filter](/anim.gif)

GIF created with SilentCast[SilentCast](https://github.com/colinkeenan/silentcast).

## Notes

Describe any challenges encountered while building the app.

1. 


## License

    Copyright [2016] [Juan Dalisay Jr.]

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

        http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
