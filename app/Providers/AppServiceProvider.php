<?php

namespace App\Providers;
//use App\Models\Setting;
use Illuminate\Support\Facades\View;
use Illuminate\Pagination\Paginator;
use Illuminate\Support\ServiceProvider;

class AppServiceProvider extends ServiceProvider
{
    /**
     * Register any application services.
     *
     * @return void
     */
    public function register()
    {
        //
    }

    /**
     * Bootstrap any application services.
     *
     * @return void
     */
    public function boot()
    {
        //
        Paginator::useBootstrap();

        view()->composer('*', function($view)
        {
            $session = session()->get('color_scheme_mode');
            if (!$session)
                session()->put('color_scheme_mode', "light");

            $view->with(['color_scheme_mode' => session()->get("color_scheme_mode", "light")]);
        });

        view()->composer(['layouts.master', 'admin.auth.login'], function($view){
          //  $view->with('settings', Setting::first());
        });
    }
}
