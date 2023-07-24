module AdminRoutes
  def self.extended(router)
    router.instance_exec do
      namespace :admin do
        root to: 'home#index'
        get    'sign_in',  to: 'sessions#new'
        post   'sign_in',  to: 'sessions#create'
        delete 'sign_out', to: 'sessions#destroy'
        resources :coupons, permission: {
          create: 'write/coupon',
          update: 'write/coupon',
          destroy: 'write/coupon',
          index: 'read/coupon',
          show: 'read/coupon'
        }
        resources :s3
        resources :codes, only: :create
        resources :payments, only: :index
        resources :deliveries, only: :index
        resources :users, only: [:index, :show, :update, :destroy], permission: {
          create: 'write/user',
          show: 'read/user',
          update: 'write/user',
          destroy: 'write/user'
        } do
          collection do
            resources :downloads, only: :create, controller: 'users/downloads'
            resource :meta, only: :show, controller: 'users/meta'
          end
          member do
            resources :orders, only: :index, controller: "users/orders"
            resources :histories, only: :index, controller: "users/histories"
            resources :history_points, only: :index, controller: "users/history_points"
            resources :addresses, only: :index, controller: "users/addresses"
          end
          collection do
            resources :point_bonuses, only: [:create, :index, :show], controller: "users/point_bonuses"
          end
        end
        resources :auths, only: :create
        resources :contacts, permission: {
          create: 'write/contact',
          update: 'write/contact',
          destroy: 'write/contact',
          index: 'read/contact',
          show: 'read/contact'
        } do
          collection do
            resources :categories, only: :index, controller: 'contacts/categories'
            resources :downloads, only: :create, controller: 'contacts/downloads'
          end
        end
        namespace :area_settings do
          resources :meta, only: :index
        end
        namespace :ecommerces do
          resources :products, only: %i[create index update destroy show], permission: {
            create: 'write/ecommerces_product',
            update: 'write/ecommerces_product',
            destroy: 'write/ecommerces_product',
            index: 'read/ecommerces_product',
            show: 'read/ecommerces_product'
          } do
            collection do
              resources :meta, only: [:index, :show], controller: 'products/meta'
              resources :coupons, only: :index, controller: 'products/coupons'
              resources :shippings, only: :index, controller: 'products/shippings'
              resources :downloads, only: :create, controller: 'products/downloads'
            end
            resource :status, only: :update, controller: 'products/status'
          end
          resources :categories, except: [:new, :edit], permission: {
            create: 'write/ecommerces_category',
            update: 'write/ecommerces_category',
            destroy: 'write/ecommerces_category',
            index: 'read/ecommerces_category',
            show: 'read/ecommerces_category'
          } do
            resources :products, only: %i[index], controller: 'categories/products'
            collection do
              resources :meta, only: :index, controller: 'categories/meta'
              resource :ranking, only: :update, controller: 'categories/ranking'
            end
          end
          resources :campaigns , except: [:new, :edit], permission: {
            create: 'write/ecommerces_campaign',
            update: 'write/ecommerces_campaign',
            destroy: 'write/ecommerces_campaign',
            index: 'read/ecommerces_campaign',
            show: 'read/ecommerces_campaign'
          } do
            resources :products, only: %i[index create destroy], controller: 'campaigns/products'
            resources :notifications, only: :create, controller: 'campaigns/notifications'
            collection do
              resource :ranking, only: :update, controller: 'campaigns/ranking'
            end
          end
          resources :orders, permission: {
            index: 'read/ecommerces_order',
            update: 'write/ecommerces_order',
            create: 'write/ecommerces_order'
          } do
            collection do
              resources :downloads, only: :create, controller: 'orders/downloads'
            end
          end
          resources :delivery_areas, only: :index
          resources :agencies, only: [:create, :destroy, :index, :update, :show], permission: {
            create: 'write/ecommerces_agency',
            destroy: 'write/ecommerces_agency',
            index: 'read/ecommerces_agency',
            update: 'write/ecommerces_agency',
            show: 'read/ecommerces_agency'
          } do
            resources :products, only: :index, controller: 'agencies/products'
            collection do
              resources :meta, only: :index, controller: 'agencies/meta'
            end
          end
        end
        resources :prefectures, only: :index
        resources :notifications, except: [:new, :edit], permission: {
          index: 'read/notification',
          create: 'write/notification',
          show: 'read/notification',
          update: 'write/notification',
          destroy: 'write/notification'
        }
        namespace :permissions do
          resources :branches, only: [:create, :index, :update, :destroy] do
            collection do
              resources :meta, only: :index, controller: 'branches/meta'
            end
          end
          resources :departments, only: [:create, :index, :update, :destroy] do
            collection do
              resources :meta, only: :index, controller: 'departments/meta'
            end
          end
          resources :staffs, except: [:new, :edit], permission: {
            index: 'read/permissions_staff',
            create: 'write/permissions_staff',
            show: 'read/permissions_staff',
            update: 'write/permissions_staff',
            destroy: 'write/permissions_staff'
          } do
            collection do
              resources :permissions, only: :index, controller: 'staffs/permissions'
              resources :meta, only: :index, controller: 'staffs/meta'
              resources :downloads, only: :create, controller: 'staffs/downloads'
            end
          end
          resources :permissions, only: [:index, :create], permission: {
            index: 'read/permission',
            create: 'write/permission'
          }
          resource :permissions, only: :destroy, permission: {
            destroy: 'write/permission'
          }
        end
        namespace :diaries do
          resources :posts, only: [:index, :show, :destroy, :update], permission: {
            index: 'read/post',
            show: 'read/post',
            destroy: 'write/post',
            update: 'write/post'
          }
        end
        namespace :hotels do
          resources :categories, only: [:index, :create]
          resources :meta, only: :index, permission: { index: 'read/hotel' }
          resources :orders, path: 'reservations', only: [:create, :update, :index, :show] , permission: {
            create: 'write/hotel_order',
            update: 'write/hotel_order',
            index: 'read/hotel_order',
            show: 'read/hotel_order'
          } do
            get 'confirm/download', to: 'orders/downloads#confirm_hotel_order'
            collection do
              resources :downloads, only: %i[create index], controller: 'orders/downloads'
            end
          end
          resources :requests, only: %i[index create show update destroy], permission: {
            index: 'read/hotel_request',
            create: 'write/hotel_request',
            show: 'read/hotel_request',
            update: 'write/hotel_request',
            destroy: 'read/hotel_request'
          }
          resources :aggregate_orders, path: 'aggregates', only: :index
        end
        resources :hotels, only: [:create, :show, :index, :destroy, :update], permission: {
          create: 'write/hotel',
          show: 'read/hotel',
          index: 'read/hotel',
          destroy: 'write/hotel',
          update: 'write/hotel'
        } do
          resources :meals, only: [:index, :show, :create, :update, :destroy], controller: 'hotels/meals', permission: {
            index: 'read/hotel_meal',
            show: 'read/hotel_meal',
            create: 'write/hotel_meal',
            update: 'write/hotel_meal',
            destroy: 'write/hotel_meal'
          } do
            collection do
              resources :meta, only: :index, controller: 'hotels/meals/meta'
            end
          end
          resources :childrens, only: [:index, :show, :create, :destroy, :update], controller: 'hotels/childrens', permission: {
            index: 'read/hotel_child',
            show: 'read/hotel_child',
            destroy: 'write/hotel_child',
            create: 'write/hotel_child',
            update: 'write/hotel_child'
          } do
            collection do
              resources :meta, only: :index, controller: 'hotels/childrens/meta'
            end
          end
          resources :options, only: [:create, :update, :index, :show, :destroy], controller: 'hotels/options', permission: {
            create: 'write/hotel_option',
            update: 'write/hotel_option',
            index: 'read/hotel_option',
            show: 'read/hotel_option',
            destroy: 'write/hotel_option'
          } do
            collection do
              resources :meta, only: :index, controller: 'hotels/options/meta'
            end
          end
          member do
            resources :cancellation_policies, path: 'cancellations', only: [:create, :index, :destroy], permission: {
              create: 'write/hotel_cancellationpolicy',
              index: 'read/hotel_cancellationpolicy',
              destroy: 'write/hotel_cancellationpolicy'
            }, controller: "hotels/cancellation_policies"
            resources :rooms, only: [:index], controller: 'hotels/rooms', permission: {
              index: 'read/hotel_room',
            }
          end
          resources :cancellation_policies, path: 'cancellations', only: [:update, :show], permission: {
            update: 'write/hotel_cancellationpolicy',
            show: 'read/hotel_cancellationpolicy'
          },controller: "hotels/cancellation_policies" do
            collection do
              resources :meta, only: :index, controller: 'hotels/cancellation_policies/meta'
            end
            resources :cancellation_details, path: 'items', only: [:create, :destroy, :update], permission: {
              create: 'write/hotel_cancellationpolicy',
              destroy: 'write/hotel_cancellationpolicy',
              update: 'write/hotel_cancellationpolicy'
            }, controller: 'hotels/cancellation_details'
          end
          resources :rooms, only: [:create, :update, :show, :destroy], controller: 'hotels/rooms', permission: {
            create: 'write/hotel_room',
            update: 'write/hotel_room',
            show: 'read/hotel_room',
            destroy: 'write/hotel_room'
          } do
            collection do
              resources :meta, only: :index, controller: 'hotels/rooms/meta'
            end
          end
          collection do
            resources :downloads, only: :create, controller: 'hotels/downloads'
          end
          resources :plans, only: [:create, :destroy, :update, :show, :index], controller: 'hotels/plans', permission: {
            create: 'write/hotel_plan',
            destroy: 'write/hotel_plan',
            update: 'write/hotel_plan',
            show: 'read/hotel_plan',
            index: 'read/hotel_plan'
          } do
            collection do
              resources :meta, only: :index, controller: 'hotels/plans/meta'
            end
            resources :plan_options, path: 'settings', only: [:create, :index, :show, :destroy, :update], controller: 'hotels/plan_options', permission: {
              create: 'write/hotel_plan_option',
              index: 'read/hotel_plan_option',
              show: 'read/hotel_plan_option',
              destroy: 'write/hotel_plan_option',
              update: 'write/hotel_plan_option'
            }
            resources :rooms, only: :index,controller: 'hotels/plans/rooms', permission: {
               index: 'read/hotel_room'
            } do
              resources :room_settings, only: :index, controller: 'hotels/plans/room_settings'
            end
          end
        end
        resources :tours, only: [:index, :create, :destroy, :update, :show], permission: {
          create: 'write/tour',
          show:'read/tour',
          update:'write/tour',
          index: 'read/tour',
          destroy: 'read/tour'
        } do
          resources :place_starts, only: %i[create index update show], controller: 'tours/place_starts'
          resources :generate_code_place, only: :create, controller: 'tours/place_starts/generate_code'
          resources :locations do
            collection do
              resources :meta, only: :index, controller: 'tours/start_locations/meta'
            end
          end
          collection do
            resources :points, only: [:create, :index], controller: 'tours/points'
            resources :orders, only: %i[create show update], controller: 'tours/orders', permission: {
              create: 'write/tour_management_order',
              show:'read/tour_management_order',
              update:'write/tour_management_order'
            }
            resources :managements, only: [:index, :destroy, :show], permission: {
              index: 'read/tour_management',
              destroy: 'write/tour_management',
              show: 'read/tour_management'
            }, controller: 'tours/managements' do
              collection do
                resources :downloads, only: :create, controller: 'tours/managements/downloads'
                resources :imports, only: :create, controller: 'tours/managements/imports'
              end
              resources :imports, only: :create, controller: 'tours/managements/imports'
              resources :management_files, only: :index, controller: 'tours/managements/management_files'
              resources :bus_infos, path: 'bus', only: [:create, :index, :show, :update, :destroy], permission: {
                create: 'write/tour_management_businfo',
                index: 'read/tour_management_businfo',
                show: 'read/tour_management_businfo',
                update: 'write/tour_management_businfo',
                destroy: 'write/tour_management_businfo',
              }, controller: 'tours/bus_infos' do
                resources :orders, only: [:index], permission: {
                  index: 'read/tour_management_businfo_order'
                }, controller: 'tours/managements/bus/orders' do
                  resources :accompanies, only: :update, controller: 'tours/managements/bus/order/accompanies'
                end
                resources :downloads, only: :index, permission: {
                  index: 'read/tour_management_businfo'
                }, controller: 'tours/bus_infos/downloads' do
                  collection do
                    get 'seat_map'
                  end
                end
                resources :download_csv, only: :create, controller: 'tours/bus_infos/download_csv'
                collection do
                  resources :meta, only: :index, controller: 'tours/bus_infos/meta'
                  resources :list_cancel do
                    collection do
                      resources :downloads, only: :create, controller: 'tours/managements/bus/orders/list_cancel/downloads'
                    end
                  end
                end
              end
            end
            resources :meta, only: :index, controller: 'tours/meta'
            resources :cancellation_policies, path: 'cancellations', only: [:create, :index, :show, :destroy], permission: {
              create: 'write/tour_management_cancellationpolicy',
              index: 'read/tour_management_cancellationpolicy',
              show: 'read/tour_management_cancellationpolicy',
              destroy: 'write/tour_management_cancellationpolicy'
            }, controller: 'tours/cancellation_policies' do
              collection do
                resources :meta, only: :index, controller: 'tours/cancellation_policies/meta'
              end
              resources :cancellation_details, path: 'items', only: [:create, :destroy, :update], permission: {
                create: 'write/tour_management_cancellationpolicy',
                destroy: 'write/tour_management_cancellationpolicy',
                update: 'write/tour_management_cancellationpolicy'
              }, controller: 'tours/cancellation_details'
            end
            resources :companies, only: [:index, :destroy, :update, :create, :show], permission: {
              index: 'read/tour_company',
              destroy: 'write/tour_company',
              update: 'write/tour_company',
              create: 'write/tour_company',
              show: 'read/tour_company'
            }, controller: 'tours/companies' do
              collection do
                resources :meta, only: :index, controller: 'tours/companies/meta'
              end
            end
            resources :hostels, only: [:index, :show, :update, :create, :destroy], permission: {
              index: 'read/tour_hostel',
              show: 'read/tour_hostel',
              update: 'write/tour_hostel',
              create: 'write/tour_hostel',
              destroy: 'write/tour_hostel'
            }, controller: 'tours/hostels' do
              collection do
                resources :meta, only: :index, controller: 'tours/hostels/meta'
              end
            end
            resources :bus_patterns, path: 'bus', only: [:show, :create, :update, :destroy], permission: {
              show: 'read/tour_management_buspattern',
              create: 'write/tour_management_buspattern',
              update: 'write/tour_management_buspattern',
              destroy: 'write/tour_management_buspattern',
            }, controller: 'tours/bus_patterns' do
              collection do
                resources :meta, only: :index, controller: 'tours/bus_patterns/meta'
              end
            end
            resources :destination_locations, only: [:index], controller: 'tours/destination_locations'
            resources :downloads, only: :create, controller: 'tours/downloads'
          end
          resources :order_specials, only: %i[show index], controller: 'tours/order_specials' do
            resources :temporaries, only: %i[index update show destroy], controller: 'tours/order_specials/temporaries' do
              collection do
                resources :import, only: :create, controller: 'tours/order_specials/temporaries/import'
              end
            end
            resources :search, only: :index, controller: 'tours/order_specials/search'
          end
        end
        namespace :tours  do
          namespace :categories do
            resources :meta, only: :index
          end
        end
        resources :banners, only: [:create, :update, :index, :show, :destroy], permission: {
          create: 'write/banner',
          index: 'read/banner',
          show: 'read/banner',
          destroy: 'write/banner',
          update: 'write/banner'
        } do
          collection do
            resources :requests, only: [:index, :update, :destroy], controller: 'banners/requests'
          end
        end
        resources :life_supports, only: [:create, :index, :show, :destroy, :update], permission: {
          create: 'write/lifesupport',
          index: 'read/lifesupport',
          show: 'read/lifesupport',
          destroy: 'write/lifesupport',
          update: 'write/lifesupport'
        } do
          collection do
            resources :requests, only: [:index, :update, :destroy], controller: 'life_supports/requests'
          end
        end
        resources :holidays, only: [:create, :show, :index, :update, :destroy], permission: {
          create: 'write/holiday',
          index: 'read/holiday',
          show: 'read/holiday',
          destroy: 'write/holiday',
          update: 'write/holiday'
        }
      end
    end
  end
end
