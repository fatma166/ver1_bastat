<?php

namespace App\Repositories\Admin\Vendor;

use App\Http\Requests\Vendor\ProductRequest;
use App\Models\Food;
use App\Models\Food_slider_image;
use App\Models\Restaurant;
use App\Repositories\Admin\BaseRepository;
use App\Traits\UploadAttachTrait;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\File;

class ProductRepository extends BaseRepository
{
    use UploadAttachTrait;

    public function __construct()
    {
        parent::__construct(new Food());

    }
    function setDataPayload(Request $request = null, $type = 'store')
    {

        // try {
        if($type=='store'){
            $validate= new ProductRequest() ;

            $request = $request->validate($validate->rules(),[],$validate->attributes());
        }else{
            $request_data=$request->all();

            $id=$request_data['id'];
            $validate= new ProductRequest() ;

            $request = $request->validate($validate->rules(),[],$validate->attributes());
            $request['id']=$id;
        }
        $data=$request;

        /*if (isset($data['image'])&&!empty($data['image'])) {
            $data['image'] =  $this->upload($data['image'], 'product');
            //unset($data['image']);
        }*/
        return($data);
    }
    public function store(Request $request = null, $data = null)
    {
        if ($request != null)
            $data = $this->setDataPayload($request, 'store');
//print_r($request->all());
        if($request->has('image')) {
            $images = ($this->upload(array($request->image), 'product'));
            unset($request->image);
        }
        // $request->image=$images;
        $request= $request->except(['_token','image']);
        $vendor_id= auth('vendor')->user()->id;
        $restaurant=Restaurant::where('vendor_id',$vendor_id)->first();
        $request['restaurant_id']=$restaurant['id'];
        if(isset($images[0]))
            $request['image']=$images[0];

        /*   if ($request != null)
               $data = $this->setDataPayload($request, 'update');
   */
        //$item = $this->model;
         $category=[];
        array_push($category, [
            'id' => $request['category_id'],
            'position' => 3,
        ]);
        $request['category_ids']=json_encode($category);
        print_r($request);
        $id= Food::insertGetId($request);
       // $item->fill($request);
      //  $item->save();
       // $id=$item->id;

        $slider_images=session('slider_images');
        $images=[];
        if(!empty($slider_images)&&count($slider_images)>0) {
            foreach ($slider_images as $key => $slider_image) {

                $images[$key]['image_path']=$slider_image;
                $images[$key]['food_id'] = $id;
            }

            Food_slider_image::insert($images);

        }
        return $id;
    }

    public function update($id, Request $request = null, $data = null)
    {

        if ($request != null)
            $data = $this->setDataPayload($request, 'update');

       if($request->has('image')) {

          // if(session('old_image')!=$request->image){

               $images = ($this->upload(array($request->image), 'product'));
          // }

           unset($request->image);
       }

        // $request->image=$images;
        $request= $request->except(['_token','image','old_image']);

        if(isset($images[0]))
            $request['image']=$images[0];

     /*   if ($request != null)
            $data = $this->setDataPayload($request, 'update');
*/
        $request['category_ids']=array(['id'=>$request['category_id'],'position'=>0]);
        $item = $this->model->findOrFail($id);

        $item->fill($request);
        $item->save();
        $slider_images=session('slider_images');
        //print_r($slider_images);
        $images=[];
        if(!empty($slider_images)&&count($slider_images)>0) {
            Food_slider_image::where('food_id',$id)->delete();
            $images=Food_slider_image::where('food_id',$id)->get()->toArray();
            foreach($images as $image){
                if(file_exists($image['image_path'])){
                    unlink($image['image_path']);
                }
            }
            foreach ($slider_images as $key => $slider_image) {

                $images[$key]['image_path']=$slider_image;
                $images[$key]['food_id'] = $id;
            }
            Food_slider_image::insert($images);


        }
        return $item;
    }
    public function change_status($id,$status){
        $this->model->where('id',$id)->update(['status'=>$status]);
    }
    public function fav_status($id,$status){
        $this->model->where('id',$id)->update(['favourite'=>$status]);

    }
    public function delete($id)
    {
        if ($id == 0) {
            $id = request()->recordIds;// TODO: delete multiple by ids
        }
        $this->model->destroy($id);
        $images=Food_slider_image::where('food_id',$id)->get()->toArray();
         foreach($images as $image){
             if(file_exists($image['image_path'])){
                 unlink($image['image_path']);
             }
         }
        Food_slider_image::where('food_id',$id)->delete();
        return true;
    }
    public function destory_image($request){
        if(File::exists($request->image)) {
            unlink($request->image);
        }

        Food_slider_image::where(['food_id'=>$request->id,'image_path'=>$request->image])->delete();
    }



}
