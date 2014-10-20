# Combo Breaker

An application for breaking you out of your culinary routine.

If you've ever felt like you can't decide what to eat for your next meal, this application will suggest a cuisine (and food-place from Yelp) that you haven't had recently. Helps you break out of a routine!

In the future, I hope to expand this to determine the cuisine you like the most, the cuisine you like the least, and suggest dissimilar restaurants from your norm to help you get out of your culinary rut. That'll take a little bit of reading up on machine learning, but hey, it's a wishlist...

# Story

- As someone who is adventurous with respect to food
- But has no idea what to eat around the area
- And wants to have something new (instead of pizza for the past 3 nights)
- I want an app to recommend me a food cuisine type
- That is new to me
- Or I have not had recently

# User Stories

User:

  - opens the home page
    - sees form with location text field, cuisine type select options
      - select options are generated from server
    - enters location and most recently eaten cuisine into form
    - submits form
    - most recently eaten cuisine is added to their account
      - records 10-20 cuisine types
        - or will it be infinitely large?
      - queue data structure, new cuisine is queued, oldest cuisine is dequeued (if limit is reached)
        - e.g. [:italian, :american, :chinese, :thai].push(:indian) --> [:italian, :american, :chinese, :thai, :indian].shift --> [:american, :chinese, :thai, :indian]
      - most recent cuisine is last in queue
      - how will this be represented in database?
  - is redirected to search results
    - is recommended a cuisine that they have not had recently
    - sees a list of restaurants in the area
      - name
      - location
      - profile image
      - price
      - details
        - allergy info?

# notes

foursquare

yelp api

when they checked in

decide dinner for a group

# User Authentication and Authorization

Devise is a jerk, and doesn't seem to want to work for me. I've tried several times to implement it, and I figure that at this point, I may as well learn how to roll my own. I've done simple user authentication before, although I haven't done much authorization at all. In any case, I will have to plan out how I want my auth to work.

User:

  - has an email
  - has a username
  - has a password hash
  - is not logged in ->
    - sees links to sign in and to sign up
    - does not have an account ->
      - clicks sign up
      - is directed to the sign up page
      - sees form with fields:
        * username
        * email
        * password
        * password_confirmation
    - has an account ->
      - clicks sign in
      - is directed to the sign in page
      - sees form with fields:
        * email
        * password
    - Rails session records their user ID
  - is logged in ->
    - sees links to log out and edit registration
    - logs out ->
      - Rails session forgets their user ID
      - no longer sees log out and edit reg links
      - sees links to sign in and to sign up
    - edits registration ->
      - is directed to edit profile page
      - sees form with fields:
        * username
        * email
        * password
        * password_confirmation

Alright, so my *User migration* will look something like this:

- User (database)
  - email:string, must be unique
  - username:string, a.k.a. display name
  - password_digest:string, hash of input password

While my *User model* will look like this:

- User (model)
  - email:string, must be unique
  - username:string, a.k.a display name
  - password:string, obvious
  - password_confirmation:string, to make sure the user puts their password in correctly!

I know that "ideally", I'd implement salting and hashing myself via bcrypt, but I kind of don't want to compromise *too* much when it comes to security. I'll use Rails' built-in `has_secure_password` function.

# Sessions

I need to keep track of the user session.

Rails keeps track of the session itself. Each client, when connected to a Rails application, gets a session hash in their cookies that contains important parameters.

All I really need to do is set `session[:id]` to the user's ID when the user is created, or when the user signs in. I also need to destroy it when the user logs out or when the user is destroyed.

You'll be making a `SessionsController`.

That controller must have these methods:

- `#new`
- `#create`
- `#destroy`

`#new` will simply display the sign in page, including a form with email/password fields.

`#create` will take the parameters of that submitted form, look up a user with the specified `:email`, and if that user exists *and* that user's password matches the specified `:password` (hint: use `user.authenticate(session_params[:password])`), set `session[:user_id]` to the verified user's id. Else, kick the client back to the sign in page with an error.

`#destroy` will simply set the `session[:user_id]` to `nil`.

My controller ended up looking something like this:

    class SessionsController < ApplicationController
      def new
        # show the sign in page
      end

      def create
        # thx to michael hartl for the review on how to do this
        user = User.find_by(email: session_params[:email].downcase)
        if user && user.authenticate(session_params[:password])
          session[:user_id] = user.id
          binding.pry
          redirect_to root_path
        else
          # (think of errors to pass!)
          render 'new'
        end
      end

      def destroy
        session[:user_id] = nil
        redirect_to root_path
      end

      private

        def session_params
          params.require(:session).permit(:email, :password)
        end

    end

# Location-Category Caching

I could potentially cache the results for a searched-for location to the database, add categories to that location, and look them up whenever a search is executed on that address. In this case, there'd be something like two models:

    Location
      has an address (string, from however Yelp interprets the input)
      has many Categories (i.e. cuisine/restaurant types within the maximum range for a Yelp search)

    Category
      has a display_name (string, part of Yelp's formatting)
      has a search_value (string, a symbol-like way of representing the Category - e.g. ['Italian', :italian] or ['Indian', :indpak]
      belongs to many Locations

I would keep Categories in the database. Upon making a search request for what's in the area, I would iterate through all the categories, check and see if a matching Category exists in the database already, and if not, add it to the database.

Once that's done, and assuming I know every Category available in a given area, I would then create a Location in the database (formatted as Yelp's returned search parameter), add to it all the respective Categories, and save it to the database. Then, if someone makes a request for an address, the app looks up that address in the database, and if it's there, it searches using the categories already known to exist in that area. If not, a new Location is created, and a list of categories available in the area is gotten from the server, etc etc.

There's still the problem of getting what categories are available in the area - the Yelp API only returns 20 results per search, which is definitely not the same as the number of categories in the area. I might just ask them if there's a way they can implement that in their API.