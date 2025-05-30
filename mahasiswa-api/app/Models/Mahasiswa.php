<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Mahasiswa extends Model
{
    use HasFactory;

    protected $table="Mahasiswa";

    protected $fillable = [
        'npm',
        'nama',
        'tempat_lahir',
        'tanggal_lahir',
        'sex',
        'alamat',
        'telp',
        'email',
        'photo'
    ];
}
