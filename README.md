# Combo Breaker

An application for breaking you out of your culinary routine.

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