<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Factories\HasFactory;
use Illuminate\Database\Eloquent\Model;

class Student_Accounts extends Model
{
    use HasFactory;
    protected $table = 'student_accounts';
    protected $fillable = [
        'uname',
        'password'
    ];
}
