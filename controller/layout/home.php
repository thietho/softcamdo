<?php
class ControllerLayoutHome extends Controller
{
	public function index()
	{

        $this->template="layout/home.tpl";
        if ($this->user->isLogged())
        {
            $this->children=array(
                'common/header',

            );
        }

        $this->render();

	}
}
?>