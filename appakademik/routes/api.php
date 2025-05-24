<?php

use App\Http\Controllers\JadwalController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

use App\Http\Controllers\MahasiswaController;
use App\Http\Controllers\MataKuliahController;

Route::apiResource('mahasiswa', MahasiswaController::class);
Route::apiResource('mata_kuliahs', MataKuliahController::class);

Route::get('/jadwals', [JadwalController::class, 'index']);
Route::post('/jadwals', [JadwalController::class, 'store']);
Route::get('/jadwals/{id}', [JadwalController::class, 'show']);
Route::put('/jadwals/{id}', [JadwalController::class, 'update']);
Route::delete('/jadwals/{id}', [JadwalController::class, 'destroy']);

/*
|--------------------------------------------------------------------------
| API Routes
|--------------------------------------------------------------------------
|
| Here is where you can register API routes for your application. These
| routes are loaded by the RouteServiceProvider and all of them will
| be assigned to the "api" middleware group. Make something great!
|
*/

Route::middleware('auth:sanctum')->get('/user', function (Request $request) {
    return $request->user();
});
