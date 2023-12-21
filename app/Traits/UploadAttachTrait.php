<?php
namespace App\Traits;
use Illuminate\Http\Request;
trait UploadAttachTrait {
    public function Upload($data,$folder) {

        // if($data->hasFile('attach'))
        // {
        $allowedfileExtension=['pdf','jpg','png','docx','PNG'];
        // $files = $data->file('attach');
        $images=array();

        foreach($data as $file){

            $filename = $file->getClientOriginalName();

            $extension = $file->getClientOriginalExtension();

            $check=in_array($extension,$allowedfileExtension);

            if($check)
            {
                if (!file_exists(public_path().'/images/'.$folder)) {
                    mkdir(public_path().'/images/'.$folder, 0777, true);
                }
                $file->move(public_path().'/images/'.$folder.'/',time().'.'.$extension);
                $images[]='images/'.$folder.'/'.time().'.'.$extension;


            }

        }



        return $images;
    }

    public function UploadFiles($file, $folder){

        $filename = $file->getClientOriginalName();
        $f_name_array = explode('.', $filename);
        $f_file_ext = end($f_name_array);
        $file_name = microtime().'.'.$f_file_ext;
        $file->move('images/'.$folder, $file_name);
        return $folder.'/'.$file_name;
    }
}
