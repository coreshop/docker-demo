<?php

namespace AppBundle\Controller;

use Pimcore\Controller\FrontendController;
use Symfony\Component\HttpFoundation\Request;

class DefaultController extends FrontendController
{
    /**
     * @param Request $request
     */
    public function defaultAction(Request $request)
    {
        return $this->redirectToRoute('coreshop_index', ['_locale' => 'en']);
    }
}
