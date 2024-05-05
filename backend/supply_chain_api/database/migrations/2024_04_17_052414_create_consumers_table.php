<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateConsumersTable extends Migration
{
    public function up()
    {
        Schema::create('consumers', function (Blueprint $table) {
            $table->id();
            $table->string('name');
            $table->string('email')->unique();
            $table->string('password');
            // ... (Additional consumer-specific fields, e.g., address, phone number) ...
            $table->timestamps();
        });
    }

    public function down()
    {
        Schema::dropIfExists('consumers');
    }
}
