Rails.application.routes.draw do
  api_version(module: 'API/V1', path: { value: '/api/v1' }) do
    resources :users, except: %i[destroy] do
      collection do
        put 'verify', to: 'users#verify'
        put 'resend_otp', to: 'users#resend_otp'
        put 'change_passwords', to: 'users/change_passwords#update'
        get 'profile', to: 'users#show'
        put 'profile', to: 'users#update'
        resources :prefectures, only: %i[create index], controller: 'users/prefectures'
        resources :points, only: :index, controller: 'users/points' do
          collection do
            get 'history', to: 'users/points#history'
            post 'sync', to: 'users/points#sync'
          end
        end
        resources :addresses, only: %i[index create update destroy], controller: 'users/addresses' do
          resource :status, only: :update, controller: 'users/addresses/status'
        end
        resources :coupons, only: [:create, :index], controller: 'users/coupons'
        resources :point_bonuses do
          post 'check_receive_point', to: 'users/point_bonuses#check_receive'
        end
        resources :search, only: :index, controller: 'users/search'
        resources :contacts, only: :index, controller: 'users/contacts'
      end
    end
    resources :auths, only: %i[create destroy]
    resources :assets, only: :create
    post 'sign_up', to: 'users#create'
    resources :credits, only: %i[index create destroy update]
    resource :credits, only: :update
    resources :reset_passwords, only: %i[create]
    resource :reset_passwords, only: %i[update] do
      collection do
        put 'verify', to: 'reset_passwords#verify'
      end
    end

    resources :prefectures, only: :index
    resources :healths, only: :index
    resources :notifications, only: [:index, :show] do
      collection do
        resources :counts, only: :index, controller: 'notifications/counts'
        resource :unreads, only: :update, controller: 'notifications/unreads'
        resources :settings, only: :create, controller: 'notifications/settings'
      end
    end
    resources :devices, only: [:create, :destroy]
    namespace :ecommerces do
      resources :categories, only: [:index, :show] do
        collection do
          resources :meta, only: :index, controller: 'categories/meta'
        end
      end
      resources :campaigns, onyly: %i[index show] do
        collection do
          resources :meta, only: :index, controller: 'campaigns/meta'
        end
      end
      resources :products, only: %i[show index]
      resources :carts, only: %i[create index show update destroy] do
        collection do
          resources :meta, only: :index, controller: 'carts/meta'
        end
      end
      resources :orders, only: %i[create index show] do
        resources :cancel, only: :create, controller: 'orders/cancel'
        resources :checkouts, only: :create, controller: 'orders/checkouts'
        resource :receiptions, only: [:show, :update], controller: 'orders/receiptions' do
          get :download
        end
        collection do
          resources :sync, only: :create, controller: 'orders/sync'
        end
      end
      namespace :coupons do
        resources :users, only: [:index, :create] do
          collection do
            put 'update', to: 'users#update'
          end
        end
      end
    end

    namespace :diaries do
      resources :profiles, only: [:show] do
        resources :posts, only: [:index], controller: 'profiles/posts'
        get 'following', to: 'profiles#following'
        get 'followed', to: 'profiles#followed'
      end
      resources :follows, only: [:create, :destroy]
      resources :blocks, only: [:create, :destroy]
      namespace :me do
        resources :posts, only: [:create, :update, :index, :show, :destroy]
        resources :profile
        get 'blocking', to: 'blocks#blocking'
        get 'blocked', to: 'blocks#blocked'
        get 'following', to: 'follows#following'
        get 'followed', to: 'follows#followed'
        post 'nick_names', to: 'profile#update'
        resources :follows, only: [:destroy]
      end
      resources :posts do
        resources :likes, only: [:create, :index], controller: 'posts/likes'
        resource  :likes, only: :destroy, controller: 'posts/likes'
        resources :comments, only: [:create, :destroy, :index], controller: 'posts/comments'
        collection do
          resources :search, only: :index, controller: 'posts/search'
        end
      end
      resources :posts, only: :show
      get 'news_feeds', to: 'posts#index'
      resources :diary_categories, only: [:index]
      resources :welcome, only: [:create], to: 'welcome#create'
    end
    resources :s3, only: :create
    resources :weathers, only: :index do
      collection do
        resources :sync, only: :create, controller: 'weathers/sync'
      end
    end
    resources :news, only: :index do
      collection do
        resources :sync, only: :create, controller: 'news/sync'
        resources :top_headlines, only: :index, controller: 'news/top_headlines'
      end
    end
    resources :districts, only: :index
    resources :admin_settings, only: :index
    resources :tours, only: [:index, :show] do
      collection do
        resources :destination_locations, only: :index, controller: 'tours/destination_locations'
        resources :search, only: :index, controller: 'tours/search'
        resources :indays, only: %i[index show], controller: 'tours/indays' do
          collection do
            resources :prefectures, only: %i[index show], controller: 'tours/indays/prefectures'
            resources :start_locations, path: :departure_locations, only: :index, controller: 'tours/indays/start_locations'
          end
          resources :place_starts, only: :index, controller: 'tours/indays/place_starts'
          resource :reservations, only: :show, controller: 'tours/indays/reservations'
          resource :info, only: :show, controller: 'tours/indays/info'
        end
        resources :stays, only: %i[index show], controller: 'tours/stays' do
          collection do
            resources :prefectures, only: %i[index show], controller: 'tours/stays/prefectures'
            resources :start_locations, path: :departure_locations, only: :index, controller: 'tours/stays/start_locations'
          end
          resources :place_starts, only: :index, controller: 'tours/stays/place_starts'
          resource :reservations, only: :show, controller: 'tours/stays/reservations'
          resource :info, only: :show, controller: 'tours/stays/info'
        end
        resources :orders, only: :create, controller: 'tours/orders' do
          collection do
            resources :histories, only: %i[index show], controller: 'tours/orders/histories'
            resources :search, only: :index, controller: 'tours/orders/search'
            resources :cancel, only: :create, controller: 'tours/orders/cancel'
          end
          resource :checkouts, only: :create, controller: 'tours/orders/checkouts'
        end
      end
    end
    resources :hotels, only: :index do
      collection do
        resources :rankings, only: :index, controller: 'hotels/rankings'
      end
    end
    namespace :hotels do
      resources :areas, only: :index, controller: 'areas'
      resources :prefectures, only: :index, controller: 'prefectures'
      resources :orders, only: :index
      namespace :orders do
        resources :histories, only: %i[index show update]
        resources :cancellations, only: :update
        resources :sync, only: :create
      end
    end
    resources :hotels, only: :show, controller: 'hotels' do
      resources :callendars, only: :index, controller: 'hotels/callendars'
      resources :plans, only: %i[index], controller: 'hotels/plans' do
        resources :rooms, only: %i[show], controller: 'hotels/rooms' do
          resources :callendars, only: :index, controller: 'hotels/rooms/callendars'
          resources :checkouts, only: %i[create update], controller: 'hotels/checkouts'
          resources :requests, only: %i[create show], controller: 'hotels/requests'
        end
        resources :coupons, only: :index, controller: 'hotels/plans/coupons'
      end
    end
    resources :life_supports, only: [:index, :show] do
      resources :requests, only: :create, controller: 'life_supports/requests'
    end

    resources :fortunes, only: :index do
      collection do
        resources :sync, only: :create, controller: 'fortunes/sync'
      end
    end

    resources :banners, only: [:index, :show] do
      resources :requests, only: :create, controller: 'banners/requests'
    end

    resources :holidays, only: [:index]
    resources :tour_coupons, only: [:index, :show]
  end

  extend AdminRoutes
end
