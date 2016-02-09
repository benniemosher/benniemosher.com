---
title: Changing routes not paths
categories:
  - Rails
tags:
  - gorails
  - learning
  - rails
  - routes
---
So this morning I watched [GoRails.com&#8217;s screencast &#8216;A Look Into Routing&#8216;](https://gorails.com/episodes/a-look-into-routing) and learned something fantastic about your routes file.

In the podcast Chris (at least that is who sent me the email about this podcast), is describing how to make a routes folder for a book store. He eventually describes and gets to this point in the code:

```ruby
Rails.application.routes.draw do
    resources :books do
        member do
            patch :publish
            patch :unpublish
        end

        collection do
            patch :publish_all
            post: import
        end
    end
end
```

He then describes a very common case in the startup world, you pivot and begin to need to sell products. He describes a scenario where you do not yet have products other then books to sell, but you decide that you want to start to switch over your URLs to start getting your customers use to this type of path url. This is where the light bulb went off in my head. He adds 15 characters to his routes file and the whole world changes:

```ruby
    ...
    resources :books, path: "products" do
    ...
```

This now changes your URLs from `/books/:id/publish` to `/products/:id/publish`. This is amazing to me. He only changed his URL schema, he does not have to go through his app and change his `publish_book_path` as it is still a viable path. The routes files just forwards new requests to `/products/`.

This is obviously an inbetweener step, and you will eventually have to go in and change it to be `resources :products` and then change your controller name and all that good stuff, but this will allow you to start indexing your product URL schema without any real changes to your app.

This is my mind blown moment for the day!
