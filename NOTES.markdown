SightSeeDC Application

Purpose: To create a sightseeing application for Washington DC, allowing users to create a list of sights to visit, comment on the sights, and view other user lists of sights. 

**** ORM ****
Models
  class User: has many reviews, has many sights through reviews
  class Review: belongs to user, belongs to sight
  class Sight: has many reviews, has many users through reviews

Database
  table users: username string, email string, password_digest string
  table reviews: content string, user_id integer, sight_id integer
  table sights: name string, description string

*** Controllers ***
ApplicationController
  x get '/' - render latest reviews and list additions
  x helper methods  

UsersController
  x get '/signup' - load signup form 
  x post '/signup' - process signup form
  x get '/login' - load login form
  x post '/login' - process login form
  x get '/logout' - clear session
  ** User Lists Routes **
    x get '/users/:slug' - render user show page of list and comments
    x get '/lists/new' - load new list form
    x post '/lists' - process new list form
    x get '/lists/:slug/edit' - load list edit form
    x patch '/lists/:slug' - process list edit form

ReviewsController
  x get '/reviews' - show all reviews
  x get '/reviews/new' - load new review form
  x post '/reviews' - process new review form
  x get '/reviews/:id' - show single review
  x get '/reviews/:id/edit' - load edit form
  x patch '/reviews/:id' - process edit form
  x delete '/reviews/:id/delete' - process delete form

SightsController
  x get '/sights' - show all sights
  x get '/sights/new' - load new sight form
  x post '/sights' - process new sight form
  x get '/sights/:id' - show single sight
  ** Questionable Routes **
    - get '/sights/:id/edit' - load edit form
    - patch '/sights/:id' - process edit form
    - delete '/sights/:id/delete' - process delete form

*** Views ***
x users folder
x sights folder
x reviews folder
- layout.erb

*** Public Folder ***
- add bootstrap css


*** Twitter-style Following ***
- get /search
- render form for text input
- post /search




