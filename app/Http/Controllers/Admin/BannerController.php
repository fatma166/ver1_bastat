<?php

namespace App\Http\Controllers\Admin;

use App\Models\Compilation;
use App\Models\Zone;
use App\Repositories\Admin\SingleRebo\BannerRepository;
use App\Traits\UploadAttachTrait;
use Illuminate\Http\Request;
use App\Models\Restaurant;

class BannerController extends BaseController
{
    use UploadAttachTrait;
    protected $view;
    protected $repository;

    public function __construct(BannerRepository $repository)
    {
        parent::__construct($repository);
        $this->view = 'admin-views.banner.';

    }
    public function index(Request $request, $with = [], $withCount = [], $filter = '', $paginate = 10, $whereHas = [])
    {
       $banners = parent::index($request, [], [], '', 10, []);

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
        return view($this->view . 'index', compact('banners'));
    }

    public function create()
    {
        //$governorates = Governorate::orderBy('name_' . app()->getLocale())->get();
        $zones=Zone::get();
        $compilations=Compilation::where('status',1)->get();
        $places=Restaurant::where('status',1)->get();
        return view($this->view . 'create', compact('compilations','places','zones'));
    }

    public function store(Request $request)
    {
        parent::store($request);
       return redirect(route('admin.banner.index'));
    }

    public function edit($id)
    {
       // $governorates = Governorate::orderBy('name_' . app()->getLocale())->get();
        //$record = parent::show($id, 'city');
        $banner= parent::show($id);
        $zones=Zone::get();
        $compilations=Compilation::where('status',1)->get();
        $places=Restaurant::where('status',1)->get();
        return view($this->view . 'edit', compact('banner','compilations','places','zones'));
    }

    public function update(Request $request, $id)
    {





        parent::update($request, $id);
       return redirect(route('admin.banner.index'));
    }
    public function place_comp(Request $request){
        $compilation_id=$request->compilation_id;
       $items= $this->repository->place_comp($compilation_id);
        return($items);
    }
    public function change_status(Request $request)
    {
        $status= $request['status'];
        if($request['status']=="")$status=0;
        $id= $request['id'];

        if(isset($request['type']))
            $status= !$status;
        $data= $this->repository->change_status($id,$status);

        return back()->with('success','Copoun Status Changed succesfully');
    }
    /*function index(Request $request)
    {

       // $banners = Banner::latest()->paginate(config('default_pagination'));
        $banners =$this->repository->get($request,[],[], '',config('default_pagination'), []);
        print_r($banners); exit;
        return view('admin-views.banner.index', compact('banners'));
    }

    public function store(Request $request)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|max:191',
            'image' => 'required',
            'banner_type' => 'required',
            'zone_id' => 'required',
            'restaurant_id' => 'required_if:banner_type,restaurant_wise',
            'item_id' => 'required_if:banner_type,item_wise',
        ], [
            'zone_id.required' => trans('messages.select_a_zone'),
            'restaurant_id.required_if'=> trans('messages.Restaurant is required when banner type is restaurant wise'),
            'item_id.required_if'=> trans('messages.Food is required when banner type is food wise'),
        ]);

        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)]);
        }

        $banner = new Banner;
        $banner->title = $request->title;
        $banner->type = $request->banner_type;
        $banner->zone_id = $request->zone_id;
        $banner->image = Helpers::upload('banner/', 'png', $request->file('image'));
        $banner->data = ($request->banner_type == 'restaurant_wise')?$request->restaurant_id:$request->item_id;
        $banner->save();

        return response()->json([], 200);
    }

    public function edit(Banner $banner)
    {
        return view('admin-views.banner.edit', compact('banner'));
    }

    // public function view(Banner $banner)
    // {
    //     $restaurant_ids = json_decode($banner->restaurant_ids);
    //     $restaurants = Restaurant::whereIn('id', $restaurant_ids)->paginate(10);
    //     return view('admin-views.banner.view', compact('banner', 'restaurants', 'restaurant_ids'));
    // }

    public function status(Request $request)
    {
        $banner = Banner::findOrFail($request->id);
        $banner->status = $request->status;
        $banner->save();
        Toastr::success(trans('messages.banner_status_updated'));
        return back();
    }

    public function update(Request $request, Banner $banner)
    {
        $validator = Validator::make($request->all(), [
            'title' => 'required|max:191',
            'banner_type' => 'required',
            'zone_id' => 'required',
            'restaurant_id' => 'required_if:banner_type,restaurant_wise',
            'item_id' => 'required_if:banner_type,item_wise',
        ], [
            'zone_id.required' => trans('messages.select_a_zone'),
            'restaurant_id.required_if'=> trans('messages.Restaurant is required when banner type is restaurant wise'),
            'item_id.required_if'=> trans('messages.Food is required when banner type is food wise'),
        ]);


        if ($validator->fails()) {
            return response()->json(['errors' => Helpers::error_processor($validator)]);
        }

        $banner->title = $request->title;
        $banner->type = $request->banner_type;
        $banner->zone_id = $request->zone_id;
        $banner->image = $request->has('image') ? Helpers::update('banner/', $banner->image, 'png', $request->file('image')) : $banner->image;
        $banner->data = $request->banner_type=='restaurant_wise'?$request->restaurant_id:$request->item_id;
        $banner->save();

        return response()->json([], 200);
        // Toastr::success(trans('messages.banner_updated_successfully'));
        // return redirect('admin/banner/add-new');
    }

    public function delete(Banner $banner)
    {
        if (Storage::disk('public')->exists('banner/' . $banner['image'])) {
            Storage::disk('public')->delete('banner/' . $banner['image']);
        }
        $banner->delete();
        Toastr::success(trans('messages.banner_deleted_successfully'));
        return back();
    }

    public function search(Request $request){
        $key = explode(' ', $request['search']);
        $banners=Banner::where(function ($q) use ($key) {
            foreach ($key as $value) {
                $q->orWhere('title', 'like', "%{$value}%");
            }
        })->limit(50)->get();
        return response()->json([
            'view'=>view('admin-views.banner.partials._table',compact('banners'))->render(),
            'count'=>$banners->count()
        ]);
    }*/
}
