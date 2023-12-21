<?php

namespace App\Http\Controllers\Vendor;

use App\Http\Controllers\Admin\BaseController;
use App\Models\Category;
use App\Modules\Core\Helper;
use App\Repositories\Admin\Vendor\ProductRepository;
use App\Traits\UploadAttachTrait;
use Illuminate\Http\Request;
class ProductController extends BaseController
{
    use UploadAttachTrait;
    protected $view;
    protected $repository;
   // protected $slider_image;

    public function __construct(ProductRepository $repository)
    {
        parent::__construct($repository);
        $this->view = 'vendor-views.product';
      //  $this->slider_image=[];

    }
    public function index(Request $request, $with = [], $withCount = [], $filter = '', $paginate = 10, $whereHas = [])
    {
       $products= parent::index($request, ['category'], [], 'restaurant_id|' . Helper::get_restaurant_id(). '|=', 10, []);
//print_r($products); exit;
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
        return view($this->view . '.index', compact('products'));
    }

    public function create()
    {

        //$governorates = Governorate::orderBy('name_' . app()->getLocale())->get();
        $categories = Category::where(['parent_id' => 0,'status'=>1,'restaurant_id'=>Helper::get_restaurant_id()])->get();
        return view($this->view . '.create',compact('categories'));
    }

    public function store(Request $request)
    {
        parent::store($request);
        session()->forget('slider_images');
        session()->flash('success', __('created successfully'));
        return redirect(route('vendor.product.index'));

    }

    public function edit($id)
    {
        $categories = Category::where(['parent_id' => 0,'status'=>1,'restaurant_id'=>Helper::get_restaurant_id()])->get();
        //$record = parent::show($id, 'city');
        $record= parent::show($id,['slider']);
      //  print_r($record->slider); exit;
        session()->put('old_image', $record->image);

        return view($this->view . '.edit', compact('record','categories'));
    }

    public function update(Request $request, $id)
    {



//print_r(session('slider_images'));

      // $slider_images= session('slider_images');
//$request->slider=$this->slider_image;

        parent::update($request, $id);
        session()->forget('slider_images');
        session()->forget('old_image');
        session()->flash('success', __('updated successfully'));
       return redirect(route('vendor.product.index'));
    }
    public function change_status(Request $request)
    {
        $status= $request['status'];
        $id= $request['id'];
        if(isset($request['type']))
            $status= !$status;
        $data= $this->repository->change_status($id,$status);

       return back()->with('success','category Status Changed succesfully');
    }
    public  function destroy($id)
    {

        return parent::destroy($id); // TODO: Change the autogenerated stub
    }
    public function upload_images(Request $request){
//
        $images= array($request['file']);

        $folder='product';
        $upload_images=$this->upload($images,$folder);
       // $ajax=1;
        //return view($this->view . '.edit', compact('upload_images','ajax'));
     //   return($upload_images);

        $request->session()->put('slider_images', $upload_images);
        return response()->json([
            'name'          => $upload_images[0],
            'original_name' => $request['file']->getClientOriginalName(),
        ]);
        //print_r($this->slider_image);
      //  return($this->slider_image);
    }

    public function delete_image(Request $request){

        $this->repository->destory_image($request);

    }
    public function fav_status($id,$status)
    {
            $status= !$status;
        $this->repository->fav_status($id,$status);

      //  redirect(route('vendor.product.index'));
       return back()->with('success',__('favourite changed  successfully'));
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