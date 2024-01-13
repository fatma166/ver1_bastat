<?php

namespace App\Providers;
//use App\Models\Setting;
use App\Models\BusinessSetting;
use Illuminate\Support\Facades\View;
use Illuminate\Pagination\Paginator;
use Illuminate\Support\ServiceProvider;
use Illuminate\Support\Facades\Config;
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
        $userTimezone1=BusinessSetting::where('key','timezone')->first();//'Asia/Riyadh';
        $userTimezone=$userTimezone1->value??"Africa/Cairo";
// Set the application's timezone dynamically
        Config::set('app.timezone',$userTimezone);
        date_default_timezone_set($userTimezone);
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
