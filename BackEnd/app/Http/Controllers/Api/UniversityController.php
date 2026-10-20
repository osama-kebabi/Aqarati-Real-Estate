<?php

namespace App\Http\Controllers\Api;
use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use App\Models\University;

class UniversityController extends Controller
{
   public function index()
    {
        $universities = University::all();

        return response()->json([
            'data' => $universities
        ]);
    }
}
