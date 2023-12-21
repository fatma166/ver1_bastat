<?php

namespace App\Http\Controllers\Vendor;

use App\Modules\Core\Helper;
use App\Repositories\Admin\Vendor\OrderRepository;
use Illuminate\Http\Request;
use App\Http\Controllers\Admin\BaseController;
class OrderController extends BaseController
{

    protected $view;
    protected $repository;

    public function __construct(OrderRepository $repository)
    {
        parent::__construct($repository);
        $this->view = 'vendor-views.order';

    }
    public function index(Request $request, $with = [], $withCount = [], $filter = '', $paginate = 10, $whereHas = [])
    {


       $orders= parent::index($request, ['restaurant'=>function ($query) {$query->with('vendor');}], [], 'restaurant_id|' . Helper::get_restaurant_id(). '|=', 10, []);
//print_R($orders); exit;
       /* if ($request->filled("export_excel") && $request->export_excel == true) {


            foreach ($reviews as $index => $record) {
                $data[$index]['#'] = $index + 1;
                $data[$index]['patient_name'] = optional($record->user)->full_name;
                $data[$index]['doctor_name'] = optional($record->doctor)->full_name;
                $data[$index]['comment'] = $record->comment_text;
                $data[$index]['grade'] = $record->grade;
                $data[$index]['created_at'] = $record->created_at ? Carbon::parse($record->created_at)->format("Y-m-d h:i A"): "";
            }
            $file_name="reviews";
            $headers = ["#", __('patient name'), __('doctor name'), __('comment'), __('grade'), __('date')];
            return  $this->exportList($data,$file_name,$headers);
        }

        */
        return view($this->view . '.index', compact('orders'));
    }



    public  function details(Request $request,$id){

        $order= parent::index($request,['restaurant','customer_address','details'=>function ($query) use($id) {$query->where('order_id',$id);$query->with('food');},'customer','transaction'=>function ($query) use($id) {$query->where('order_id',$id);}],[],'id|' . $id . '|=','');
        if(isset($order[0]))
        $order=$order[0];

       return view($this->view . '.details', compact('order'));
    }
    public function change_status(Request $request)
    {
        $status = $request['status'];


        $id = $request['id'];
        $data = $this->repository->change_status($id, $status);

        session()->flash('success', __('updated successfully'));
    }

}
