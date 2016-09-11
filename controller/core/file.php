<?php
/**
 * Class ControllerCoreItems
 *
 * @property ModelCoreItems model_core_items
 * @property ModelCoreCategory model_core_category
 * @property ModelAddonGroup model_addon_group
 *
 */
class ControllerCoreItems extends Controller
{
    private $error = array();
    function __construct()
    {

    }
    public function index()
    {
        $this->getList();
    }
    private function getList()
    {
        @$this->load->helper('image');
        //HTTP_IMAGE . 'upload/*';
        $this->data['folderchild'] = array();
        $this->data['files'] = array();
        $folder = urldecode(@$this->request->get['folder']);
        if($folder=="")
            $files = glob(DIR_FILE.'upload/*');
        else
        {
            $files = glob(DIR_FILE.'upload/'.$folder.'/*');
            $this->data['folderchild'][-1]['foldername'] = @$this->string->getFileName("..");
            $this->data['folderchild'][-1]['folderpath'] = $folder;
        }

        $keyword = urldecode(@$this->request->get['keyword']);
        if(count($files)>0)
        {

            foreach($files as $i => $file)
            {
                $info = pathinfo($file);

                if(@substr_count(strtolower($info['basename']), strtolower($keyword))>0 || $keyword == "")
                {

                    if(is_dir($file))
                    {

                        @$this->data['folderchild'][$i]['foldername'] = @$this->string->getFileName($file);
                        @$this->data['folderchild'][$i]['folderpath'] = $file;
                    }
                    else
                    {
                        $ext = @$this->string->getFileExt($file);
                        if(@$this->string->isImage($ext))
                            @$this->data['files'][$i]['imagethumbnail'] = HelperImage::resizePNG(str_replace(DIR_FILE,"",$file), 130, 130);
                        else
                        {
                            $urlext = HTTP_IMAGE."icon/48px/".$ext.".png";
                            if(!@fopen($urlext,"r"))
                                $urlext = HTTP_IMAGE."icon/48px/_blank.png";
                            @$this->data['files'][$i]['imagethumbnail'] = $urlext;
                        }
                        @$this->data['files'][$i]['filename'] = @$this->string->getFileName($file);
                        @$this->data['files'][$i]['filepath'] = $file;
                    }
                }

            }
        }
        $this->id='content';
        $this->template="core/file_list.tpl";
        $this->layout="layout/home";
        $this->render();
    }



}
?>