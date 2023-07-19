<?php

use App\Http\Controllers\WelcomeController;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "web" middleware group. Make something great!
|
*/

Route::redirect('/', '/welcome');


# Welcome routes
Route::name('welcome.')->prefix('welcome')->group(function() {
    Route::get('/', [WelcomeController::class, 'index'])
        ->name('index');

    Route::get('{name}', [WelcomeController::class, 'welcome'])
        ->name('welcome');

});
