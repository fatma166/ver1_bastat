<?php
namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use App\Models\DeliveryMan;
use App\Models\Food;
use App\Models\Order;
use App\Models\OrderDetail;
use App\Models\OrderPaymentTransaction;
use App\Models\Restaurant;
use App\Models\User;
use App\Models\Vendor;
use App\Models\Wishlist;
use App\Models\OrderTransaction;
use Carbon\Carbon;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class DashboardController extends Controller
{
    public function index(){

        return view('admin-views.index');
    }
    public function dashboard(Request $request)
    {

      /*  $params = [
            'zone_id' => $request['zone_id'] ?? 'all',
            'statistics_type' => $request['statistics_type'] ?? 'overall',
            'user_overview' => $request['user_overview'] ?? 'overall',
            'business_overview' => $request['business_overview'] ?? 'overall',
        ];
        session()->put('dash_params', $params);
        $data = self::dashboard_data();
        $total_sell = $data['total_sell'];
        $commission = $data['commission'];*/
        $data['monthly_order_amount'] = OrderPaymentTransaction::NotRefunded()->whereMonth('created_at', date('m'))
                                                ->whereYear('created_at', date('Y'))->sum('order_amount');
        $data['monthly_user_count'] = User::whereMonth('created_at', date('m'))
            ->whereYear('created_at', date('Y'))->count();
        $data['monthly_order_count']= OrderPaymentTransaction::whereMonth('created_at', date('m'))
            ->whereYear('created_at', date('Y'))->count();
        $data['monthly_vendor_count']=Vendor::whereMonth('created_at', date('m'))
            ->whereYear('created_at', date('Y'))->count();
        $data['top_restaurants'] =Restaurant::Active()->with('compilation')->withCount('orders')

                                            ->orderBy('orders_count', 'desc')
                                            ->limit(6)
                                            ->get();
        $data['top_products'] =OrderDetail::with(['food'=>function($query){
                      $query->with('restaurant');
        }])->withCount('food')
            ->orderBy('food_count', 'desc')
            ->limit(6)
            ->get();
       // dd($data['top_products'] ); exit;
        return view('admin-views.index', compact('data'));
    }



    public function dashboard_data()
    {

        $date1= Carbon::now();



        $month=($date1->month)-1;

        $year= $date1->year;

        $number_days = Carbon::now()->daysInMonth;

        $report=array();

        for($day=1;$day<=$number_days;$day++){
            $estimated=strtotime($year."-".$month."-".$day);
            $date=date('Y-m-d',$estimated);
            $report['order'][$day]=Order::whereDate('created_at',$date)/*->where('order_status','delivered')*/->count();
            $report['order_amount'][$day]=(int)Order::whereDate('created_at', $date)/*->where('order_status','delivered')*/->sum('order_amount');
            $report['date_format'][$day]= $date;//Carbon::parse($date)->translatedFormat('l j F Y');
        }

        return $report;
    }
}
