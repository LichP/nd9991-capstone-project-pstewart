<?php

namespace App\Http\Controllers;

use Illuminate\Http\Request;
use Illuminate\Routing\Controller as BaseController;
use Illuminate\View\View;

class WelcomeController extends BaseController
{
    public function index(Request $request): View
    {
        return view('welcome.welcome', ['name' => 'Guest']);
    }

    public function welcome(Request $request, string $name): View
    {
        $name = ucfirst(strtolower($name));

         return view('welcome.welcome', ['name' => $name]);
    }
}
